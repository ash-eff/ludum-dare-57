class_name Ship
extends CharacterBody2D

@export var player_ui : PlayerUI
@export var fuel: FuelComponent
@export var state_machine: StateMachine
@export var hull_component: HullComponent

var health: int = 4
var food: int = 2
var morale: int = 3
var scrap: int = 2

func _ready() -> void:
	SignalBus.lose_health.connect(on_lose_health)
	SignalBus.lose_morale.connect(on_lose_morale)
	SignalBus.lose_scrap.connect(on_lose_scrap)
	SignalBus.lose_food.connect(on_lose_food)

	SignalBus.add_health.connect(on_add_health)
	SignalBus.add_morale.connect(on_add_morale)
	SignalBus.add_scrap.connect(on_add_scrap)
	SignalBus.add_food.connect(on_add_food)
	
	SignalBus.ship_docked.connect(on_ship_docked)
	SignalBus.ship_undocked.connect(on_ship_undocked)

	player_ui.set_health_value(health)
	player_ui.set_morale_value(morale)
	player_ui.set_scrap_value(scrap)
	player_ui.set_food_value(food)
	

func _physics_process(delta):
	if state_machine.current_state:
		state_machine.current_state.physics_update(delta)
		
func on_ship_docked():
	state_machine.change_state("UI")
	
func on_ship_undocked():
	state_machine.change_state("Space")
	
func on_lose_health(value):
	health -= value
	if health <= 0:
		SignalBus.player_died.emit()
		state_machine.change_state("Dead")
	player_ui.set_health_value(health)

func on_lose_morale(value):
	morale -= value
	if morale <= 0:
		SignalBus.no_more_morale.emit()
		state_machine.change_state("Dead")
	player_ui.set_morale_value(morale)
	
func on_lose_scrap(value):
	scrap -= value
	player_ui.set_scrap_value(scrap)
	
func on_lose_food(value):
	food -= value
	if food <= 0:
		SignalBus.player_died.emit()
		state_machine.change_state("Dead")
	player_ui.set_food_value(food)
	
func on_add_health(value):
	health += value
	player_ui.set_health_value(health)

func on_add_morale(value):
	morale += value
	player_ui.set_morale_value(morale)
	
func on_add_scrap(value):
	scrap += value
	player_ui.set_scrap_value(scrap)
	
func on_add_food(value):
	food += value
	player_ui.set_food_value(food)
