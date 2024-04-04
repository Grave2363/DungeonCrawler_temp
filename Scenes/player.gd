extends Node3D

@onready var front_ray = $RayFront
@onready var back_ray = $RayBack
var tween
var tween_running = false
const travel_time = 0.3
var dir = Vector3(0,0,0)
var inFight = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if tween_running == true or inFight == true:
		return
	dir = global_transform.basis.z
	if Input.is_action_pressed("ui_up") and not front_ray.is_colliding():
		tween = create_tween()
		tween.connect("finished", on_tween_finished)
		tween.tween_property(self,"transform", transform.translated(dir * -2), travel_time)
		tween_running = true
	if Input.is_action_pressed("ui_down") and not back_ray.is_colliding():
		tween = create_tween()
		tween.connect("finished", on_tween_finished)
		tween.tween_property(self,"transform", transform.translated(dir * 2), travel_time)
		tween_running = true
	if Input.is_action_pressed("ui_left") :
		tween = create_tween()
		tween.connect("finished", on_tween_finished)
		tween.tween_property(self, "transform:basis", transform.basis.rotated(Vector3.UP, PI / 2 ), travel_time)
		tween_running = true
	if Input.is_action_pressed("ui_right") :
		tween = create_tween()
		tween.connect("finished", on_tween_finished)
		tween.tween_property(self, "transform:basis", transform.basis.rotated(Vector3.UP, -PI / 2), travel_time)
		tween_running = true

func on_tween_finished():
	tween_running = false


func _on_button_pressed():
	$CanvasLayer/InventoryPopUp.visible = !$CanvasLayer/InventoryPopUp.visible


func _on_battle_screen_running():
	inFight = false
