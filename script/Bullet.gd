extends Area2D


var velocity = Vector2(1,0)
var speed = 1000
var loock_once = true

func _ready():
	Global.bullet = self



func _physics_process(delta):
	if loock_once:
		look_at(get_global_mouse_position())
		loock_once = false
	global_position += velocity.rotated(rotation) * speed * delta
	$AnimatedSprite.play("default")

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Bullet_body_entered(body):
	if body == Global.KamikazeEnemy:
		queue_free()

