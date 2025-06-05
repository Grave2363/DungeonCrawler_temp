extends Node2D

# val of the dungeon selected
var dungeon = 0
#val of the CP selected
var cpSel = 0
#dungeons unlocked
var availableDungeons = 0
#weather the player has found the hiden market
var hiddenMarket = 0
#CP unlocked
var cp_active = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	hiddenMarket = Globals.getHM()
	availableDungeons = Globals.getAD()
	cp_active = Globals.getCPA()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_church_pressed():
	pass
	#$"CanvasLayer/Top Menu".visible = false
	# todo add church related options and background


func _on_dungeon_pressed():
	$"CanvasLayer/Top Menu".visible = false
	$CanvasLayer/DungeonLevels.visible = true
	match availableDungeons:
		0:
			$CanvasLayer/DungeonLevels/Area1.visible = true
		1:
			$CanvasLayer/DungeonLevels/Area2.visible = true
		2:
			$"CanvasLayer/DungeonLevels/Area 3".visible = true


func _on_market_pressed():
	$"CanvasLayer/Top Menu".visible = false
	$"CanvasLayer/Market Menu".visible = true


func _on_black_market_pressed():
	pass # Replace with function body.


func _on_armorer_pressed():
	pass # Replace with function body.


func _on_potion_shop_pressed():
	pass # Replace with function body.


func _on_wep_smith_pressed():
	pass # Replace with function body.

#both default val and option for first dungeon
func _on_area_1_pressed():
	$CanvasLayer/AreaLevelSelect.visible = true
	dungeon = 0
	match cp_active:
		0:
			$CanvasLayer/AreaLevelSelect/CP1.visible = false
			$CanvasLayer/AreaLevelSelect/CP2.visible = false
			$CanvasLayer/AreaLevelSelect/CP3.visible = false
			$CanvasLayer/AreaLevelSelect/BossCP.visible = false
		1:
			$CanvasLayer/AreaLevelSelect/CP1.visible = true
		2:
			$CanvasLayer/AreaLevelSelect/CP1.visible = true
			$CanvasLayer/AreaLevelSelect/CP2.visible = true
		3:
			$CanvasLayer/AreaLevelSelect/CP1.visible = true
			$CanvasLayer/AreaLevelSelect/CP2.visible = true
			$CanvasLayer/AreaLevelSelect/CP3.visible = true
		4,5,6,7,8,9,10,11,12,13,14:
			$CanvasLayer/AreaLevelSelect/CP1.visible = true
			$CanvasLayer/AreaLevelSelect/CP2.visible = true
			$CanvasLayer/AreaLevelSelect/CP3.visible = true
			$CanvasLayer/AreaLevelSelect/BossCP.visible = true

#second dungeon not implemented 
func _on_area_2_pressed():
	$CanvasLayer/AreaLevelSelect.visible = true
	dungeon = 1
	match cp_active:
		5:
			$CanvasLayer/AreaLevelSelect/CP1.visible = false
			$CanvasLayer/AreaLevelSelect/CP2.visible = false
			$CanvasLayer/AreaLevelSelect/CP3.visible = false
			$CanvasLayer/AreaLevelSelect/BossCP.visible = false
		6:
			$CanvasLayer/AreaLevelSelect/CP1.visible = true
		7:
			$CanvasLayer/AreaLevelSelect/CP1.visible = true
			$CanvasLayer/AreaLevelSelect/CP2.visible = true
		8:
			$CanvasLayer/AreaLevelSelect/CP1.visible = true
			$CanvasLayer/AreaLevelSelect/CP2.visible = true
			$CanvasLayer/AreaLevelSelect/CP3.visible = true
		9,10,11,12,13,14:
			$CanvasLayer/AreaLevelSelect/CP1.visible = true
			$CanvasLayer/AreaLevelSelect/CP2.visible = true
			$CanvasLayer/AreaLevelSelect/CP3.visible = true
			$CanvasLayer/AreaLevelSelect/BossCP.visible = true

#Third dungeon not implemnted
func _on_area_3_pressed():
	$CanvasLayer/AreaLevelSelect.visible = true
	dungeon = 2
	match cp_active:
		10:
			$CanvasLayer/AreaLevelSelect/CP1.visible = false
			$CanvasLayer/AreaLevelSelect/CP2.visible = false
			$CanvasLayer/AreaLevelSelect/CP3.visible = false
			$CanvasLayer/AreaLevelSelect/BossCP.visible = false
		11:
			$CanvasLayer/AreaLevelSelect/CP1.visible = true
		12:
			$CanvasLayer/AreaLevelSelect/CP1.visible = true
			$CanvasLayer/AreaLevelSelect/CP2.visible = true
		13:
			$CanvasLayer/AreaLevelSelect/CP1.visible = true
			$CanvasLayer/AreaLevelSelect/CP2.visible = true
			$CanvasLayer/AreaLevelSelect/CP3.visible = true
		14:
			$CanvasLayer/AreaLevelSelect/CP1.visible = true
			$CanvasLayer/AreaLevelSelect/CP2.visible = true
			$CanvasLayer/AreaLevelSelect/CP3.visible = true
			$CanvasLayer/AreaLevelSelect/BossCP.visible = true


func _on_entrance_pressed():
	cpSel = 0
	enterDungeon()


func _on_cp_1_pressed():
	pass # Replace with function body.


func _on_cp_2_pressed():
	pass # Replace with function body.


func _on_cp_3_pressed():
	pass # Replace with function body.


func _on_boss_cp_pressed():
	pass # Replace with function body.


func _on_market_back_pressed():
	$"CanvasLayer/Market Menu".visible = false
	$"CanvasLayer/Top Menu".visible = true


func _on_dungeon_back_pressed():
	$CanvasLayer/DungeonLevels.visible = false
	$CanvasLayer/AreaLevelSelect.visible = false
	$"CanvasLayer/Top Menu".visible = true

func enterDungeon():
	match dungeon:
		0:
			match cpSel:
				0:
					get_tree().change_scene_to_file("res://Scenes/Levels/level01.tscn")
				1: 
					pass
				2:
					pass
				3:
					pass
				4:
					pass
		1:
			match cpSel:
				0:
					pass
				1: 
					pass
				2:
					pass
				3:
					pass
				4:
					pass
					
		2:
			match cpSel:
				0:
					pass
				1: 
					pass
				2:
					pass
				3:
					pass
				4:
					pass
	



func _on_armor_upgrade_pressed():
	pass # Replace with function body.


func _on_armorbuy_pressed():
	pass # Replace with function body.
