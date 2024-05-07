@tool
extends Node


class_name job

signal HelathChange(newHp)
signal HealthEmpty()

@onready var stats = $Stats
@onready var skills = $CharacterSkill
@onready var wep = $Weapons
@onready var gloves = $Gloves
@onready var boots = $Boots
@onready var helm = $Helm
@onready var chest = $ChestArmor
@onready var item = $Item
@export var startingStats : Resource
@export var StartingSkills : Array
@export var characterSkillScene : PackedScene
@export var equipedWep : Resource
@export var equipedItem : Resource
@export var equipedChest : Resource
@export var equipedBoots : Resource
@export var equipedHelm : Resource
@export var equipedGloves : Resource
@export var itemScene : PackedScene

func _ready():
	stats.initialize(startingStats, equipedWep)
	wep.initialize(equipedWep)
	if StartingSkills != null and StartingSkills.size() > 0:
		for skill in StartingSkills :
			var newSkill = characterSkillScene.instantiate()
			newSkill.initialize(skill)
			skills.add_child(newSkill)
	var newItem = itemScene.instantiate()
	newItem.initialize(equipedItem)
	item.add_child(newItem)

func get_xp():
	return startingStats.provided_xp
