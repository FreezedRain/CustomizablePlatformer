class_name LoadableTexture extends ImageTexture

@export var path: String

func _init():
	call_deferred("ready")

func ready():
	DataManager.reload.connect(_on_reload)
	
func _on_reload():
	set_image(DataManager.load_image(path))
