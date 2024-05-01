extends Control

func _ready():
	close()

func open():
	# Tweeens
	show()
	
func close():
	hide()

func _on_reload_button_pressed():
	DataManager.reload_all()
