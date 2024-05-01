class_name Interactor extends Area2D

var current: Interactable = null

func try_interact():
	if current != null:
		current.interact(self)

func _on_area_entered(area):
	if area is Interactable:
		if current != null:
			current.leave(self)
		current = area as Interactable
		current.enter(self)

func _on_area_exited(area):
	if area is Interactable:
		if area == current:
			current.leave(self)
			current = null
