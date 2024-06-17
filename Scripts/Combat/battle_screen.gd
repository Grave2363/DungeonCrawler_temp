extends CanvasLayer
signal running
signal attack1(mp: int, dmg: int)
signal nextTarget
signal prevTarget
signal player_turn_end
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
	atk01Cost_player = $Panel/Player_base/Job/CharacterSkill.get_child(0).mpCost 
	attack01_player.text = $Panel/Player_base/Job/CharacterSkill.get_child(0).name + "  MP : " + str(atk01Cost_player)
	attack01_player.set_position(Vector2(20,20))
	attack01_player.set_size(Vector2(80,20))
	$Panel/Attacks.add_child(attack01_player)
	attack01_player.connect("pressed", on_attack01_pressed)
	players.append($Panel/Player_base)
	if $Panel/npc_01.visible == true:
		players.append($Panel/npc_01)

func on_attack01_pressed():
	var atk01Pow = $Panel/Player_base/Job/CharacterSkill.get_child(0).power
	var playerAtk = $Panel/Player_base/Job/Stats.get_atk()
	var totalDmg = atk01Pow + playerAtk
	emit_signal("attack1", atk01Cost_player,totalDmg)
	player_turns_over()

func player_turns_over():
	emit_signal("player_turn_end")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func battleWon(xp):
	$Panel/Player_base.xp_gained(xp)

func _on_run_pressed():
	emit_signal("running")
	command_disable()

func display_combat():
	$Panel/Attack.visible = true
	$Panel/Run.visible = true
	$Panel/Guard.visible = true
	$Panel/Target_left.visible = true
	$Panel/Target_right.visible = true

func command_disable():
	$Panel/Attack.visible = false
	$Panel/Run.visible = false
	$Panel/Guard.visible = false
	$Panel/Attacks.visible = false
	$Panel/Target_left.visible = false
	$Panel/Target_right.visible = false


func _on_attack_pressed():
	$Panel/Attacks.visible = !$Panel/Attacks.visible

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
