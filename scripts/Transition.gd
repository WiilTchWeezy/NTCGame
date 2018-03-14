extends CanvasLayer

var nextScenePath
var savegame = File.new()
var save_path = "user://savegame.save"
var save_data = {"highscore": 0}

func _ready():
	if not savegame.file_exists(save_path):
		create_save()

func fade_to(path):
	nextScenePath = path
	get_node("Anim").play("Fade")

func change_scene ():
	if (nextScenePath != null):
		get_tree().change_scene(nextScenePath)

func create_save():
   savegame.open(save_path, File.WRITE)
   savegame.store_var(save_data)
   savegame.close()

func save(high_score):    
   save_data["highscore"] = high_score #data to save
   savegame.open(save_path, File.WRITE) #open file to write
   savegame.store_var(save_data) #store the data
   savegame.close() # close the file

func read_savegame():
   savegame.open(save_path, File.READ) #open the file
   save_data = savegame.get_var() #get the value
   savegame.close() #close the file
   return save_data["highscore"] #return the value