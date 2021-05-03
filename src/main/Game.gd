extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var amount1 = Global.DOOR
var amount2 = Global.DOOR
onready var red = $"CanvasLayer/Red Neighbor/AnimationPlayer"
onready var blue = $"CanvasLayer/Blue Neighbor/AnimationPlayer"
onready var UI = $"CanvasLayer/UI"
onready var easterEgg = $"CanvasLayer/Red Neighbor"

onready var goalLabel = $CanvasLayer/GoalLabel

onready var animator = $Animator

var winL = 0
var winR = 0
var hasWonL = false
var hasWonR = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/UI/Control/Button.connect("pressed", self, "_on_Menu_Button_pressed")
	setWinValue()
	goalLabel.set_text("Reach " + str(Global.WIN) + "!")
	winL = Global.WIN
	winR = Global.WIN
	UI.updateScore(winL, winR)
	#$CanvasLayer/ColorRect.hide()
	restart()
	animator.play("enter")

var rng = RandomNumberGenerator.new()

func setWinValue():
	rng.randomize()
	var random_number = rng.randi_range(5, 15)
	Global.WIN = random_number

func setDoorValue():
	rng.randomize()
	var random_number = rng.randi_range(3, 20)
	Global.DOOR = random_number
	UI.updateMaxValue()

func restart():
	setDoorValue()
	amount1 = Global.DOOR
	amount2 = Global.DOOR
	red.play("doorClose")
	blue.play("doorClose")
	hasWonL = false
	hasWonR = false

func hideTutorial():
	$"CanvasLayer/Press D".hide()
	$"CanvasLayer/Press K".hide()

func checkIfWon():
	if winL == 0:
		print("Red Won")
		animator.play("redWon")
	elif winR == 0:
		print("Blue Won")
		animator.play("blueWon")
		

func reload():
	get_tree().reload_current_scene()

func hasWonLeft():
	if hasWonL == false:
		hasWonL = true
		red.play("doorOpen")
		winL -= 1
		checkIfWon()
		
func hasWonRight():
	if hasWonR == false:
		hasWonR = true
		blue.play("doorOpen")
		winR -= 1
		checkIfWon()
func _process(delta):
	if (amount1 <= 0 || amount2 <= 0) && (red.is_playing() == false && blue.is_playing() == false):
		if amount1 <= 0 && amount2 > 0:
			hasWonLeft()
		elif amount1 > 0 && amount2 <= 0:
			hasWonRight()
		elif hasWonL == false && hasWonR == false:
			var my_random_number = rng.randi_range(0, 100)
			if my_random_number % 2 == 0:
				hasWonLeft()
			else:
				hasWonRight()
		UI.updateScore(winL, winR)
		if red.is_playing() == false && blue.is_playing() == false:
			restart()
			hideTutorial()
	else:
		if Input.is_action_just_pressed("player_1_click"):
			if red.is_playing() == false:
				amount1 -= 1
				red.play("pressBellRed")
		if Input.is_action_just_pressed("player_2_click"):
			if blue.is_playing() == false:
				amount2 -= 1
				blue.play("pressBellBlue")
		UI.updateProgress(amount1, amount2)


func _on_Menu_Button_pressed():
	animator.play("exit")
	
func sceneMove():
	get_tree().change_scene("res://src/userInterface/titleScreen/TitleScreen.tscn")
	

