extends Node2D

@export var scan_interval: float = 1.0
@export var scan_distance = 1000.0
@export var arrow_distance = 175.0
@export var screen_margin: float = 20.0

@onready var timer : Timer = $Timer

var nexus_beacon: Nexus

var beacons : Array
var tracked_beacons : Array
var space: Space

func _ready() -> void:
	timer.wait_time = scan_interval

	space = get_tree().get_root().get_node("Space")
	nexus_beacon = space.get_node("Nexus")
	if !space or !nexus_beacon:
		return
	get_beacons()

func _process(delta: float) -> void:
	scan_beacon()
	look_for_nexus_beacon()
	if Input.is_action_just_pressed("space"):
		toggle_nexus_beacon()
	
func get_beacons():
	beacons.clear()
	tracked_beacons.clear()

	var found_beacons = space.find_children("*", "Beacon", true, false)
	for beacon in found_beacons:
		if beacon.get_parent() is Nexus:
			continue
		beacons.append(beacon)

			
func scan_beacon():
	tracked_beacons.clear()
	for beacon in beacons:
		var distance = global_position.distance_to(beacon.global_position)
		if distance <= scan_distance and distance >= arrow_distance:
			tracked_beacons.append(beacon)
			beacon.set_arrow_visible(true)
		elif distance < arrow_distance:
			tracked_beacons.append(beacon)
			beacon.set_arrow_visible(false)
		else:
			tracked_beacons.erase(beacon)
			beacon.set_arrow_visible(false)
	
	for beacon in tracked_beacons:
		var direction_to_beacon = (beacon.global_position - global_position).normalized()
		beacon.set_arrow_position(global_position + direction_to_beacon * arrow_distance)
		beacon.set_arrow_rotation(direction_to_beacon.angle())
		
func look_for_nexus_beacon():
	var direction_to_nexus_beacon = (nexus_beacon.global_position - global_position).normalized()
	nexus_beacon.beacon.set_arrow_position(global_position + direction_to_nexus_beacon * arrow_distance)
	nexus_beacon.beacon.set_arrow_rotation(direction_to_nexus_beacon.angle())
	var distance = global_position.distance_to(nexus_beacon.global_position)
	if distance < arrow_distance:
		nexus_beacon.disable_nexus_transmit()
	
func toggle_nexus_beacon():
	nexus_beacon.toggle_nexus_beacon()

func calculate_edge_position(direction: Vector2, screen_size: Vector2) -> Vector2:
	# Determine the x position based on direction
	var x: float
	if direction.x > 0:
		x = screen_size.x - screen_margin
	else:
		x = screen_margin
	
	# Determine the y position based on direction
	var y: float
	if direction.y > 0:
		y = screen_size.y - screen_margin
	else:
		y = screen_margin
	
	# Return the edge position
	return Vector2(x, y)
