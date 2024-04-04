extends Node

class_name skillBase

var initialized = false

# Since Actions can be instanced by code (ie skills) these
# actions doesn't have an owner, that's why we get the owner
# from it's parent (BattlerActions.gd)
@onready var actor: BaseFighter = get_parent().get_owner()

@export var icon : Texture = load("res://assets/sprites/icons/slash.png")
@export var description: String = "Base combat action"


func initialize(fighter: BaseFighter) -> void:
	actor = fighter
	initialized = true


func execute(base : BaseFighter, target : BaseFighter, mod : int, type : String):
	assert(initialized)
	print("%s missing overwrite of the execute method" % name)
	return false


func can_use() -> bool:
	return true
