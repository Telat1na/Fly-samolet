extends Area2D


var velocity = Vector2.ZERO
var speed = 500


func _ready():
	Global.enemyBullet = self


func _physics_process(delta):
	velocity = speed * delta
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_BulletEnemy_area_entered(area):
		queue_free()
