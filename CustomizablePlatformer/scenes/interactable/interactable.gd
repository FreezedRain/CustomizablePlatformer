class_name Interactable extends Area2D

@onready var blip = $Blip

func _ready():
	blip.hide()

func enter(interactor):
	blip.show()
	
func leave(interactor):
	blip.hide()
	
func interact(interactor):
	pass
