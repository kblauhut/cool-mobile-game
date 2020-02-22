extends Spatial

const TERRAIN_SCALE = 20
const DISTANCE = 20

var noise
var x

func _ready():
	noise = get_parent().noise
	x = get_parent().x
	generate_mountains()

func generate_mountains():
	var parent_position = get_parent().translation
	var mountain = Mountain.new(TERRAIN_SCALE, noise, x * TERRAIN_SCALE, 5)
	mountain.translation = Vector3(parent_position.x, parent_position.y, parent_position.z -30)
	print("generated@" + str(parent_position.x))
	self.get_parent().call_deferred("add_child", mountain)
