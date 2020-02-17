extends Node

const TILE_SIZE = 20
const LEVEL_LENGHT = 7
const LEVEL_WIDTH = 1

var tileX = -1
var tileZ = -1

var current_map = []

func _ready():
	spawn_tiles()
	
func _physics_process(delta):
	if tileX < coordinates()[0]:
		for tile in get_parent().get_children():
			if "tile" in tile.name:
				tile.queue_free()
		spawn_tiles()
	
func coordinates():
	var x = floor(get_parent().get_node("Player").get_translation().x)
	var z = floor(get_parent().get_node("Player").get_translation().z)
	x = int(x / TILE_SIZE)
	z = int(z / TILE_SIZE)
	return [x, z]
	
func spawn_tiles():
	var x = int(floor(get_parent().get_node("Player").get_translation().x))
	var z = int(floor(get_parent().get_node("Player").get_translation().z))
	var y = int(floor(get_parent().get_node("Player").get_translation().y))
	var tile_scene = load("res://src/tiles/NeonLevel_1.tscn")
	var new_coordinates = coordinates()
	print(new_coordinates)
	
	if new_coordinates[0] > tileX:
		tileX = new_coordinates[0]
		for i in LEVEL_LENGHT:
			for n in LEVEL_WIDTH:
				var new_tile = tile_scene.instance()
				var offsetX = x + TILE_SIZE/2 + i * TILE_SIZE
				var offsetZ = z + TILE_SIZE * (n - floor(LEVEL_WIDTH/2))
				
				new_tile.set_translation(Vector3(offsetX, 0, 0))
				new_tile.set_name("tile")
				self.get_parent().call_deferred("add_child", new_tile)
