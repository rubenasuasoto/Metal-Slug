extends Marker2D

const Bullet = preload("res://src/scenes/objects/Bullet1.tscn")

@onready var sound_shoot = $Shoot
@onready var timer: Timer = $Cooldown

func shoot(player_is_owner:bool):
	if not timer.is_stopped():
		return false
	
	var bullet: Bullet = Bullet.instantiate() as Bullet
	bullet.player_is_owner = player_is_owner
	bullet.transform = global_transform
	
	Utils.main_node.add_child(bullet)
	
	sound_shoot.play()
	timer.start()
	return true
