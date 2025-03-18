extends CanvasLayer



func _ready():
	pass


func game_over():
	# Mostrar mensaje de Game Over (si tienes un label o algo similar)
	print("Game Over")


func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://src/scenes/UI/menu.tscn") 
