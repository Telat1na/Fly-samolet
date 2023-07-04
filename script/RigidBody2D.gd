extends RigidBody2D

const BULLET = preload("res://scene/BulletEnemy.tscn")
const SPEED = 10000
var velocity = Vector2.ZERO
var direction = Vector2.ZERO
var shootingTimer = Timer.new()
var shootingInterval = 1.0  # Интервал между выстрелами в секундах
var isShootingEnabled = true


func _ready():
	# Настройка таймера
	shootingTimer.wait_time = shootingInterval
	shootingTimer.one_shot = false
	shootingTimer.connect("timeout", self, "_on_Timer_timeout")
	add_child(shootingTimer)
	# Запуск таймера
	shootingTimer.start()


func _shoot():
	var bullet = BULLET.instance()
	bullet.position = $Position2D.global_position
	get_parent().add_child(bullet)
	
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Timer_timeout():
	if isShootingEnabled:
		_shoot()
