extends CanvasLayer


func _process(delta):
	if Input.is_action_just_pressed("Pausa"):
		get_tree().paused =  not get_tree().paused
		$ColorRect.visible = not $ColorRect.visible
		$Label.visible = not $Label.visible
		$VBoxContainer2/play.visible = not $VBoxContainer2/play.visible
		$VBoxContainer2/quit.visible = not $VBoxContainer2/quit.visible
		$VBoxContainer2.visible = not $VBoxContainer2.visible
func _on_play_pressed() -> void:
		get_tree().paused =  not get_tree().paused
	
		$ColorRect.visible = not $ColorRect.visible
		$Label.visible = not $Label.visible
		$VBoxContainer2/play.visible = not $VBoxContainer2/play.visible
		$VBoxContainer2/quit.visible = not $VBoxContainer2/quit.visible
		$VBoxContainer2.visible = not $VBoxContainer2.visible
	
func _on_quit_pressed() -> void:
	get_tree().paused =  not get_tree().paused
	get_tree().change_scene_to_file("res://src/scenes/UI/menu.tscn")
