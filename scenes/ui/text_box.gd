class_name TextBox extends Control

@onready var label = $Label

func show_text(text: String):
	show()
	label.text = text
	
func hide_text():
	hide()
