extends Node2D

onready var highScoreLabel = get_node("CanvasLayer/HighScoreLabel")

func _ready():
	var highScore = Transition.read_savegame()
	highScoreLabel.set_text(str(highScore))
	