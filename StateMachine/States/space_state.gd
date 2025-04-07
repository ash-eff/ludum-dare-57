extends State
class_name SpaceState

var thrust = 400
var rotation_speed = 1.5
var max_speed = 600
var friction = 0.98

func enter() -> void:
	pass
	
func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass
	
func physics_update(delta: float) -> void:
	# Rotation
	var rotation_input = Input.get_axis("left", "right")
	ship.rotation += rotation_input * rotation_speed * delta

	# Thrust
	if Input.is_action_pressed("up"):
		ship.velocity += ship.transform.x * thrust * delta
		ship.fuel.monitor_fuel_consumption(ship.velocity, delta)
	
	# Manual braking
	if Input.is_action_pressed("down"):
		ship.velocity -= ship.transform.x * (thrust / 4) * delta
		ship.fuel.monitor_fuel_consumption(ship.velocity, delta)

	# Apply friction (space isn't 100% frictionless in most games for playability)
	ship.velocity *= friction

	# Optional speed cap
	if ship.velocity.length() > max_speed:
		ship.velocity = ship.velocity.normalized() * max_speed

	# Move the ship
	ship.move_and_slide()

#func handle_input(input_vector: Vector2, turn_input: float) -> String:
	#return "" # cycle states with input
