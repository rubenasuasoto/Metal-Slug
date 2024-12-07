extends Node2D

var main_node: Node2D: get = _get_main_node
var view_size: Vector2: get = _get_view_size

func _get_main_node() -> Node2D:
	var root = get_tree().get_root()
	var node = root.get_child(root.get_child_count() - 1)
	if node is Node2D:
		return node
	else:
		print("Error: The main node is not a Node2D!")
		return null

func _get_view_size() -> Vector2:
	return get_tree().get_root().get_visible_rect().size

func choice_list(list):
	randomize()
	var random_index = randi() % list.size()
	return list[random_index]
