extends TileMap

@export var path: String

func _ready():
	DataManager.reload.connect(_on_reload)
	
func _on_reload():
	var texture = DataManager.load_texture(path)
	tile_set.get_source(tile_set.get_source_id(0)).texture = texture
