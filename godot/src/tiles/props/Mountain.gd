extends Spatial
class_name Mountain

const SUBDIV_MULTIPLIER = 0.3
const HEIGHT_MULTIPLIER = 60

var mesh_instance
var terrain_scale
var noise
var x
var z
var isRotated

func _init(terrain_scale, noise, x, z, isRotated):
	self.terrain_scale = terrain_scale
	self.noise = noise
	self.x = x
	self.z = z
	self.isRotated = isRotated

func _ready():
	generate_terrain()
	
	
func generate_terrain():
	var plane_mesh = PlaneMesh.new()
	plane_mesh.size = Vector2(terrain_scale, terrain_scale*2)
	plane_mesh.subdivide_depth = terrain_scale * SUBDIV_MULTIPLIER
	plane_mesh.subdivide_width = terrain_scale * SUBDIV_MULTIPLIER
	
	var surface_tool = SurfaceTool.new()
	var mesh_data_tool = MeshDataTool.new()
	surface_tool.create_from(plane_mesh, 0)
	var plane_array = surface_tool.commit()
	mesh_data_tool.create_from_surface(plane_array, 0)
		
	for i in range(mesh_data_tool.get_vertex_count()):
		var vertex = mesh_data_tool.get_vertex(i)
		var gradient = HEIGHT_MULTIPLIER * (1 - (vertex.z / terrain_scale))
		if isRotated: gradient = HEIGHT_MULTIPLIER * (1 + (vertex.z / terrain_scale))
		vertex.y = noise.get_noise_3d(vertex.x + x, vertex.y, vertex.z + z) * gradient
		vertex.y = abs(vertex.y)
		
		mesh_data_tool.set_vertex(i, vertex)
		
	for n in range(plane_array.get_surface_count()):
		plane_array.surface_remove(n)
		
	mesh_data_tool.commit_to_surface(plane_array)
	surface_tool.begin(Mesh.PRIMITIVE_TRIANGLES)
	surface_tool.create_from(plane_array, 0)
	surface_tool.generate_normals()
	
	mesh_instance = MeshInstance.new()
	mesh_instance.mesh = surface_tool.commit()
	add_child(mesh_instance)
