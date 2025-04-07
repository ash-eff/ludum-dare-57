class_name PlayerUI
extends Control

@onready var health_value = $"VBoxContainer/Health/Health Value"
@onready var fuel_value = $"VBoxContainer/Fuel/Fuel Value"
@onready var food_value = $"VBoxContainer/Food/Food Value"
@onready var morale_value = $"VBoxContainer/Morale/Morale Value"
@onready var scrap_value = $"VBoxContainer/Scrap/Scrap Value"

func set_health_value(value):
	health_value.text = str(value)
	
func set_fuel_value(value):
	fuel_value.text = str(value)
	
func set_food_value(value):
	food_value.text = str(value)
	
func set_morale_value(value):
	morale_value.text = str(value)
	
func set_scrap_value(value):
	scrap_value.text = str(value)
