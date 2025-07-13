extends Node

var game_manager : GameManager = null

signal change_current_element
signal change_element_qte

enum elements { water, fire, earth, wind }
var current_element : elements :
	set(value): current_element = value; change_current_element.emit()

var water_element : int = 0 :
	set(value): water_element = value; change_element_qte.emit()
var fire_element : int = 0 :
	set(value): fire_element = value; change_element_qte.emit()
var earth_element : int = 0 :
	set(value): earth_element = value; change_element_qte.emit()
var wind_element : int = 0 :
	set(value): wind_element = value; change_element_qte.emit()

func cycle_current_element_next():
	match current_element:
		elements.water:
			current_element = elements.fire
		elements.fire:
			current_element = elements.earth
		elements.earth:
			current_element = elements.wind
		elements.wind:
			current_element = elements.water
func cycle_current_element_previous():
	match current_element:
		elements.water:
			current_element = elements.wind
		elements.fire:
			current_element = elements.water
		elements.earth:
			current_element = elements.fire
		elements.wind:
			current_element = elements.earth
