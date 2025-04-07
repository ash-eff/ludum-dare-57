extends CharacterBody2D

@export var player_ui : PlayerUI

var thrust = 400
var rotation_speed = 1.5
var max_speed = 600
var friction = 0.98

var health: int = 4
var fuel: int = 3
var food: int = 2
var morale: int = 3
var scrap: int = 2

func _ready() -> void:
	SignalBus.lose_fuel.connect(on_lose_fuel)
	SignalBus.lose_health.connect(on_lose_health)
	SignalBus.lose_morale.connect(on_lose_morale)
	SignalBus.lose_scrap.connect(on_lose_scrap)
	SignalBus.lose_food.connect(on_lose_food)
	SignalBus.add_fuel.connect(on_add_fuel)
	SignalBus.add_health.connect(on_add_health)
	SignalBus.add_morale.connect(on_add_morale)
	SignalBus.add_scrap.connect(on_add_scrap)
	SignalBus.add_food.connect(on_add_food)
	player_ui.set_fuel_value(fuel)
	player_ui.set_health_value(health)
	player_ui.set_morale_value(morale)
	player_ui.set_scrap_value(scrap)
	player_ui.set_food_value(food)

func _physics_process(delta):
	# Rotation
	var rotation_input = Input.get_axis("left", "right")
	rotation += rotation_input * rotation_speed * delta

	# Thrust
	if Input.is_action_pressed("up"):
		velocity += transform.x * thrust * delta
	
	# Manual braking
	if Input.is_action_pressed("down"):
		velocity -= transform.x * thrust * delta

	# Apply friction (space isn't 100% frictionless in most games for playability)
	velocity *= friction

	# Optional speed cap
	if velocity.length() > max_speed:
		velocity = velocity.normalized() * max_speed

	# Move the ship
	move_and_slide()
	
func on_lose_fuel(value):
	fuel -= value
	player_ui.set_fuel_value(fuel)
	
func on_lose_health(value):
	health -= value
	player_ui.set_health_value(health)

func on_lose_morale(value):
	morale -= value
	player_ui.set_morale_value(morale)
	
func on_lose_scrap(value):
	scrap -= value
	player_ui.set_scrap_value(scrap)
	
func on_lose_food(value):
	food -= value
	player_ui.set_food_value(food)
	
func on_add_fuel(value):
	fuel += value
	player_ui.set_fuel_value(fuel)
	
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
