class_name TextBox extends Control

@onready var label = $Label
@onready var background = $ColorRect

var tween: Tween
var is_busy: bool = false
var reveal_tween: Tween

func show_text(text: String):
	if reveal_tween:
		reveal_tween.kill()
	var new = not visible
	if new:
		# Just opened
		reveal_tween = create_tween()
		reveal_tween.tween_property(background, "scale", Vector2.ONE, 0.225).from(Vector2.ZERO).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		show()
	else:
		reveal_tween = create_tween()
		reveal_tween.tween_property(background, "scale", Vector2.ONE, 0.225).from(Vector2.ONE * 0.9).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	reset_animation()
	label.visible_ratio = 0
	label.text = text
	tween = create_tween()
	if new:
		tween.tween_property(label, "visible_ratio", 1.0, label.get_total_character_count() / 90.0).set_delay(0.15)
	else:
		tween.tween_property(label, "visible_ratio", 1.0, label.get_total_character_count() / 90.0)
	tween.finished.connect(_on_anim_finished)
	is_busy = true
	
func try_skip():
	# Skip text reveal
	reset_animation()
	label.visible_ratio = 1
	
func hide_text(instant):
	reset_animation()
	if reveal_tween:
		reveal_tween.kill()
	label.text = ""
	if instant:
		hide()
		return

	reveal_tween = create_tween()
	if reveal_tween:
		reveal_tween.tween_property(background, "scale", Vector2.ZERO, 0.15).from(Vector2.ONE).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		reveal_tween.finished.connect(hide)
	
func reset_animation():
	if tween:
		tween.kill()
	is_busy = false

func _on_anim_finished():
	is_busy = false
	label.visible_ratio = 1
