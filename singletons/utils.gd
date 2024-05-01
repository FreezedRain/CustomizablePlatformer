class_name Utils

static func list_files_in_directory(path):
	var files = []
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		while true:
			var file = dir.get_next()
			if file == "":
				break
			elif not file.begins_with("."):
				files.append(file)
		dir.list_dir_end()
	else:
		print("Failed to load file, incorrect path! " + path)
	return files
	
static func get_random_v(from: float, to: float) -> Vector3:
	return Vector3(randf_range(from, to), randf_range(from, to), randf_range(from, to))
	
static func get_random_d() -> Vector3:
	var theta = 2 * PI * randf()
	var phi = PI * randf()
	
	return Vector3(sin(phi) * cos(theta), sin(phi) * sin(theta), cos(phi))
