class_name LoadableTextAsset extends Resource

@export var path: String
var strings: PackedStringArray

func _init():
	call_deferred("ready")

func ready():
	DataManager.reload.connect(_on_reload)
	
func _on_reload():
	strings = DataManager.load_text(path).split("\n")
	strings.remove_at(len(strings) - 1)
