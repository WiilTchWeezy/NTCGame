extends Node2D
onready var marcador = get_node("Marcador")

var perc = 1

signal lost

func _ready():
	set_process(true)
	
func _process(delta):
	if perc > 0:
		perc -= 0.1 * delta
		marcador.set_region_rect(Rect2(0,0,perc*188,23))
		marcador.set_pos(Vector2(-(1- perc)*188/2,0))
	else:
		emit_signal("lost")
		
func add(delta):
	perc += delta
	if perc > 1:
		perc = 1
