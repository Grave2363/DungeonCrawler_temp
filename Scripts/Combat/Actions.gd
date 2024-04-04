extends Node

class_name Actions

@export var skill_action_scene : PackedScene 

func initialize(skills : Array):
	for skill in skills:
		var new_skill = skill_action_scene.instance()
		new_skill.available_skill = skill
		add_child(new_skill)
