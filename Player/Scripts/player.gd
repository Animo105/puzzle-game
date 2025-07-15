extends CharacterBody2D
class_name Player

@onready var sprite: AnimatedSprite2D = $sprite
@onready var ray: RayCast2D = $Ray
# constente des scene d'éléments
const EARTH_PILLAR = preload("res://Player/Elements Activations/earth_pillar.tscn")

# constante de mouvement
const AIR_MULTIPLIER : float = 0.7
const MAX_SPEED : float = 125
const ACCELERATION : float = 900
const JUMP_STRENGHT : float = -270
const JUMP_GRAVITY : float = 900
const FALL_GRAVITY : float = 1000
const TERMINAL_VELOCITY : float = 500

var initial_position : Vector2
var last_input_dir : String = ""

var dig_direction : String = ""
var dig_position : Vector2 = Vector2.ZERO
var dig_tilemap : TileMapLayer = null

enum states { ground, air, dig }
var state : states = states.air

var sprite_direction : float: # set the direction of the sprite
	set(value):
		if value == 0 or value == sprite_direction : return
		if value > 0:
			sprite_direction = 1
			sprite.flip_h = false
		elif value < 0:
			sprite_direction = -1
			sprite.flip_h = true
	get():
		return sprite_direction

func _ready() -> void:
	initial_position = global_position

func _physics_process(delta: float) -> void:
	match state:
		states.ground:
			var dir = inputx()
			if dir == 0:
				pass # idle
			else:
				pass #walk
			accelerate(delta, dir) # accelerate
			sprite_direction = dir # change sprite direction
			move_and_slide()
			
			# handle jump
			if Input.is_action_just_pressed("Jump"):
				velocity.y = JUMP_STRENGHT
				# play animation jump
				state = states.air
			if not is_on_floor():
				state = states.air
		# ######################################## #
		states.air:
			var dir = inputx()
			accelerate(delta, dir) # accelerate
			apply_gravity(delta) # apply gravity
			sprite_direction = dir # change sprite direction
			move_and_slide()
			
			if is_on_floor(): # if on floor, change state
				velocity.y = 0
				state = states.ground
		# ######################################## #
		states.dig:
			match dig_direction:
				"":
					if Input.is_action_just_pressed("Left"): dig_direction = "left"
					elif Input.is_action_just_pressed("Right"): dig_direction = "right"
					elif Input.is_action_just_pressed("Up"): dig_direction = "up"
					elif Input.is_action_just_pressed("Down"): dig_direction = "down"
				"left":
					pass
				"right":
					pass
				"up":
					pass
				"down":
					var next_pos = dig_tilemap.to_global(dig_tilemap.map_to_local(dig_position))
					
		# ######################################## #

func _input(event: InputEvent) -> void:
	# check for the last input direction for the element
	if event.is_action_pressed("Down"):
		last_input_dir = "down"
	elif event.is_action_pressed("Up"):
		last_input_dir = "up"
	elif event.is_action_pressed("Left"):
		last_input_dir = "left"
	elif event.is_action_pressed("Right"):
		last_input_dir = "right"
	# ######################################## #
	# cycle between elements
	elif event.is_action_pressed("previous_element"):
		Global.cycle_current_element_previous()
	elif event.is_action_pressed("next_element"):
		Global.cycle_current_element_next()
	# ######################################## #
	# activate element by direction
	elif event.is_action_pressed("activate_element"):
		match Global.current_element:
			Global.elements.water:
				water_activation()
			Global.elements.fire:
				fire_activation()
			Global.elements.earth:
				earth_activation()
			Global.elements.wind:
				wind_activation()

# ######################################################################################### #
func inputx()->float:
	return Input.get_axis("Left", "Right") #get x input

func accelerate(delta: float, direction :float = inputx()):
	var mult := AIR_MULTIPLIER if not is_on_floor() else 1.0
	velocity.x = move_toward(velocity.x, MAX_SPEED * direction, ACCELERATION * mult * delta)

func apply_gravity(delta : float):
	var g := JUMP_GRAVITY if velocity.y < 0 else FALL_GRAVITY
	velocity.y = move_toward(velocity.y, TERMINAL_VELOCITY, g * delta)

func move_to(target_pos : Vector2)->void:
	var tween = create_tween()
	tween.tween_property(self, "global_position", target_pos, 0.2).set_trans(Tween.TRANS_LINEAR)
	await tween.finished

func reset():
	state = states.air
	collision_mask = 1
	global_position = initial_position
# ########################################################################################## #

func water_activation():
	if Global.water_element == 0: return # if no elements, return
	match last_input_dir:
		"up":
			pass
		"down":
			pass
		"left":
			pass
		"right":
			pass

func fire_activation():
	if Global.fire_element == 0: return # if no elements, return
	match last_input_dir:
		"up":
			pass
		"down":
			pass
		"left":
			pass
		"right":
			pass

func earth_activation():
	if Global.earth_element == 0: return # if no elements, return
	match last_input_dir:
		"down": # dig down
			var collider = ray.get_collider() # get ground collider
			if collider is TileMapLayer : # if collider is a tile map check for the coords
				var tileData = collider.get_cell_tile_data(collider.get_coords_for_body_rid(ray.get_collider_rid())) # get the data for the coords of the collider
				if tileData is TileData: # check if the data is a TileData (not null or empty)
					if tileData.get_custom_data_by_layer_id(0) == "dirt": # if the tile is a dirt tile, spawn pillar
						Global.earth_element -= 1
						dig_position = collider.get_coords_for_body_rid(ray.get_collider_rid()) # set dig position at the coord on the map
						dig_tilemap = collider # set the tilemap as the collider to check tile position based on coords
						dig_direction = "down" # set starting dig direction as down
						state = states.dig

		_: # spawn a pillar to the left
			var collider = ray.get_collider() # get ground collider
			if collider is TileMapLayer : # if collider is a tile map check for the coords
				var tileData = collider.get_cell_tile_data(collider.get_coords_for_body_rid(ray.get_collider_rid())) # get the data for the coords of the collider
				if tileData is TileData: # check if the data is a TileData (not null or empty)
					if tileData.get_custom_data_by_layer_id(0) == "dirt": # if the tile is a dirt tile, spawn pillar
						Global.earth_element -= 1 # consume one element
						var pillar = EARTH_PILLAR.instantiate() # instantiate a pillar
						Global.game_manager.current_scene.add_child(pillar) # add to scene
						pillar.global_position = global_position # set position

func wind_activation():
	if Global.wind_element == 0: return # if no elements, return
	match last_input_dir:
		"up":
			pass
		"down":
			pass
		"left":
			pass
		"right":
			pass
