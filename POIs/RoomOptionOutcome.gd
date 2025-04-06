class_name RoomOptionOutcome
extends Resource

enum RESOURCES {
	NONE,
	MORALE,
	FOOD,
	FUEL,
	SCRAP,
	HEALTH,
	SURVIVOR,
}

@export var resource_loss: RESOURCES = RESOURCES.NONE
@export var resource_gain: RESOURCES = RESOURCES.NONE
@export var amount_loss: int = 0
@export var amount_gain: int = 0
@export var result_text: String = ""  

## Assume you have a reference to the OptionCard scene
#@export var option_card_scene: PackedScene
#
## This function will instantiate the card and set its data
#func show_card(option_outcome: RoomOptionOutcome):
	#var card = option_card_scene.instantiate()
	#
	## Assign the resource data to the card UI elements
	#card.get_node("ResourceLossLabel").text = "Lose " + str(option_outcome.amount_loss) + " " + option_outcome.resource_loss.name
	#card.get_node("ResourceGainLabel").text = "Gain " + str(option_outcome.amount_gain) + " " + option_outcome.resource_gain.name
	#card.get_node("ResultTextLabel").text = option_outcome.result_text
	#
	## Add the card to the UI or display it
	#$CardsContainer.add_child(card)
