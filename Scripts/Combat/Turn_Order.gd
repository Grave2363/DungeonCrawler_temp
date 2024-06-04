extends Node
signal player_turn
signal mob_turn
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_battle_screen_player_turn_end():
	emit_signal("mob_turn")


func _on_encounter_screen_mob_turn_end():
	emit_signal("player_turn")
