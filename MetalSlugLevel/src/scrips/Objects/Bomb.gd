class_name Bomb
extends RigidBody2D

@export var damage: int

const Explosion = preload("res://src/scenes/objects/Explosion.tscn")

var player_is_owner: bool = true
var disable: bool = false

func destroy():
	if disable: return
	disable = true
	
	# Crear y posicionar la explosión
	var explosion: Explosion = Explosion.instantiate() as Explosion
	explosion.player_is_owner = player_is_owner
	explosion.explosion = 0
	explosion.damage = damage
	explosion.global_position = global_position
	explosion.position.y += 10
	
	Utils.main_node.call_deferred("add_child", explosion)
	
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Bomb_body_entered(body):
	if disable: return
	
	# Verificar si el cuerpo es un enemigo o el jugador y hacerle daño
	if player_is_owner:
		if body.is_in_group("enemies"):
			print("💣 La bomba impactó a un enemigo!")
			body.take_damage(damage)
	else:
		if body.is_in_group("player"):
			print("🔥 La bomba impactó al jugador!")
			body.take_damage(damage)

	destroy()
