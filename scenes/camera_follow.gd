extends Camera2D

@export var player:Node2D

var startpos
var tpos


# Called when the node enters the scene tree for the first time.
func _ready():
	startpos = position
	tpos = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = lerp(position, tpos, 0.2)
	
	if player.position.x > 220:
		tpos = startpos + Vector2(450, 0)
	else:
		tpos = startpos
	
	
