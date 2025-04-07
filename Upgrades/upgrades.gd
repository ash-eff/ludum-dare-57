class_name Upgrades
extends Node

var upgrades = {
	"Level 1" : [
		{
			"name": "Reinforced Hull 1",
			"description": "Increase max hull by 1.",
			"cost": 5,
			"apply": func(): SignalBus.increase_hull_health.emit(1)
		},
		{
			"name": "Beacon Tuner 1",
			"description": "Increase beacon detection range by 250 meters.",
			"cost": 5,
			"apply": func(): SignalBus.increase_beacon_range.emit(250)
		},
		{
			"name": "Fuel Tank Upgrade 1",
			"description": "Increase max fuel tanks by 1.",
			"cost": 5,
			"apply": func(): SignalBus.increase_max_fuel.emit(1)
		}
	],
	"Level 2" : [
		{
			"name": "Reinforced Hull 2",
			"description": "Increase max hull by 2.",
			"cost": 10,
			"apply": func(): SignalBus.increase_hull_health.emit(3)
		},
		{
			"name": "Beacon Tuner 2",
			"description": "Increase beacon detection range by 500 meters.",
			"cost": 10,
			"apply": func(): SignalBus.increase_beacon_range.emit(500)
		},
		{
			"name": "Fuel Tank Upgrade 2",
			"description": "Increase max fuel tanks by 3.",
			"cost": 10,
			"apply": func(): SignalBus.increase_max_fuel.emit(3)
		}
	],
	"Level 3" : [
		{
			"name": "Reinforced Hull 3",
			"description": "Double max hull.",
			"cost": 10,
			"apply": func(): SignalBus.increase_hull_health.emit(-1)
		},
		{
			"name": "Beacon Tuner 3",
			"description": "Double beacon range.",
			"cost": 10,
			"apply": func(): SignalBus.increase_beacon_range.emit(-1)
		},
		{
			"name": "Fuel Tank Upgrade 3",
			"description": "Double max fuel tanks.",
			"cost": 10,
			"apply": func(): SignalBus.increase_max_fuel.emit(-1)
		}
	]
}
