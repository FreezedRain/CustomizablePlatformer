class_name Collectable extends Interactable

var collected = false

func _ready():
	$Treasure.play("idle")

func enter(interactor):
	if !collected:
		$collect.play()
		collected = true
		$Treasure.hide()

func leave(interactor):
	pass
