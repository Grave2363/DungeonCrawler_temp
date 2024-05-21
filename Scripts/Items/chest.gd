extends Node3D
signal Chest_Opened(drop:Resource)
@export var loot : Resource
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_static_body_3d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	emit_signal("Chest_Opened", loot)
	$AnimationPlayer.chest_open()

