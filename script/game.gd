extends Node2D


const KAM_ENEMY = preload("res://scene/KamikazeEnemy.tscn")


func _ready():
	$HP.text = str(Global.player.healthPoint)
	spawn()

func spawn():
	var ScreenWidth = 600
	var ScreenHeight = 800
	var KamEnemy = KAM_ENEMY.instance()
	
	while true:
		KamEnemy.position.x = rand_range(-10, ScreenWidth + 10)
		KamEnemy.position.y = rand_range(-10, ScreenHeight + 10)
		
		if KamEnemy.position.x < 0 or KamEnemy.position.x > ScreenWidth or KamEnemy.position.y < 0 or KamEnemy.position.y > ScreenHeight:
			break
	
	add_child(KamEnemy)


func _on_Timer_timeout():
	spawn()
	
