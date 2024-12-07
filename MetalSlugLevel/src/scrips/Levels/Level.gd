extends Node2D

@onready var player: Player = $Player 
@onready var camera: Camera2D = $Player/Camera2D
@onready var player_start_position: Marker2D = $PlayerStartPosition
@onready var world_rect: ReferenceRect = $World/Rect

func _ready():
	player.start(player_start_position.position)
	set_camera_limits()


func set_camera_limits():
	var map_size: Rect2 = world_rect.get_rect() as Rect2
	
	var top_limit: int = map_size.position.y as int
	var bottom_limit: int = map_size.end.y as int
	var left_limit: int = map_size.position.x as int
	var right_limit: int = map_size.end.x as int
	
	camera.limit_left = left_limit
	camera.limit_right = right_limit
	camera.limit_top = top_limit
	camera.limit_bottom = bottom_limit
