extends Node3D


func BOX():
	pass

func _ready() -> void:
	DirAccess.remove_absolute(ProjectSettings.globalize_path("res://character/materials/check.png"))
	DirAccess.remove_absolute(ProjectSettings.globalize_path("res://character/materials/check_hands.png"))
	#check_for_empty_array_meshes(self)
#
#func check_for_empty_array_meshes(node: Node) -> void:
	## Recursively check all nodes in the scene tree
	#for child in node.get_children():
		## If the child is a MeshInstance3D (or any class with a .mesh)
		#if child is MeshInstance3D:
			#var mesh = child.mesh
			#if mesh is ArrayMesh:
				#if is_array_mesh_empty(mesh):
					#print("Empty ArrayMesh found on node: ", child.name)
		## Recurse deeper
		#check_for_empty_array_meshes(child)
#
#func is_array_mesh_empty(mesh: ArrayMesh) -> bool:
	## No surfaces at all:
	#if mesh.get_surface_count() == 0:
		#return true
#
	## Surfaces exist; check if vertex arrays are empty:
	#for i in range(mesh.get_surface_count()):
		#var arr = mesh.surface_get_arrays(i)
		#if arr.size() > Mesh.ARRAY_VERTEX:
			#var verts: PackedVector3Array = arr[Mesh.ARRAY_VERTEX]
			#if verts.size() > 0:
				## Found vertices, not empty
				#return false
	## All surfaces had 0 vertices
	#return true
