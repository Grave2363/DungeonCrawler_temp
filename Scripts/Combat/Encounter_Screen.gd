extends CanvasLayer

signal endCombat
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mob_base_dead():
	emit_signal("endCombat")


func _on_battle_screen_attack():
	$Panel/MobBase.takingDmg(10)
