extends Node2D

@onready var player: Player = $Player 
@onready var camera: Camera2D = $Player/Camera2D
@onready var player_start_position: Marker2D = $PlayerStartPosition
@onready var world_rect: ReferenceRect = $World/Rect
@onready var final: Area2D = $Final2


func _ready():
	player.start(player_start_position.position)
	set_camera_limits()
	




func set_camera_limits():
	var map_size: Rect2 = world_rect.get_rect()
	camera.limit_left = map_size.position.x as int
	camera.limit_right = map_size.end.x as int
	camera.limit_top = map_size.position.y as int
	camera.limit_bottom = map_size.end.y as int





func _on_final_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().change_scene_to_file("res://src/scenes/UI/final.tscn")
		
