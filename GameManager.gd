extends Node
class_name GameManager

var current_scene : Node = null
var previous_scene : Node = null

func _ready() -> void:
	Global.game_manager = self
	change_scene("res://UI/menu/main_menu.tscn")

func change_scene(scene_name : String, delete:bool = true, keep_running : bool = false):
	# si il y a une previous scene supprime la
	if previous_scene != null:
		previous_scene.queue_free()
	if current_scene != null: #si il y a une scene, check for delete et keep running
		if delete:
			current_scene.queue_free() # si delete remove la node
		elif keep_running:
			current_scene.visible = false # si keep running, laisse run mais show pas
		else:
			remove_child(current_scene) # sinon, garde en memoire mais run pu
	# Load nouvelle
	if !ResourceLoader.exists(scene_name):
		print("No scene at path: ", scene_name)
		return
	var packed : PackedScene = load(scene_name)
	var new = packed.instantiate()
	previous_scene = current_scene
	current_scene = new
	add_child(new)

func change_with_fade(scene_name : String, delete: bool = true, keep_running : bool = false):
	SplashScreen.fade_in()
	await SplashScreen.faded_in
	change_scene(scene_name, delete, keep_running)
	SplashScreen.fade_out()

func to_previous_scene(delete:bool = true, keep_running : bool = false):
	if previous_scene == null:
		return
	if current_scene != null: #si il y a une scene, check for delete et keep running
		if delete:
			current_scene.queue_free() # si delete remove la node
		elif keep_running:
			current_scene.visible = false # si keep running, laisse run mais show pas
		else:
			remove_child(current_scene) # sinon, garde en memoire mais run pu
	# load previous
	var temp = previous_scene
	previous_scene = current_scene
	current_scene = temp
	if get_children().find(current_scene) != -1:
		current_scene.visible = true # si dans le tree, show la scene
	else:
		add_child(current_scene) # sinon add la scene
