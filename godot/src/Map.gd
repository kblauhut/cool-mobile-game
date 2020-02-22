extends Node

var tile_scene = load("res://src/tiles/NeonLevel_1.tscn")

const TILE_SIZE = 20
const LEVEL_LENGHT = 4

var tileX = -1
var tileZ = -1

var noise

func _ready():
	randomize()
	noise = OpenSimplexNoise.new()
	noise.seed = randi()
	noise.octaves = 7
	noise.period = 50
	spawn_tiles()
	
func _physics_process(delta):
	if tileX < get_x():
		for tile in get_parent().get_children():
			if "tile" in tile.name and tile.translation.x < tileX * TILE_SIZE:
				print(tile.translation)
				tile.queue_free()
		spawn_tiles()
	
func get_x():
	var x = floor(get_parent().get_node("Player").get_translation().x)
	x = int(x / TILE_SIZE)
	return x
	
func spawn_tiles():
	var x = int(floor(get_parent().get_node("Player").get_translation().x))
	var new_x = get_x()
	
	if new_x > tileX:
		tileX = new_x
		
		for i in LEVEL_LENGHT:
			var new_tile = tile_scene.instance()
			var offsetX = x + TILE_SIZE/2 + i * TILE_SIZE
			new_tile.set_translation(Vector3(offsetX, 0, 0))
			new_tile.set_name("tile")
			new_tile.init(noise, x)
			self.get_parent().call_deferred("add_child", new_tile)
