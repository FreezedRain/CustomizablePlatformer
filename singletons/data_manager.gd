extends Node

signal reload

var executable_path: String
var ERROR_IMAGE: Image

func _ready():
	ERROR_IMAGE = Image.load_from_file("res://sprites/error.png")
	call_deferred("reload_all")
	if OS.has_feature("standalone"):
		executable_path = OS.get_executable_path() + '/'
	else:
		executable_path = 'res://'
	print("Executable path %s" % executable_path)
	
func reload_all():
	reload.emit()
	
func load_text(rel_path) -> String:
	var abs_path = executable_path + 'text/' + rel_path
	if FileAccess.file_exists(abs_path):
		var file = FileAccess.open(abs_path, FileAccess.READ)
		var text = file.get_as_text()
		file.close()
		return text
	return "missing text"
	
func load_image(rel_path) -> Image:
	var abs_path = executable_path + 'sprites/' + rel_path
	if FileAccess.file_exists(abs_path):
		return Image.load_from_file(abs_path)
	return ERROR_IMAGE

func load_audio(rel_path) -> AudioStream:
	var abs_path = executable_path + 'audio/' + rel_path
	print(abs_path)
	if FileAccess.file_exists(abs_path):
		print("exists")
		return load(abs_path)
	return null

func load_texture(rel_path) -> ImageTexture:
	return ImageTexture.create_from_image(load_image(rel_path))
