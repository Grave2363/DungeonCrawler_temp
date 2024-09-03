extends CanvasLayer
signal running
signal attack1(mp: int, dmg: int)
signal nextTarget
signal prevTarget
signal player_turn_end
signal healer_turn_over
var active_character = 0
var inBossFight = false
var players = []
var attack01_player = Button.new()
var atk01Cost_player = 0
var attack01_npc01 = Button.new()
var atk01Cost_npc01 = 0
var skillArray_player01 = [attack01_player]
var costArray_player01 = [atk01Cost_player]
var skillArray_npc01 = [attack01_npc01]
var costArray_npc01 = [atk01Cost_npc01]
# Called when the node enters the scene tree for the first time.
func _ready():
	createPlayer_Atks()
	createNpc01_atk()
	players.append($Panel/Player_base)
	players.append($Panel/Npc01)

func createPlayer_Atks():
	atk01Cost_player = $Panel/Player_base/Job/CharacterSkill.get_child(0).mpCost 
	attack01_player.text = $Panel/Player_base/Job/CharacterSkill.get_child(0).name + "  MP : " + str(atk01Cost_player)
	attack01_player.set_position(Vector2(20,20))
	attack01_player.set_size(Vector2(80,20))
	$Panel/Attacks_Player.add_child(attack01_player)
	attack01_player.connect("pressed", on_attack01_pressed)

func createNpc01_atk():
	atk01Cost_npc01 = $Panel/Npc01/Job/CharacterSkill.get_child(0).mpCost 
	attack01_npc01.text = $Panel/Npc01/Job/CharacterSkill.get_child(0).name + "  MP : " + str(atk01Cost_npc01)
	attack01_npc01.set_position(Vector2(20,20))
	attack01_npc01.set_size(Vector2(80,20))
	$Panel/Attacks_Healer.add_child(attack01_npc01)
	attack01_npc01.connect("pressed", on_Npc01_attack01_pressed)

func on_attack01_pressed():
	var atk01Pow = $Panel/Player_base/Job/CharacterSkill.get_child(0).power
	var playerAtk = $Panel/Player_base/Job/Stats.get_atk()
	var totalDmg = atk01Pow + playerAtk
	active_character = 1
	emit_signal("attack1", atk01Cost_player,totalDmg)
	player_turns_over()

func on_Npc01_attack01_pressed():
	var atk01Pow = $Panel/Npc01/Job/CharacterSkill.get_child(0).power
	var playerAtk = $Panel/Npc01/Job/Stats.get_atk()
	var totalDmg = atk01Pow + playerAtk
	active_character = 0
	emit_signal("attack1", atk01Cost_player,totalDmg)
	healer_turns_over()

func player_turns_over():
	emit_signal("player_turn_end")

func healer_turns_over():
	emit_signal("healer_turn_over")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func battleWon(xp):
	$Panel/Player_base.xp_gained(xp)

func _on_run_pressed():
	if inBossFight == false:
		emit_signal("running")
		active_character = 0
		command_disable()

func BossFight(fight : bool):
	inBossFight = fight

func display_combat():
	$Panel/Attack.visible = true
	$Panel/Run.visible = true
	$Panel/Guard.visible = true
	$Panel/Target_left.visible = true
	$Panel/Target_right.visible = true
	$Panel/ActiveTurnPlayer.visible = true

func command_disable():
	$Panel/Attack.visible = false
	$Panel/Run.visible = false
	$Panel/Guard.visible = false
	$Panel/Attacks_Player.visible = false
	$Panel/Attacks_Healer.visible = false
	$Panel/Target_left.visible = false
	$Panel/Target_right.visible = false
	$Panel/ActiveTurnPlayer.visible = false
	$Panel/ActiveTurnNpc01.visible = false

func healer_turn():
	$Panel/Attacks_Healer.visible = true
	$Panel/Attack.visible = true
	$Panel/Run.visible = true
	$Panel/Guard.visible = true
	$Panel/Target_left.visible = true
	$Panel/Target_right.visible = true
	$Panel/ActiveTurnNpc01.visible = true

func _on_attack_pressed():
	if active_character == 0:
		$Panel/Attacks_Player.visible = !$Panel/Attacks_Player.visible
	elif active_character == 1:
		$Panel/Attacks_Healer.visible = !$Panel/Attacks_Healer.visible

func player_dmg_taken(dmg:int):
	$Panel/Player_base.DmgTakenPhys(dmg)

func _on_target_right_pressed():
	emit_signal("nextTarget")


func _on_target_left_pressed():
	emit_signal("prevTarget")


func _on_chests_wep_change(new_wep):
	$Panel/Player_base/Job.wep_changed(new_wep)


func _on_encounter_screen_mob_atk(dmg):
	player_dmg_taken(dmg)


func _on_level_resting():
	$Panel/Player_base.fullHeal()

# game over
func _on_player_base_died(BaseFighter):
	pass # Replace with function body.



func _on_mending_light_pressed():
	$Panel/Player_base.healing(10)
	$Panel/Npc01.healing(10)
	$Panel/Npc01.skillUsed(2)
	healer_turns_over()



func _on_turn_order_reset_player():
	command_disable()
	active_character = 0
