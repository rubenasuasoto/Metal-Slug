class_name Player
extends CharacterBody2D

@export var speed: Vector2 = Vector2(350.0, 750.0) # Velocidad de movimiento y salto
@export var local_gravity: float = 900.0
@export var jump_velocity: float = -500.0

const FLOOR_NORMAL: Vector2 = Vector2.UP
const FLOOR_DETECT_DISTANCE: float = 20.0

var _velocity: Vector2 = Vector2.ZERO
var pushed: bool = false  

@onready var platform_detector: RayCast2D = $PlatformDetector
@onready var animation_player_legs: AnimationPlayer = $AnimationPlayerlegs
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var shoot_timer: Timer = $ShootTimer
@onready var shoot_bomb_timer: Timer = $ShootBombTimer
@onready var sprite: Sprite2D = $Sprite2D
@onready var granada: Node2D = sprite.get_node("granada") as Node2D
@onready var pistola: Node2D = sprite.get_node("pistola") as Node2D
@onready var escopeta: Node2D = sprite.get_node("escopeta") as Node2D

var gun_type: int = 1

func start(pos: Vector2) -> void:
	position = pos
	show()

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	# Aplicar gravedad si no está en el suelo
	velocity.y += local_gravity * delta if not is_on_floor() else 0

	# Calcular dirección de movimiento
	var direction = Input.get_axis("move_left", "move_right")

	if not pushed:
		if direction != 0:
			velocity.x = direction * speed.x
		else:
			velocity.x = move_toward(velocity.x, 0.0, speed.x * delta)  
	
	if Input.is_action_just_pressed("ESC"):
		get_tree().change_scene_to_file("res://src/scenes/UI/menu.tscn")
	
	# Control de salto
	if Input.is_action_just_pressed("jump") and is_on_floor():
		jump()

	# Cambiar dirección del sprite
	if velocity.x != 0:
		sprite.scale.x = -1 if velocity.x < 0 else 1

	# Mover al jugador
	move_and_slide()

	# Control de disparos
	handle_shooting()

	# Actualizar animaciones
	update_animations(direction)

func jump() -> void:
	velocity.y = jump_velocity
	animation_player_legs.play("jump_up")
	await get_tree().create_timer(0.6).timeout
	if is_on_floor():
		animation_player_legs.play("idle")

func handle_shooting() -> void:
	# Disparo de bombas
	var is_shooting_bomb: bool = false
	if Input.is_action_just_pressed("shoot_bomb") and shoot_bomb_timer.time_left <= 0.0:
		is_shooting_bomb = granada.call("shoot", true)

	# Disparo normal
	var is_shooting: bool = false
	if gun_type == 1:  # Pistola
		if Input.is_action_just_pressed("shoot") and shoot_timer.time_left <= 0.0:
			is_shooting = pistola.call("shoot", true)
	elif gun_type == 2:  # Escopeta
		if Input.is_action_pressed("shoot") and shoot_timer.time_left <= 0.0:
			is_shooting = true
			escopeta.call("shoot", true)

	# Manejo de temporizadores
	if is_shooting:
		shoot_timer.start()
	if is_shooting_bomb:
		shoot_bomb_timer.start()

func update_animations(direction: float) -> void:
	# Animaciones de movimiento horizontal
	if is_on_floor():
		if abs(velocity.x) > 0:
			animation_player_legs.play("run")
		else:
			animation_player_legs.play("idle")
	else:
		if velocity.y > 0:
			animation_player_legs.play("jump_down")
		else:
			animation_player_legs.play("jump_up")

	# Animaciones de disparo o estado general

	if shoot_bomb_timer.time_left > 0.0:
		animation_player.play("shoot_bomb_weapon_" + str(gun_type))
	elif shoot_timer.time_left > 0.0:
		animation_player.play("shoot_weapon_" + str(gun_type))
	else:
		animation_player.play("idle_weapon_" + str(gun_type))


func take_damage(damage: int) -> void:
	print("Player damage:", damage)
