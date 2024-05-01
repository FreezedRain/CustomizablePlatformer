class_name Interactable extends Area2D

@onready var blip

func _ready():
	blip = $Blip
	blip.hide()

func enter(interactor):
	blip.show()
	
func leave(interactor):
	blip.hide()
	
func interact(interactor):
	pass
