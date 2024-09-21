extends Node
signal player_turn
signal npc01_turn
signal mob_turn
signal resetPlayer
var combatOver = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_battle_screen_player_turn_end():
	
	if combatOver == true:
		emit_signal("player_turn")
		emit_signal("resetPlayer")
		combatOver = false
	else:
		emit_signal("npc01_turn")


func _on_encounter_screen_mob_turn_end():
	
	if combatOver == true:
		emit_signal("player_turn")
		emit_signal("resetPlayer")
		combatOver = false
	else :
		emit_signal("player_turn")


func _on_battle_screen_healer_turn_over():
	emit_signal("mob_turn")


func _on_encounter_screen_01_end_combat():
	combatOver = true
