extends Node3D

@onready var front_ray = $RayFront
@onready var back_ray = $RayBack
@onready var ray_left = $RayLeft
@onready var ray_right = $RayRight
signal encounter_start
signal need_new_encounter
var tween
var rng = RandomNumberGenerator.new()
var tween_running = false
const travel_time = 0.3
var dir = Vector3(0,0,0)
var dirAlt = Vector3(0,0,0)
var inFight = false
var encountersOn = true
var encounterCDTimer := Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(encounterCDTimer)
	encounterCDTimer.wait_time = 10.0
	encounterCDTimer.connect("timeout",_on_timer_timeout) 

func _on_timer_timeout():
	encountersOn = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func end_fight():
	inFight = false
	$Encounter_Screen.visible = false
	$BattleScreen.command_disable()
	encounterCDTimer.start()
	emit_signal("need_new_encounter")


func encounter_trigger():
	var encounter_rand = rng.randf_range(0, 40)
	if encounter_rand >= 30 and encountersOn == true:
		emit_signal("encounter_start")
		inFight = true
		encountersOn = false


func _physics_process(delta):
	if tween_running == true or inFight == true:
		return
	dir = global_transform.basis.z
	dirAlt = global_transform.basis.x
	if Input.is_action_pressed("ui_up") and not front_ray.is_colliding():
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.connect("finished", on_tween_finished)
		tween.tween_property(self,"transform", transform.translated(dir * -2), travel_time)
		tween_running = true
		encounter_trigger()
	if Input.is_action_pressed("ui_down") and not back_ray.is_colliding():
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.connect("finished", on_tween_finished)
		tween.tween_property(self,"transform", transform.translated(dir * 2), travel_time)
		tween_running = true
		encounter_trigger()
	if Input.is_action_pressed("ui_up_left") and not ray_left.is_colliding():
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.connect("finished", on_tween_finished)
		tween.tween_property(self,"transform", transform.translated((dir * -2) + (dirAlt * -2)), travel_time)
		tween_running = true
		encounter_trigger()
	if Input.is_action_pressed("ui_up_right") and not ray_right.is_colliding():
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.connect("finished", on_tween_finished)
		tween.tween_property(self,"transform", transform.translated((dir * -2) + (dirAlt * 2)), travel_time)
		tween_running = true
		encounter_trigger()
	if Input.is_action_pressed("ui_left") :
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.connect("finished", on_tween_finished)
		tween.tween_property(self, "transform:basis", transform.basis.rotated(Vector3.UP, PI / 2 ), travel_time)
		tween_running = true
		encounter_trigger()
	if Input.is_action_pressed("ui_right") :
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.connect("finished", on_tween_finished)
		tween.tween_property(self, "transform:basis", transform.basis.rotated(Vector3.UP, -PI / 2), travel_time)
		tween_running = true
		encounter_trigger()

func on_tween_finished():
	tween_running = false


func _on_button_pressed():
	$CanvasLayer/InventoryPopUp.visible = !$CanvasLayer/InventoryPopUp.visible


func _on_battle_screen_running():
	end_fight()


func _on_encounter_screen_end_combat():
	end_fight()
