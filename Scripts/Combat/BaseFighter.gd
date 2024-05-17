extends Node
class_name BaseFighter

signal died(BaseFighter)
signal tookDamange(BaseFighter)

# for player ignore the errors for drops
@export var special_item : Resource
@export var stats: Resource
@export var growths : Resource
# for nonplayer(s)
@onready var actions = $Actions
@onready var bars = $Bars
@onready var skills = $CharacterSkill
@onready var player_stats = $Job/Stats
# for the nonplayer target(s)
var xp_to_lvl = 30
var level = 1
var xp_gathered = 0
var selected: bool = false 
var selectable: bool = false 
var display_name: String
var rng = RandomNumberGenerator.new()

func initialize():
	actions.initialize(skills.get_children())
	$Bars/HP.max_value = stats.max_HP
	$Bars/MP.max_value = stats.max_Mp
	$Bars/HP.value = stats.max_HP
	$Bars/MP.value = stats.max_Mp
	$Bars/HP/Player_HP.text = str(stats.max_HP)    
	$Bars/MP/Player_MP.text = str(stats.max_Mp)

func skillUsed(cost : int):
	$Job/Stats.mp_spent(cost)
	$Bars/MP.value = $Job/Stats.get_mp()

func DmgTakenPhys(attack : int):
	$Job/Stats.DmgTakenPhys(attack)
	$Bars/HP.value =  $Job/Stats.get_hp()
	emit_signal("tookDamange")
	if $Job/Stats.get_hp() <= 0:
		emit_signal("died", self)

func DmgTakenMag(attack : int):
	$Job/Stats.DmgTakenMag(attack)
	$Bars/HP.value =  $Job/Stats.get_hp()
	emit_signal("tookDamange")
	if $Job/Stats.get_hp() <= 0:
		emit_signal("died", self)

func healing(heal : int):
	$Job/Stats.healing(heal)
	$Bars/HP.value =  $Job/Stats.get_hp()

func _on_health_depleted():
	selectable = false
	emit_signal("died", self)

func xp_gained(xp : int):
	xp_gathered = xp_gathered + xp
	if xp_gathered >= xp_to_lvl:
		xp_gathered = xp_gathered - xp_to_lvl
		level = level + 1
		xp_to_lvl = xp_to_lvl * level
		levelup()

func levelup():
	randomize()
	var stat_gain = rng.randf_range(0, 100)
	var hp = 0
	var mp = 0
	var atk = 0
	var def = 0
	var spd = 0
	var mdef = 0
	var matk = 0
	if stat_gain <= growths.max_HP:
		hp = 10
	if stat_gain <= growths.max_Mp:
		mp = 10
	if stat_gain <= growths.atk:
		atk = 1
	if stat_gain <= growths.def:
		def = 1
	if stat_gain <= growths.spd:
		spd = 1
	if stat_gain <= growths.mDef:
		mdef = 1
	if stat_gain <= growths.mAtk:
		matk = 1
	player_stats.level_up_stats(hp , mp , atk , def , mdef, matk , spd )

func _on_job_health_empty():
	emit_signal("died", self)


func _on_battle_screen_attack_1(mp: int):
	skillUsed(mp)
