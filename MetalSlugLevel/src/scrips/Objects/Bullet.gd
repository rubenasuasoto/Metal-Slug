class_name Bullet
extends Area2D

@export var speed: int
@export var damage: int

@onready var animation_player = $AnimationPlayer
var player_is_owner: bool = true
var offset_y: float = 0
var disable: bool = false

func _physics_process(delta):
	if disable: return
	position.x += transform.x.x * speed * delta
	position.y += offset_y + transform.x.y * speed * delta

func body_entered(body):
	if disable: return
	if player_is_owner:
		if body.is_in_group('enemies'):
			body.take_damage(damage)
	else:
		if body.is_in_group('player'):
			body.take_damage(damage)
	
	destroy()


func destroy():
	disable = true
	animation_player.play("destroy")


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Bullet_body_entered(body):
	body_entered(body)
