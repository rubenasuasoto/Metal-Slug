extends Marker2D

const BOMB_VELOCITY = 500
const Bomb = preload("res://src/scenes/objects/Bomb1.tscn")

@onready var timer: Timer = $Cooldown

func launch(player_is_owner:bool):
	await get_tree().create_timer(0.2).timeout
	
	var bomb: Bomb = Bomb.instantiate() as Bomb
	var sprite: Sprite2D = get_parent() as Sprite2D
	bomb.player_is_owner = player_is_owner
	bomb.global_position = global_position
	bomb.linear_velocity = Vector2(sprite.scale.x * BOMB_VELOCITY, -BOMB_VELOCITY)
	bomb.angular_velocity = sprite.scale.x * 3
	
	Utils.main_node.add_child(bomb)

func shoot(player_is_owner:bool):
	if not timer.is_stopped():
		return false
	
	launch(player_is_owner)
	
	timer.start()
	return true
