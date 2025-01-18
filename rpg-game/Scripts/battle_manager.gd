extends Control
class_name BattleManager

var ally_list : Array[Combatant] = []
var enemy_list : Array[Combatant] = []

var turn_queue : Array = []

var turn : int = 0

enum BattleState {START, INPROGRESS, WIN, LOSE}
var battle_state : BattleState = BattleState.START


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await _prebattle_setup()
	
	while battle_state == BattleState.INPROGRESS:
		turn += 1
		await _process_loop()
	
	await _battle_end()


func _prebattle_setup() -> void:
	#TODO: Play Battle Entry Animation
	
	#TODO: Determine Encouter
	
	#TODO: Draw enemy sprites and create a health bar next to them
	
	#TODO: Show player sprites in correct form and have health bar match stats
	pass

func _process_loop() -> void:
	pass

func _battle_end() -> void:
	if battle_state == BattleState.WIN:
		#TODO: Give Rewards
		pass
	elif battle_state == BattleState.LOSE:
		#TODO: Switch To Gameover Screen
		pass
