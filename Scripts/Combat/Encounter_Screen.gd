extends CanvasLayer

signal endCombat
const mob_01 : PackedScene = preload("res://Scenes/Battle/Mobs/Mob_Base.tscn")
var fighter01 
var mobs = []
# Called when the node enters the scene tree for the first time.
func _ready():
	fighter01 = mob_01.instantiate()
	fighter01.set_position(Vector2(308,246))
	fighter01.connect("dead", _on_mob_base_dead)
	$Panel.add_child(fighter01)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_mob_base_dead():
	emit_signal("endCombat")
	$Panel.get_child(0).queue_free()


func _on_battle_screen_attack():
	fighter01.takingDmg(10)


func _on_player_need_new_encounter():
	fighter01 = mob_01.instantiate()
	fighter01.set_position(Vector2(308,246))
	fighter01.connect("dead", _on_mob_base_dead)
	$Panel.add_child(fighter01)
