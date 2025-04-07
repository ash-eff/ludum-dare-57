extends Panel

@onready var room_title = $"VBoxContainer/Room Title"
@onready var room_description = $"VBoxContainer/Room Description"

func populate_room_data(room: RoomResource):
	room_title.text = room.name
	room_description.text = room.description
