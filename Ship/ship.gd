extends CharacterBody2D

var thrust = 400
var rotation_speed = 1.5
var max_speed = 600
var friction = 0.98



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
	
	if Input.is_action_just_pressed("1"):
		if LocationData.location_data.has("engine room"):
			var options = LocationData.location_data["engine room"]  # Get the list of options for the location
			var random_option = options[randi() % options.size()]  # Randomly pick an option
			print (random_option)
		else:
			print("You find nothing of interest here.")
