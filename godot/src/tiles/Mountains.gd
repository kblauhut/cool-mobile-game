extends Spatial

const TERRAIN_SCALE = 20
const DISTANCE = 40

var noise
var x

func _ready():
	noise = get_parent().noise
	x = get_parent().x
	generate_mountains()

func generate_mountains():
	var parent_position = get_parent().translation
	var mountain = Mountain.new(TERRAIN_SCALE, noise, x, 0, false)
	mountain.translation = Vector3(0, 0, -DISTANCE)
	self.get_parent().call_deferred("add_child", mountain)
	
	var mountain2 = Mountain.new(TERRAIN_SCALE, noise, x, 0, true)
	mountain2.translation = Vector3(0, 0, DISTANCE)
	self.get_parent().call_deferred("add_child", mountain2)
