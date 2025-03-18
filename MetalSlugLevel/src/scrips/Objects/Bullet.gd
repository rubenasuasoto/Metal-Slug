class_name Bullet
extends Area2D

@export var speed: int = 500  # Velocidad de la bala
@export var damage: int = 25  # Daño que causa la bala

@onready var animation_player: AnimationPlayer = $AnimationPlayer


var player_is_owner: bool = true
var offset_y: float = 0
var disable: bool = false

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _physics_process(delta):
	if disable:
		return

	# Movimiento de la bala
	position.x += transform.x.x * speed * delta
	position.y += offset_y + transform.x.y * speed * delta

func _on_body_entered(body):
	if disable:
		return

	# Comprobar si la bala impacta a un enemigo o al jugador
	if player_is_owner and body.is_in_group("enemies"):
		body.take_damage(damage)
	elif not player_is_owner and body.is_in_group("player"):
		body.take_damage(damage)

	# Destruir la bala tras impactar
	destroy()

func destroy():
	disable = true
	animation_player.play("destroy")
	await animation_player.animation_finished  # Espera la animación antes de eliminar
	queue_free()
