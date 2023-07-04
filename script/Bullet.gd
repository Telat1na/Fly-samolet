extends Area2D


var velocity = Vector2.ZERO
var speed = 500


func _physics_process(delta):
	velocity.y = speed*delta
	translate(-velocity)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
