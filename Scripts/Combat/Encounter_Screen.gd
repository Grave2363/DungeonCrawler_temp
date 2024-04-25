extends CanvasLayer

signal endCombat
signal playerRan
const mob_01 : PackedScene = preload("res://Scenes/Battle/Mobs/Mob_Base.tscn")
const mob_02 : PackedScene = preload("res://Scenes/Battle/Mobs/Mob_temp02.tscn")
var fighter01 
var fighter02
var fighter03
var size
var target
var mobs = []
var rng = RandomNumberGenerator.new()
var mobXP = 0
var killedMob = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	target = 0
	var mob_num = rng.randf_range(0, 60)
	if mob_num <= 30:
		single_encounter()
	else: if mob_num > 30:
		multi_encounter()

func single_encounter():
	mobXP = 0
	var mob_spawn = rng.randf_range(0, 40)
	if mob_spawn < 20:
		fighter01 = mob_01.instantiate()
	else: if mob_spawn > 20:
		fighter01 = mob_02.instantiate()
	mobXP = fighter01.get_xp()
	fighter01.set_position(Vector2(308,246))
	fighter01.connect("dead", _on_mob_base_dead)
	$Panel.add_child(fighter01)
	mobs.append(fighter01)

func multi_encounter():
	mobXP = 0
	killedMob = 0
	var mob_spawn = rng.randf_range(0, 40)
	if mob_spawn < 20:
		fighter01 = mob_01.instantiate()
	else: if mob_spawn > 20:
		fighter01 = mob_02.instantiate()
	mobXP = fighter01.get_xp()
	fighter01.set_position(Vector2(308,246))
	fighter01.connect("dead", on_multi_mob_death)
	$Panel.add_child(fighter01)
	mobs.append(fighter01)
	mob_spawn = rng.randf_range(0, 40)
	if mob_spawn < 20:
		fighter02 = mob_01.instantiate()
	else: if mob_spawn > 20:
		fighter02 = mob_02.instantiate()
	mobXP = mobXP + fighter02.get_xp()
	fighter02.set_position(Vector2(508,246))
	fighter02.connect("dead", on_multi_mob_death)
	$Panel.add_child(fighter02)
	mobs.append(fighter02)
	mob_spawn = rng.randf_range(0, 40)
	if mob_spawn < 20:
		fighter03 = mob_01.instantiate()
	else: if mob_spawn > 20:
		fighter03 = mob_02.instantiate()
	mobXP = mobXP + fighter03.get_xp()
	fighter03.set_position(Vector2(708,246))
	fighter03.connect("dead", on_multi_mob_death)
	$Panel.add_child(fighter03)
	mobs.append(fighter03)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_xp():
	return mobXP

func _on_mob_base_dead():
	emit_signal("endCombat")
	$Panel.get_child(0).queue_free()
	mobs.remove_at(0)

func on_multi_mob_death():
	mobs.remove_at(target)
	$Panel.get_child(target).visible = false
	$Panel.get_child(target).queue_free()
	killedMob = killedMob + 1 
	target = 0
	multi_battle_end()

func multi_battle_end():
	if killedMob == 3:
		emit_signal("endCombat")

func _on_battle_screen_attack():
	mobs[target].takingDmg(10)


func _on_player_need_new_encounter():
	var mob_num = rng.randf_range(0, 60)
	if mob_num <= 30:
		single_encounter()
	else: if mob_num > 30:
		multi_encounter()


func _on_battle_screen_running():
	var x = 0
	var temp = mobs.size()
	while x < temp:
		$Panel.get_child(x).queue_free()
		mobs.remove_at(x)
		x = x + 1
	emit_signal("playerRan")


func _on_battle_screen_next_target():
	size = mobs.size()
	target = target + 1
	if target > size - 1:
		target = 0


func _on_battle_screen_prev_target():
	size = mobs.size()
	if target == 0:
		target = size - 1
	else :
		target = target - 1
