extends CanvasLayer

func _ready() -> void:
	update_ui()  # Llama a la función al inicio

func _process(delta: float) -> void:
	update_ui()  # Mantiene la UI actualizada en tiempo real

func update_ui() -> void:
	var player = get_parent().get_node("Player")  # Obtiene al jugador

	# Actualiza la barra de salud
	$health_progressBar.value = player.health

	# Actualiza la munición según el arma equipada
	if player.gun_type == 1:  # Pistola
		$Label.text = str(player.municion_pistola)
	elif player.gun_type == 2:  # Escopeta
		$Label.text = str(player.municion_escopeta)

	# Siempre muestra la cantidad de granadas
	$Label2.text = str(player.municion_granadas)
