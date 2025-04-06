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
@export_multiline var description: String = ""
@export var rooms: Array[Room]

func get_title() -> String:
	var selected_adjective = adjectives.values().pick_random()
	var enhanced_title = selected_adjective + title
	return enhanced_title

## select 2 random rooms
