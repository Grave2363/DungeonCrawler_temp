extends skillBase

var available_skill : CharacterSkill

func _ready() ->void:
	name = available_skill.name
	randomize()
#castor for atk/matk, target for atk, modifier for dmg
func execute(actor : BaseFighter, target : BaseFighter, mod : int, dmgType : String)-> void:
	if available_skill.hitChance == 100:
		if dmgType == "Physical":
			target.DmgTakenPhys(actor.get_atk()*mod)
		else :
			target.DmgTakenMag(actor.get_mAtk()*mod)
	else : 
		randomize()
		if randi_range(0, 100) < available_skill.hitChance:
			if dmgType == "Physical":
				target.DmgTakenPhys(actor.get_atk()*mod)
			else :
				target.DmgTakenMag(actor.get_mAtk()*mod)
	emit_signal("action is finished")
	
