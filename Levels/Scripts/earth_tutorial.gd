extends Node2D

@onready var drill_text: Label = $"drill text"
var down_key : String = ""
var active_key : String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# get keys
	var key_down := InputMap.action_get_events("Down")[0]
	if key_down is InputEventKey:
		down_key = key_down.as_text_physical_keycode()
	var key_active := InputMap.action_get_events("activate_element")[0]
	if key_active is InputEventKey:
		active_key = key_active.as_text_physical_keycode()
	
	drill_text.text = tr("EARTH_DOWN") % [down_key, active_key]
	# set current element to earth
	Global.current_element = Global.elements.earth

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
