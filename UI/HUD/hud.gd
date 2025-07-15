extends CanvasLayer

@onready var water: Sprite2D = $Control/ManaPool/water
@onready var fire: Sprite2D = $Control/ManaPool/fire
@onready var earth: Sprite2D = $Control/ManaPool/earth
@onready var wind: Sprite2D = $Control/ManaPool/wind

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.change_element_qte.connect(update_element_gui)
	visible = true

func update_element_gui():
	water.frame = Global.water_element
	fire.frame = Global.fire_element
	earth.frame = Global.earth_element
	wind.frame = Global.wind_element
