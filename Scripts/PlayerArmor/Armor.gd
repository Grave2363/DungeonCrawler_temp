extends Node

class_name armor

var WepName : String = "Stick"
var WepDis : String = "What is this?"
var atk : int
var mAtk : int

func initialize (arm :ArmorBase):
	WepName = arm.WepName
	WepDis = arm.WepDis
	atk = arm.atk
	mAtk = arm.mAtk
