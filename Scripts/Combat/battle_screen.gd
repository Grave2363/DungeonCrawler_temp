extends CanvasLayer
signal running
signal attack1(mp: int, dmg: int)
signal attack2(mp: int, dmg: int)
signal nextTarget
signal prevTarget
signal player_turn_end
signal healer_turn_over
signal displayText(text)
var boss01Choice = 0
# 0 = not fought, 1 = Reject, 2 = embrace
var rng = RandomNumberGenerator.new()
var active_character = 0
var dmgReductionAmount = 0
var inBossFight = false
var players = []
var attack01_player = Button.new()
var attack02_player = Button.new()
var attack02_playerAlt = Button.new()
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
	createNpc01_atks()
	players.append($Panel/Player_base)
	players.append($Panel/Npc01)

func createPlayer_Atks():
	createPlayerAtk01()
	createPlayerAtk02()
	createPlayerAtk02Alt()

func createNpc01_atks():
	createNpcAtk01()

func createPlayerAtk01():
	var playercost = $Panel/Player_base/Job/CharacterSkill.get_child(0).mpCost 
	costArray_player01.append(playercost)
	attack01_player.text = $Panel/Player_base/Job/CharacterSkill.get_child(0).name + "  MP : " + str(playercost)
	attack01_player.set_position(Vector2(20,20))
	attack01_player.set_size(Vector2(80,20))
	$Panel/Attacks_Player.add_child(attack01_player)
	attack01_player.connect("pressed", on_attack01_pressed)

func createPlayerAtk02(): #path 1
	var playercost = $Panel/Player_base/Job/CharacterSkill.get_child(1).mpCost 
	costArray_player01.append(playercost)
	attack02_player.text = $Panel/Player_base/Job/CharacterSkill.get_child(1).name + "  MP : " + str(playercost)
	attack02_player.set_position(Vector2(140,20))
	attack02_player.set_size(Vector2(80,20))
	$Panel/Attacks_Player.add_child(attack02_player)
	attack02_player.connect("pressed", on_attack02_pressed)
	if boss01Choice != 1:
		attack02_player.visible = false

func createPlayerAtk02Alt(): #path 2
	var playercost = $Panel/Player_base/Job/CharacterSkill.get_child(2).mpCost 
	costArray_player01.append(playercost)
	attack02_playerAlt.text = $Panel/Player_base/Job/CharacterSkill.get_child(2).name + "  MP : " + str(playercost)
	attack02_playerAlt.set_position(Vector2(140,20))
	attack02_playerAlt.set_size(Vector2(80,20))
	$Panel/Attacks_Player.add_child(attack02_playerAlt)
	attack02_playerAlt.connect("pressed", on_attack03_pressed)
	if boss01Choice != 2:
		attack02_player.visible = false

func createNpcAtk01():
	var npc_atk01Cost = $Panel/Npc01/Job/CharacterSkill.get_child(0).mpCost 
	costArray_npc01.append(npc_atk01Cost)
	attack01_npc01.text = $Panel/Npc01/Job/CharacterSkill.get_child(0).name + "  MP : " + str(npc_atk01Cost)
	attack01_npc01.set_position(Vector2(20,20))
	attack01_npc01.set_size(Vector2(80,20))
	$Panel/Attacks_Healer.add_child(attack01_npc01)
	attack01_npc01.connect("pressed", on_Npc01_attack01_pressed)

func on_attack01_pressed():
	var atk01Pow = $Panel/Player_base/Job/CharacterSkill.get_child(0).power
	var playerAtk = $Panel/Player_base/Job/Stats.get_atk()
	var totalDmg = atk01Pow + playerAtk
	active_character = 1
	emit_signal("attack1", costArray_player01[0],totalDmg)
	player_turns_over()

func on_attack02_pressed():
	dmgReductionAmount = 0.25
	active_character = 1
	$Panel/Player_base.skillUsed(2)
	player_turns_over()

func on_attack03_pressed():
	var atk01Pow = $Panel/Player_base/Job/CharacterSkill.get_child(2).power
	var playerAtk = $Panel/Player_base/Job/Stats.get_atk()
	var totalDmg = atk01Pow + playerAtk
	active_character = 1
	emit_signal("attack2", costArray_player01[2],totalDmg)
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
		if boss01Choice != 1:
			attack02_player.visible = false
		if boss01Choice != 2:
			attack02_playerAlt.visible = false
	elif active_character == 1:
		$Panel/Attacks_Healer.visible = !$Panel/Attacks_Healer.visible

func player_dmg_taken(dmg:int):
	if dmgReductionAmount > 0:
		var temp = int(dmg * dmgReductionAmount)
		$Panel/Player_base.DmgTakenPhys(temp)
		emit_signal("displayText", "Player took " + str(temp) + " Damage"  ) 
	else :
		$Panel/Player_base.DmgTakenPhys(dmg)
		emit_signal("displayText", "Player took " + str(dmg) + " Damage"  ) 

func Npc01_dmg_taken(dmg:int):
	if dmgReductionAmount > 0:
		var temp = int(dmg * dmgReductionAmount)
		$Panel/Npc01.DmgTakenPhys(temp)
		emit_signal("displayText",  "NPC_Healer took " + str(temp) + " Damage" )
	else :
		$Panel/Npc01.DmgTakenPhys(dmg)
		emit_signal("displayText",  "NPC_Healer took " + str(dmg) + " Damage" )

func _on_target_right_pressed():
	emit_signal("nextTarget")


func _on_target_left_pressed():
	emit_signal("prevTarget")


func _on_chests_wep_change(new_wep):
	$Panel/Player_base/Job.wep_changed(new_wep)


func _on_encounter_screen_mob_atk(dmg):
	var atkTarget = rng.randf_range(0, 40)
	if atkTarget < 20:
		var atkHit = rng.randf_range(0, 100)
		var temp =$Panel/Player_base/Job/Stats.get_spd() + 25
		if atkHit > temp:
			player_dmg_taken(dmg)
		else :
			emit_signal("displayText", "Player eveded attack") 
	else :
		var atkHit = rng.randf_range(0, 100)
		var temp =$Panel/Npc01/Job/Stats.get_spd() + 25 
		if atkHit > temp:
			Npc01_dmg_taken(dmg)
		else :
			emit_signal("displayText","Player eveded attack" )


func _on_level_resting():
	$Panel/Player_base.fullHeal()
	$Panel/Npc01.fullHeal()

# game over
func _on_player_base_died(BaseFighter):
	pass # Replace with function body.



func _on_mending_light_pressed():
	$Panel/Player_base.healing(10)
	$Panel/Npc01.healing(10)
	$Panel/Npc01.skillUsed(2)
	active_character = 0
	healer_turns_over()



func _on_turn_order_reset_player():
	command_disable()
	active_character = 0


func _on_level_boss_01_choice_made(choice):
	boss01Choice = choice
