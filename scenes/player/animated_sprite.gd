extends Sprite2D

@export var animations: Array[SpriteAnimation]

var current: SpriteAnimation = null
var t: float = 0.0
var frame_idx: int = 0

func _process(delta):
	if current == null:
		return
	t += delta
	if t >= (1.0 / current.fps):
		t -= 1.0 / current.fps
		var frames = max(1, current.sprite.get_width() / 32)
		# Go next frame
		frame_idx = (frame_idx + 1) % frames
		region_rect.position.x = 32 * frame_idx

func play(anim_name):
	if current and current.name == anim_name:
		return
	for anim in animations:
		if anim.name == anim_name:
			current = anim
			texture = current.sprite
			t = 0
			frame_idx = 0
			region_rect.position.x = 32 * frame_idx
			return
			
func stop():
	pass

