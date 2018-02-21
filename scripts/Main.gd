extends Node
onready var character = get_node("Character")
onready var camera = get_node("Camera")
onready var barrels = get_node("Barrels")
onready var dest = get_node("Dest")
onready var bar = get_node("Bar")
onready var pointLabel = get_node("Control/Points")

var barrel = preload("res://Scenes/Barrel.tscn")
var barrelRight = preload("res://Scenes/EnemyBarrelRight.tscn")
var barrelLeft = preload("res://Scenes/EnemyBarrelLeft.tscn")

var lastHasEnemy

var points = 0

func _ready():
	randomize()
	set_process_input(true)
	beginGenerate()
	bar.connect("lost",self,"lose")
	
func _input(event):
	event = camera.make_input_local(event)
	if event.type == InputEvent.SCREEN_TOUCH and event.pressed:
		if event.pos.x < 360:
			character.left()
		else:
			character.right()
			
		if !checkEnemy():
			character.hit()
			var prim = barrels.get_children()[0]
			barrels.remove_child(prim)
			dest.add_child(prim)
			prim.destroy(character.lado)
			randomizeBarrel(Vector2 (360,950 - 10*172))
			down()
			
			bar.add(0.014)
			points += 1
			pointLabel.set_text(str(points))
			if checkEnemy():
				lose()
		else:
			lose()


func randomizeBarrel(pos):
	var num = rand_range(0,3)
	if (lastHasEnemy):
		num = 0
	generate(int(num), pos)

func generate(type,pos):
	var newBarrel
	if type == 0:
		newBarrel = barrel.instance()
		lastHasEnemy = false
	elif type == 1:
		newBarrel = barrelRight.instance()
		newBarrel.add_to_group("barrelRight")
		lastHasEnemy = true		
	elif type ==2:
		newBarrel = barrelLeft.instance()
		newBarrel.add_to_group("barrelLeft")
		lastHasEnemy = true		
		
		
	newBarrel.set_pos(pos)
	barrels.add_child(newBarrel)
	
func beginGenerate():
	for i in range(0,3):
		generate(0,Vector2(360,950 - i * 172))
	for i in range(3,10):
		randomizeBarrel(Vector2(360,950 - i * 172))
		
func checkEnemy():
	var lado  = character.lado
	var first = barrels.get_children()[0]
	if lado == character.LEFT and first.is_in_group("barrelLeft") or lado == character.RIGHT and first.is_in_group("barrelRight"):
		return true
	else:
		return false
	
func down():
	for b in barrels.get_children():
		b.set_pos(b.get_pos() + Vector2(0,172))
	
func lose():
	character.die()
	bar.set_process(false)
	set_process_input(false)
	show_menu()
	get_node("Timer").start()
	 

func _on_Timer_timeout():
	get_tree().reload_current_scene()
	
	

