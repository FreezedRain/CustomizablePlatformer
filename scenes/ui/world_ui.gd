extends Control

@export var text_box_scene: PackedScene

func _ready():
	Global.world_ui = self

func create_textbox(pos):
	var box = text_box_scene.instantiate()
	box.position = pos + Vector2(400, 300)
	add_child(box)
	return box 
