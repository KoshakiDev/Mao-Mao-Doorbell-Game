extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var animator = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	animator.play("play")
	
func sceneMove():
	get_tree().change_scene("res://src/userInterface/titleScreen/TitleScreen.tscn")
