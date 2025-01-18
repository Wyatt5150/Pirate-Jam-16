extends Resource
class_name Combatant

### STAT DECLARATIONS ###
var max_hp : int
var max_wp : int
var physical_attack : int
var magic_attack : int
var physical_defence : int
var magical_defence : int
var speed : int

var hp : int
var wp : int

### STATUS EFFECT DECLARATIONS ###
enum StatusEffect {POISON, PARALYZE, BURN}
var status_immunities : Array[StatusEffect] = []
var status_effects : Dictionary = {} # {StatusEffect : remaining_duration}

# Triggers At Start Of Each Turn
func _status_tick() -> void:
	for effect in status_effects.keys():
		pass

func aohsiokdh(effect : StatusEffect) -> void:
	pass

func _apply_status_effect(status : StatusEffect, duration:int=3) -> bool:
	if status in status_immunities: return false
	
	return false
