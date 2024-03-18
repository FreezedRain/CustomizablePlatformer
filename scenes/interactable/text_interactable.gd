class_name TextInteractable extends Interactable

var text_box: TextBox

func _ready():
	super._ready()

func enter(interactor):
	super.enter(interactor)
	print("text entered")
	
func leave(interactor):
	super.leave(interactor)
	if text_box != null:
		text_box.queue_free()
		text_box = null
	print("text left")
	
func interact(interactor):
	super.interact(interactor)
	text_box = Global.world_ui.create_textbox(global_position)
	#text_box.hide_text()
	text_box.show_text("Test")
	print("text interacted")
