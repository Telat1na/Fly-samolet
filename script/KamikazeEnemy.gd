extends KinematicBody2D

const BULLET = preload("res://scene/BulletEnemy.tscn")
const SPEED = 200
var velocity = Vector2.ZERO
var direction = Vector2.ZERO
var maxHealPoint = 2
var HealPoint = maxHealPoint
var damage = Global.features["damage"]


func _ready():
	Global.KamikazeEnemy = self


func _physics_process(delta):
	if Global.player != null:
		direction = global_position.direction_to(Global.player.global_position)
		#global_position += direction * SPEED 
		move_and_slide(direction*SPEED)
		$AnimatedSprite.play("default")
	rotation = direction.angle()


func _on_Area2D_area_entered(area):
	if area == Global.bullet: 
		damage(damage)


func damage(amount):
	HealPoint -= amount
	print(HealPoint)
	if HealPoint <= 0:
		queue_free()


func _on_Area2D_body_entered(body):
	if body == Global.player:
		Global.player.damage(2)
		queue_free()


