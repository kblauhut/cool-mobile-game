extends Node

const TILE_SIZE = 20
const LEVEL_LENGHT = 2
const LEVEL_WIDTH = 3

var tileX = 0;
var tileZ = 0;

func _ready():
	spawn_tiles()
	
func _physics_process(delta):
	update()
	
func coordinates():
	var x = floor(get_parent().get_node("Player").get_translation().x)
	var z = floor(get_parent().get_node("Player").get_translation().z)
	x = int(x / TILE_SIZE)
	z = int(z / TILE_SIZE) % LEVEL_WIDTH
	return [x, z]

func update():
	var new_coordinates = coordinates()
	
	if new_coordinates[0] > tileX:
		tileX = new_coordinates[0]
		spawn_tiles()
		
	
	if new_coordinates[1] != tileZ:
		tileZ = new_coordinates[1]
		print("moved tileZ")
	
func spawn_tiles():
	var x = int(floor(get_parent().get_node("Player").get_translation().x))
	var z = int(floor(get_parent().get_node("Player").get_translation().z))
	var y = int(floor(get_parent().get_node("Player").get_translation().y))
	
	for i in LEVEL_LENGHT:
		for n in LEVEL_WIDTH:	
			var tile_scene = load("res://src/tiles/Tile.tscn")
			var new_tile = tile_scene.instance()
			var offsetX = x + TILE_SIZE / 2 + i * TILE_SIZE
			var offsetZ = z + TILE_SIZE * (n - floor(LEVEL_WIDTH/2))
		
			new_tile.set_translation(Vector3(offsetX, y, offsetZ))
			self.get_parent().call_deferred("add_child", new_tile)
