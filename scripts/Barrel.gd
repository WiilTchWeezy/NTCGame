extends Node2D

func _ready():
	pass

func destroy(side):
	if (side == 1):
		get_node("Anim").play("Left")
	else:
		get_node("Anim").play("Right")
		