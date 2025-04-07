class_name POIResource
extends Resource

enum adjectives {
	Wrecked,
	Abandoned,
	Derelict,
	Uncharted,
	Destroyed,
	Mysterious,
}

@export var title: String = "Unnamed POI"
@export_multiline var description: String = "Point of interest description."
@export var rooms: Array[RoomResource]


func get_title() -> String:
	var selected_value = adjectives.values().pick_random()
	var selected_name = adjectives.keys()[adjectives.values().find(selected_value)]
	var enhanced_title = selected_name + " " + title
	return enhanced_title

## select 2 random rooms
