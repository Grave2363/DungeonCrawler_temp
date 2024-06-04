extends CanvasLayer
signal running
signal attack1(mp: int, dmg: int)
signal nextTarget
signal prevTarget
signal player_turn_end
var attack01 = Button.new()
var atk01Cost = 0
var skillArray = [attack01]
var costArray = [atk01Cost]
# Called when the node enters the scene tree for the first time.
func _ready():
	atk01Cost = $Panel/Player_base/Job/CharacterSkill.get_child(0).mpCost 
	attack01.text = $Panel/Player_base/Job/CharacterSkill.get_child(0).name + "  MP : " + str(atk01Cost)
	attack01.set_position(Vector2(20,20))
	attack01.set_size(Vector2(80,20))
	$Panel/Attacks.add_child(attack01)
	attack01.connect("pressed", on_attack01_pressed)

func on_attack01_pressed():
	var atk01Pow = $Panel/Player_base/Job/CharacterSkill.get_child(0).power
	var playerAtk = $Panel/Player_base/Job/Stats.get_atk()
	var totalDmg = atk01Pow + playerAtk
	emit_signal("attack1", atk01Cost,totalDmg)
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
	pass

func _on_target_right_pressed():
	emit_signal("nextTarget")


func _on_target_left_pressed():
	emit_signal("prevTarget")


func _on_chests_wep_change(new_wep):
	$Panel/Player_base/Job.wep_changed(new_wep)


func _on_encounter_screen_mob_atk(dmg):
	player_dmg_taken(dmg)
