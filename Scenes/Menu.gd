extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/town.tscn")


func _on_load_save_pressed():
	pass # Replace with function body.


func _on_close_game_pressed():
	pass # Replace with function body.
