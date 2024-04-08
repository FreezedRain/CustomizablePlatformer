class_name Collectable extends Interactable

func _ready():
	$Treasure.play("idle")

func enter(interactor):
	queue_free()

func leave(interactor):
	pass
