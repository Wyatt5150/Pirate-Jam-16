extends Resource
class_name Combatant

### STAT DECLARATIONS ###
var max_hp : int
var max_wp : int
var physical_attack : int : 
	get(): return ceili(physical_attack * physical_attack_status_modifier)
var magical_attack : int :
	get(): return ceili(magical_attack * magical_attack_status_modifier)
var physical_defence : int :
	get(): return ceili(physical_defence * physical_defence_status_modifier)
var magical_defence : int :
	get(): return ceili(magical_defence * magical_defence_status_modifier)
var speed : int :
	get(): return ceili(speed * speed_status_modifier)

var hp : int : 
	set(new_val):
		if new_val < 1:
			alive = false
			hp = 0
		
var wp : int

### FLAGS ###
var alive : bool = true

### STATUS EFFECT DECLARATIONS ###
enum StatusEffect {POISON, BURN, FREEZE, SLOW, HASTE}
var status_immunities : Array[StatusEffect] = []
var status_effects : Dictionary = {} # {StatusEffect : remaining_duration}
var status_strength : float = 1.

var physical_attack_status_modifier : float = 1.
var magical_attack_status_modifier : float = 1.
var physical_defence_status_modifier : float = 1.
var magical_defence_status_modifier : float = 1.
var speed_status_modifier : float = 1.


func damage(damage, physical : bool = true):
	if physical:
		hp -= damage * physical_defence
	else:
		hp -= damage * magical_defence

# Triggers At Start Of Each Turn
func status_tick() -> void:
	physical_attack_status_modifier = 1.
	magical_attack_status_modifier = 1.
	physical_defence_status_modifier = 1.
	magical_defence_status_modifier = 1.
	speed_status_modifier = 1.
	
	for effect in status_effects.keys():
		
		_status_tick(effect)
		if status_effects[effect] == -1:
			pass
		else:
			status_effects[effect] -= 1
			if status_effects[effect] < 1:
				remove_status_effect(effect)

func apply_status_effect(status : StatusEffect, duration:int=3) -> bool:
	if status in status_immunities: return false
	
	return false

func remove_status_effect(status : StatusEffect) -> void:
	status_effects.erase(status)

func clear_status_effects() -> void:
	"""
	Clears all non-infinite duration (-1) status effects.
	"""
	for effect in status_effects.keys():
		if status_effects[effect] > 0:
			remove_status_effect(effect)

#TODO: Move each status into it's own function, probably post jam.
func _status_tick(effect : StatusEffect) -> void:
	match effect:
		StatusEffect.POISON:
			hp -= (max_hp * 0.10 * status_strength)
		StatusEffect.BURN:
			hp -= (max_hp * 0.10 * status_strength)
		StatusEffect.FREEZE:
			magical_attack_status_modifier *= 0.8
			magical_defence_status_modifier *= 0.8
			speed_status_modifier *= 0.8
		StatusEffect.SLOW:
			speed_status_modifier *= 0.5
		StatusEffect.HASTE:
			speed_status_modifier *= 1.5
		_:
			printerr("Status effect not registered.")
			return
