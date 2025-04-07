class_name HullComponent
extends Area2D

var hull_health: int = 5
@onready var ship = get_parent()

func _ready() -> void:
	ship.player_ui.set_hull_health_value(hull_health)
	SignalBus.increase_hull_health.connect(on_hull_health_increase)
	
func on_hull_health_increase(value):
	pass
	
func on_lose_hull_health(value):
	hull_health -= value
	if hull_health <= 0:
		SignalBus.hull_destroyed.emit()
		ship.state_machine.change_state("Dead")
	ship.player_ui.set_hull_health_value(hull_health)

func on_gain_hull_health(value):
	hull_health -= value
	ship.player_ui.set_hull_health_value(hull_health)

func _on_area_entered(area: Area2D) -> void:
	if area is Hitbox:
		on_lose_hull_health(1)
