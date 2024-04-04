extends CanvasLayer
signal running

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_run_pressed():
	emit_signal("running")
	command_disable()

func command_disable():
	$Panel/Attack.visible = !$Panel/Attack.visible
	$Panel/Run.visible = !$Panel/Run.visible
	$Panel/Guard.visible = !$Panel/Guard.visible
