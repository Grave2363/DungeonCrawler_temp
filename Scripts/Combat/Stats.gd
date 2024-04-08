extends Node

class_name characterStats

signal HelathChange(newHp)
signal HealthEmpty()

#used only for player
var max_HP : int
var max_Mp : int
var hp : int
var mp: int
var atk : int 
var def : int 
var mDef : int 
var mAtk : int 
# used for evasion
var spd : int 
var isPlayer : bool

func initialize(stats : StartingStats, wep : WepBase):
	isPlayer = stats.isPlayer
	max_HP  = stats.max_HP
	max_Mp = stats.max_Mp
	hp = stats.max_HP
	mp = stats.max_Mp
	atk = stats.atk + wep.atk 
	def = stats.def 
	mDef = stats.mDef 
	mAtk = stats.mAtk + wep.mAtk 
	spd = stats.spd

func get_hp():
	return hp

func mp_spent(cost : int):
	mp = mp - cost

func get_mp():
	return mp

func get_atk():
	return atk

func get_mAtk():
	return mAtk

func get_spd():
	return spd

func set_max_hp (value):
	max_HP = max(0, value)

func set_max_MP (value):
	max_HP = max(0, value)

#calc final dmg with atk dmg - def
func DmgTakenPhys(attack : int):
	if attack > def:
		hp = hp - (attack-def)
	if hp <= 0:
		emit_signal("HealthEmpty")

func DmgTakenMag(attack : int):
	if attack > mDef:
		hp = hp - (attack-mDef)
	if hp <= 0:
		emit_signal("HealthEmpty")

#run the evade check with spd
func hitCheck(attack):
	pass

func healing(val):
	hp += val
	emit_signal("HelathChange", val)

