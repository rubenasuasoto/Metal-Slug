extends Marker2D

const Bullet = preload("res://src/scenes/objects/Bullet2.tscn")

@onready var sound_shoot = $Shoot
@onready var timer: Timer = $Cooldown

func shoot(player_is_owner:bool):
	if not timer.is_stopped():
		return false
	
	var bullet: Bullet = Bullet.instantiate() as Bullet
	bullet.player_is_owner = player_is_owner
	bullet.transform = global_transform
	bullet.offset_y = -0.75
	bullet.speed -= 300

	Utils.main_node.add_child(bullet)
	
	var bullet2: Bullet = Bullet.instantiate() as Bullet
	bullet2.player_is_owner = player_is_owner
	bullet2.transform = global_transform

	Utils.main_node.add_child(bullet2)
	
	var bullet3: Bullet = Bullet.instantiate() as Bullet
	bullet3.player_is_owner = player_is_owner
	bullet3.transform = global_transform
	bullet3.offset_y = 0.75
	bullet3.speed += 300

	Utils.main_node.add_child(bullet3)
	
	sound_shoot.play()
	timer.start()
	return true
