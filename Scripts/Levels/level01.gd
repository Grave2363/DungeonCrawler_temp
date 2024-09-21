extends Node3D
signal bossFight
signal resting
signal boss01ChoiceMade(choice)
# boss fight toggle, mainly for testing as player will not return
var bossFought = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func new_encounter():
	$Player/Encounter_Screen01.visible = !$Player/Encounter_Screen01.visible

func _on_player_encounter_start():
	new_encounter()
	$Player/BattleScreen.display_combat()


func _on_battle_screen_player_turn_end():
	$Player/BattleScreen.command_disable()
	$Player/BattleScreen.healer_turn()


func _on_turn_order_player_turn():
	$Player/BattleScreen.display_combat()


func _on_area_3d_area_entered(area):
	if bossFought == false:
		emit_signal("bossFight")
	else:
		pass


func _on_encounter_screen_01_boss_fight_activated():
	bossFought = true
	$Player/BattleScreen.BossFight(bossFought)



func _on_points_of_rest_popup_rest():
	$Player/RestPopup.visible = true


func _on_rest_no_pressed():
	$Player/RestPopup.visible = false


func _on_rest_yes_pressed():
	$Player/RestPopup.visible = false
	emit_signal("resting")


func _on_next_area_area_entered(area):
	$LeaveArea.visible = true


func _on_leave_yes_pressed():
	$LeaveArea.visible = false
	get_tree().change_scene_to_file("res://Scenes/Levels/Test_Room.tscn")


func _on_leave_no_pressed():
	$LeaveArea.visible = false


func _on_battle_screen_healer_turn_over():
	$Player/BattleScreen.command_disable()


func _on_turn_order_npc_01_turn():
	$Player/BattleScreen.healer_turn()



func _on_purify_pressed():
	emit_signal("boss01ChoiceMade", 1)
	$Player/ChoicePopUp.visible = false


func _on_embrace_pressed():
	emit_signal("boss01ChoiceMade", 2)
	$Player/ChoicePopUp.visible = false


func _on_encounter_screen_01_boss_dead():
	$Player/ChoicePopUp.visible = true 
