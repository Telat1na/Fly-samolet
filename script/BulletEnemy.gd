extends Area2D


var velocity = Vector2.ZERO
var speed = 500

func _physics_process(delta):
	velocity.y = speed * delta
	translate(velocity)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_BulletEnemy_area_entered(area):
		queue_free()


func _on_BulletEnemy_body_exited(body):
		if body.is_in_group("Player"):
			body.damage(1)
