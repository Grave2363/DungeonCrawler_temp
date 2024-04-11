extends Node2D

signal dead
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func takingDmg(dmg):
	$MenuBar/HP.value = $MenuBar/HP.value - dmg
	if $MenuBar/HP.value <= 0:
		emit_signal("dead")

func get_xp():
	return $Job.get_xp()

func _on_job_health_empty():
	emit_signal("dead")
