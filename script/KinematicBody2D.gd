extends KinematicBody2D

signal hit
signal touch 
const BULLET = preload("res://scene/Bullet.tscn")
const EnemyBullet = preload("res://scene/BulletEnemy.tscn")
var velocity = Vector2.ZERO
var direction = Vector2.ZERO
var shootingTimer = Timer.new()
var isShootingEnabled = true
onready var healthPoint = features["maxHealth"]
var features := {
	"maxHealth":10,
	"speed": 10000,
	"shootingInterval": 1,
	"level":1,
	"ex":0,
	"damage":1
}


func _ready():
	# Настройка таймера
	shootingTimer.wait_time = features["shootingInterval"]
	shootingTimer.one_shot = false
	shootingTimer.connect("timeout", self, "_on_Timer_timeout")
	add_child(shootingTimer)
	# Запуск таймера
	shootingTimer.start()
	print(healthPoint)
	$Area2D.connect("body_entered",self,"_on_Area2D_body_entered")


func _physics_process(delta):
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	if direction:
		velocity = direction.normalized() * delta * features["speed"]
	else:
		velocity = Vector2.ZERO

	if Input.is_action_just_pressed("shot"):
		isShootingEnabled = !isShootingEnabled
		if isShootingEnabled:
			shootingTimer.start()
		else:
			shootingTimer.stop()
	move_and_slide(velocity)


func _shoot():
	var bullet = BULLET.instance()
	bullet.position = $Position2D.global_position
	get_parent().add_child(bullet)


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
	if emit_signal("hit"):
		healthPoint -= amount
		print(healthPoint)
	if healthPoint <= 0:
		print("dead")


func _on_Area2D_body_entered(body):
	print("_on_Area2D_body_entered")
	if body.is_in_group("BulletEnemy"): 
		body.emit_signal("hit")
		print("bulletEnteret")
