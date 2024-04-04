@tool
extends Node


class_name job

signal HelathChange(newHp)
signal HealthEmpty()

@onready var stats = $Stats
@onready var skills = $CharacterSkill
@onready var wep = $Weapons
@onready var item = $Item
@export var startingStats : Resource
@export var StartingSkills : Array
@export var characterSkillScene : PackedScene
@export var equipedWep : Resource
@export var equipedItem : Resource
@export var itemScene : PackedScene

func _ready():
	stats.initialize(startingStats, equipedWep)
	wep.initialize(equipedWep)
	if StartingSkills != null and StartingSkills.size() > 0:
		for skill in StartingSkills :
			var newSkill = characterSkillScene.instantiate()
			newSkill.initalize(skill)
			skills.add_child(newSkill)
	var newItem = itemScene.instantiate()
	newItem.initalize(equipedItem)
	item.add_child(newItem)

