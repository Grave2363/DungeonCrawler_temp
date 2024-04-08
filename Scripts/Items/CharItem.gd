extends Node

class_name CharItem

var itemDis : String
var healing : int
var uses : int


func initialize (item :ItemBase):
	name = item.item_Name
	itemDis = item.ItemDis
	healing = item.healing
	uses = item.uses
