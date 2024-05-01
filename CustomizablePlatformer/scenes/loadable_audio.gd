class_name LoadableAudio extends AudioStreamPlayer

@export var path: String

func _init():
	call_deferred("ready")

func ready():
	DataManager.reload.connect(_on_reload)
	
	connect("finished", Callable(self,"_on_loop_sound").bind(self))
	
func _on_reload():
	stream = DataManager.load_audio(path)
	stream.set
	play(0.0)

func _on_loop_sound(player):
	play(0.0)
