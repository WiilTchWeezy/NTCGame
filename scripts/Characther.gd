extends Node2D

onready var idle = get_node("Idle")
onready var hitting = get_node("Hitting")
onready var anim = get_node("Anim")
onready var grave = get_node("Grave")

var lado
var isAlive = true

const LEFT = 1
const RIGHT = 2

func _ready():
	pass
	
func left():
	set_pos(Vector2(185, 950))
	idle.set_pos(Vector2(-44, 0))
	hitting.set_pos(Vector2(-5, 0))
	idle.set_flip_h(false)
	idle.set_flip_v(false)	
	hitting.set_flip_h(false)
	
	grave.set_pos(Vector2(-44,41))
	grave.set_flip_h(true)
	lado = LEFT

func right():
	set_pos(Vector2(540, 950))
	idle.set_pos(Vector2(28, 0))
	hitting.set_pos(Vector2(-10, 0))
	idle.set_flip_h(true)
	idle.set_flip_v(false)
	hitting.set_flip_h(true)
	
	grave.set_pos(Vector2(28,41))
	grave.set_flip_h(false)
	lado = RIGHT

func hit():
	if isAlive:
		anim.play("Hit")
	
func die():
	anim.stop()
	idle.hide()
	hitting.hide()
	grave.show()
	isAlive = false