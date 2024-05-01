## Loads and spawns particles from the specified folder
extends Node

const PATH := 'res://scenes/particles/'

var parent_scene: Node
var particles := {}

func _ready():
	load_particles()
	print('%d particles loaded.' % len(particles))
	pre_spawn_particles()
	#parent_scene = get_parent()

func spawn(id, position, rotation=Vector3.ZERO, parent=parent_scene):
	var particle = particles[id].instantiate()
	parent.add_child(particle)
	particle.rotation = rotation
	particle.global_position = position
	return particle
	
func spawn_normal(id, position, normal, parent=parent_scene):
	var particle = particles[id].instantiate()
	parent.add_child(particle)
	particle.global_position = position
	#await get_tree().create_timer(0.5).timeout
	if abs(normal.dot(Vector3.UP)) > 0.99:
		particle.look_at(particle.global_position + Vector3.UP, Vector3.RIGHT)
	else:
		particle.look_at(particle.global_position + normal, Vector3.UP)
	#print("hello")
	#print(particle.rotation)
#	var xform = particle.global_transform
#	xform.basis.y = normal
#	xform.basis.x = -xform.basis.z.cross(normal)
#	xform.basis = xform.basis.orthonormalized()
#	particle.global_transform = xform
	return particle
	
func pre_spawn_particles():
	for particle in particles:
		spawn(particle, Vector3.ONE * -10000, Vector3.ZERO, self)

func load_particles():
	for file_name in Utils.list_files_in_directory(PATH):
		file_name = file_name.trim_suffix('.remap')
		var particle_name = file_name.split('.')[0]
		var particle_ext = file_name.split('.')[1]
		if particle_ext == "tscn":
			particles[particle_name] = load(PATH + file_name)
		
