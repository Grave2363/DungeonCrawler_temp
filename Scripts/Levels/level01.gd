extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func new_encounter():
	$Player/Encounter_Screen.visible = !$Player/Encounter_Screen.visible

func _on_player_encounter_start():
	new_encounter()
	$Player/BattleScreen.display_combat()


func _on_battle_screen_player_turn_end():
	$Player/BattleScreen.command_disable()


func _on_turn_order_player_turn():
	$Player/BattleScreen.display_combat()
