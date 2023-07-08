extends KinematicBody2D


const BULLET = preload("res://scene/Bullet.tscn")
const EnemyBullet = preload("res://scene/BulletEnemy.tscn")
var velocity = Vector2.ZERO
var direction = Vector2.ZERO
var shootingTimer = Timer.new()
var isShootingEnabled = true
var turn_speed = 0.075
onready var healthPoint = features["maxHealth"]
var features := {
	"maxHealth":10,
	"speed": 19000,
	"shootingInterval": 1,
	"level":1,
	"ex":0,
	"damage":1
}


func _ready():
	shootingTimer.wait_time = features["shootingInterval"]
	shootingTimer.one_shot = false
	shootingTimer.connect("timeout", self, "_on_Timer_timeout")
	add_child(shootingTimer)
	shootingTimer.start()
	prints("READY health:", healthPoint)
	$Area2D.connect("area_entered", self, "_on_Area2D_area_entered")
	Global.player = self


func _physics_process(delta):
	if Input.is_action_pressed("left"):
		rotation -= turn_speed * 1
		$Position2D.rotation -= turn_speed * 0.5
	if Input.is_action_pressed("right"):
		rotation += turn_speed * 1
		$Position2D.rotation += turn_speed * 0.5
	direction.y = Input.get_action_strength("down")-Input.get_action_strength("up")
	if direction:
		velocity = direction * delta * features["speed"]
		$AnimatedSprite.play("default")
	else:
		velocity = Vector2.ZERO
	if Input.is_action_just_pressed("shot"):
		_shoot()
		isShootingEnabled = !isShootingEnabled
		shootingTimer.start()
	else:
		shootingTimer.stop()
	if Input.is_action_just_pressed("reset"):
		dead()
	if Input.is_action_pressed("left") and Input.is_action_pressed("up"):
		$AnimatedSprite.play("left")
	if Input.is_action_pressed("right") and Input.is_action_pressed("up"):
		$AnimatedSprite.play("right")
	move_and_slide(velocity.rotated(rotation)).normalized() 


func _shoot():
	var bullet = BULLET.instance()
	get_parent().add_child(bullet)  
	bullet.position = $Position2D.global_position  
	


func _on_Timer_timeout():
	if isShootingEnabled:
		_shoot()


func levelUp():
	features["maxHealf"]+= 5
	features["shootingInterval"]-= 0.1
	features["speed"]+= 100
	features["level"]+=1
	features["ex"] = 0
	features["damage"]+= 0.5


func damage(amount):
	healthPoint -= amount
	print(healthPoint)
	if healthPoint <= 0:
		dead()


func _on_Area2D_area_entered(body):
	if body.is_in_group("BulletEnemy"): 
		damage(features["damage"])


func dead():
	shootingTimer.stop()  
	queue_free()
	Global.player = null
	get_tree().reload_current_scene()
