extends CanvasLayer
signal running
signal attack
var attack01 = Button.new()
var skillArray = [attack01]
# Called when the node enters the scene tree for the first time.
func _ready():
	attack01.text = $Panel/Player_base/Job/CharacterSkill.get_child(0).name
	attack01.set_position(Vector2(20,20))
	attack01.set_size(Vector2(80,20))
	$Panel/Attacks.add_child(attack01)
	attack01.connect("pressed", on_attack01_pressed)

func on_attack01_pressed():
	emit_signal("attack")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_run_pressed():
	emit_signal("running")
	command_disable()
func display_combat():
	$Panel/Attack.visible = true
	$Panel/Run.visible = true
	$Panel/Guard.visible = true

func command_disable():
	$Panel/Attack.visible = false
	$Panel/Run.visible = false
	$Panel/Guard.visible = false
	$Panel/Attacks.visible = false


func _on_attack_pressed():
	$Panel/Attacks.visible = !$Panel/Attacks.visible
