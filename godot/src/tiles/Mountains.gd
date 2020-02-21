extends Spatial

const terrain_scale = 50

var noise

func _ready():
	randomize()
	noise = OpenSimplexNoise.new()
	noise.seed = randi()
	noise.octaves = 7
	noise.period = 50
	generate_mountains(12,21)

func generate_mountains(x, z):
	var parent_position = get_parent().translation
	var mountain = Mountain.new(terrain_scale, noise, 10, 10)
	mountain.translation = Vector3(parent_position.x, parent_position.y, parent_position.z -30)
	print("generated@" + str(parent_position.x))
	add_child(mountain)
