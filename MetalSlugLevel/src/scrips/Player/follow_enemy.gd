extends CharacterBody2D

@export var speed: float = 100.0  # Velocidad de movimiento
@export var local_gravity: float = 900.0
@export var detection_range: float = 800.0  # Distancia máxima para seguir al jugador
@export var shooting_range: float = 600.0  # Distancia máxima para disparar

@onready var animation_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var pistola: Node2D = animation_sprite.get_node("pistola") as Node2D

var health: int = 20 
var target: Node2D = null
var shooting: bool = false

func _ready() -> void:
	add_to_group("enemies")

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	detect_and_follow_player(delta)
	check_for_player()
	update_animation()
	move_and_slide()

func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += local_gravity * delta

func detect_and_follow_player(delta: float) -> void:
	var player = get_parent().get_node("Player")
	if player:
		var distance_to_player = global_position.distance_to(player.global_position)
		
		if distance_to_player <= detection_range and distance_to_player > shooting_range:
			# 🔹 Si está en rango de detección pero fuera del de disparo, se mueve
			var direction = (player.global_position - global_position).normalized()
			velocity.x = direction.x * speed  
			animation_sprite.scale.x = 1 if direction.x > 0 else -1
		else:
			velocity.x = 0  # Si está en el rango de disparo o demasiado lejos, se detiene.

func check_for_player() -> void:
	var player = get_parent().get_node("Player")
	if not player:
		return

	var distance_to_player = global_position.distance_to(player.global_position)

	if distance_to_player <= shooting_range:
		target = player
		velocity.x = 0  # 🔹 El enemigo se detiene para disparar
		shoot()

		var direction = (player.global_position - global_position).normalized()
		animation_sprite.scale.x = 1 if direction.x > 0 else -1

func shoot() -> void:
	if shooting:
		return  # Evita disparos repetidos sin control

	shooting = true
	animation_sprite.play("shooting")

	if pistola.has_method("shoot"):
		var bullet = pistola.call("shoot", false)  # Instancia la bala
		
		if bullet is Node2D:
			# 🔹 Mover la bala un poco hacia adelante (según la dirección del enemigo)
			bullet.global_position += Vector2(30 * animation_sprite.scale.x, 0) 
			
			# 🔹 Evitar que colisione en el primer frame
			bullet.set_deferred("collision_layer", 0)

	await get_tree().create_timer(0.5).timeout  # 🔹 Simula tiempo de disparo
	shooting = false

func update_animation() -> void:
	if shooting:
		animation_sprite.play("shooting")
	elif abs(velocity.x) > 0:
		animation_sprite.play("run")
	else:
		animation_sprite.play("idle")

func take_damage(damage: int) -> void:
	health -= damage
	print("Enemigo vida restante:", health)

	if health <= 0:
		died()

func died() -> void:
	print("Enemigo eliminado")
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"): 
		body.take_damage(100)
		print("Jugador eliminado por colisión con el enemigo")
