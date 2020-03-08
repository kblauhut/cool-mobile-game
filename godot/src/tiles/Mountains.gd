extends Spatial

const TERRAIN_SCALE = 20
const DISTANCE = 10

var noise
var x

func _ready():
	noise = get_parent().noise
	x = get_parent().x
	generate_mountains()

func generate_mountains():
	var parent_position = get_parent().translation
	var mountain = Mountain.new(TERRAIN_SCALE, noise, x, 0)
	mountain.translation = Vector3(0, 0, -40)
	self.get_parent().call_deferred("add_child", mountain)
