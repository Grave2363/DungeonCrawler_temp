extends Node

class_name CharacterSkill

var level_unlock : int
var skillDis : String
var mpCost : int
var healing : int
var power : int
var hitChance : int
var dmgtype : String
var targetable : bool

func initialize (skill :Skill):
	name = skill.skillName
	skillDis = skill.skillDis
	healing = skill.healing
	mpCost = skill.mpCost
	power = skill.power
	hitChance = skill.hitChance
	dmgtype = skill.dmgType
	targetable = skill.targetable
