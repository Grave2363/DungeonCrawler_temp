extends Node

class_name equips

var WepName : String = "Stick"
var WepDis : String = "What is this?"
var atk : int
var mAtk : int

func initialize (wep :WepBase):
	WepName = wep.WepName
	WepDis = wep.WepDis
	atk = wep.atk
	mAtk = wep.mAtk

func new_equip (wep :WepBase):
	WepName = wep.WepName
	WepDis = wep.WepDis
	atk = wep.atk
	mAtk = wep.mAtk
