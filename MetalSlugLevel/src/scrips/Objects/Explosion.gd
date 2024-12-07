class_name Explosion
extends Area2D

@onready var sound_explosion_0: AudioStreamPlayer2D = $SoundExplosion0
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var player_is_owner: bool = true
@export var explosion: int = 0
@export var damage: int = 0

func _ready() -> void:
	# Reproducir la animación de explosión
	animation_player.play("explosion_0".format(explosion))
	
	# Reproducir el sonido asociado a la explosión
	if explosion == 0:
		sound_explosion_0.play()

# Método que se activa cuando un cuerpo entra en el área
func body_entered(body: Node) -> void:
	if player_is_owner:
		if body.is_in_group("enemies"):
			body.call("take_damage", damage)
	else:
		if body.is_in_group("player"):
			body.call("take_damage", damage)

# Método conectado a la señal `finished` del reproductor de sonido
func _on_SoundExplosion0_finished() -> void:
	queue_free()

# Método conectado a la señal `body_entered` del área
func _on_Explosion_body_entered(body: Node) -> void:
	body_entered(body)
