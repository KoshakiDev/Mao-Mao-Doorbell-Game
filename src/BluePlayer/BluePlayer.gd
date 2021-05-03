extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var bellsound = $"BellSound"
onready var neighborsound = $"NeighborSound"
onready var winnersound = $"WinnerSound"

var Particle = preload("res://src/particles/Particles.tscn")

onready var hand = $Hand
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func playNeigbhbor():
	neighborsound.play()

func playBell():
	bellsound.play()
	
func playWinner():
	winnersound.play()
	
func set_motion_blur():
	hand.material.set_shader_param("strength", 0.05)

func remove_motion_blur():	
	hand.material.set_shader_param("strength", 0)
