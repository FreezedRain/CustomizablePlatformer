class_name TextInteractable extends Interactable

@export var text_asset: LoadableTextAsset
@onready var text_box: TextBox = $TextBox

var message_idx: int = 0

func _ready():
	super._ready()
	text_box.hide_text(true)
	$Guy.play("idle")

func enter(interactor):
	super.enter(interactor)
	
func leave(interactor):
	super.leave(interactor)
	text_box.hide_text(false)
	message_idx = 0
	
func interact(interactor):
	super.interact(interactor)
	blip.hide()
	
	if text_box.is_busy:
		text_box.try_skip()
		return
		
	if message_idx >= len(text_asset.strings):
		text_box.hide_text(false)
		message_idx = 0
		blip.show()
		return
	
	text_box.show_text(text_asset.strings[message_idx])
	message_idx += 1
	
	$bloop.pitch_scale = randf_range(0.9, 1.1)
	$bloop.play()
