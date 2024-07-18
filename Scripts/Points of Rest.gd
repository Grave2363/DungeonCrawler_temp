extends Node3D

signal popupRest
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_point_of_rest_will_you_rest():
	emit_signal("popupRest")
