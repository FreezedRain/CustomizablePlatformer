extends Node

@onready var data_menu = $CanvasLayer/DataMenu

func _process(delta):
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused:
			get_tree().paused = false
			data_menu.close()
		else:
			get_tree().paused = true
			data_menu.open()
