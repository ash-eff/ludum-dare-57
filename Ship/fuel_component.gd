class_name FuelComponent
extends Node2D

var fuel_tick_timer := 0.0
var fuel_tick_interval := 2

var max_fuel: float = 10
var fuel: float = 0
var fuel_percentage: float
@onready var ship = get_parent()

func _ready() -> void:
	SignalBus.add_fuel.connect(on_add_fuel)
	SignalBus.lose_fuel.connect(on_lose_fuel)
	SignalBus.increase_max_fuel.connect(on_increase_max_fuel)
	fuel = max_fuel
	fuel_percentage = (fuel / max_fuel) * 100
	ship.player_ui.set_fuel_value(fuel_percentage)
	
func monitor_fuel_consumption(_velocity, _delta):
	if _velocity.length() > 10:
		fuel_tick_timer += _delta
		if fuel_tick_timer >= fuel_tick_interval:
			fuel_tick_timer = 0.0
			on_lose_fuel(0.1)

func on_lose_fuel(value):
	fuel = clamp(fuel - value, 0, max_fuel)
	var fuel_percentage := int((fuel / max_fuel) * 100)
	ship.player_ui.set_fuel_value(fuel_percentage)
	if fuel <= 0:
		SignalBus.out_of_fuel.emit()
		ship.state_machine.change_state("Dead")

func on_add_fuel(value):
	fuel = clamp(fuel + value, 0, max_fuel)
	var fuel_percentage := int((fuel / max_fuel) * 100)
	ship.player_ui.set_fuel_value(fuel_percentage)

func on_increase_max_fuel(value):
	if value == -1:
		max_fuel = max_fuel * 2
	else:
		max_fuel += value
	# increase fuel bar length
