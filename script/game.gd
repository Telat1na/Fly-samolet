extends Node2D

onready var player1 = preload("res://scene/KinematicBody2D.tscn").instance()

func _ready():
	$HP.text = str(player1.healthPoint)
