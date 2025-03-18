extends Area2D

# Llamado cuando un cuerpo entra en el área de colisión.
func _on_body_entered(body: Node) -> void:
	# Asegurarse de que el nodo es un `Player`.
	if body is Player:
		# Cambiar el arma ciclando entre pistola y escopeta
		body.gun_type += 1
		if body.gun_type > 2:
			body.gun_type = 1
		print("Nuevo tipo de arma:", body.gun_type)

		# Recargar la munición del arma actual
		if body.gun_type == 1:  # Pistola
			body.municion_pistola = 10  # Máxima munición de la pistola
			print("Munición de pistola recargada!")
		elif body.gun_type == 2:  # Escopeta
			body.municion_escopeta = 5  # Máxima munición de la escopeta
			print("Munición de escopeta recargada!")

		# Recargar granadas también si quieres
		body.municion_granadas = 3
		print("Granadas recargadas!")

		# Eliminar el coleccionable de la escena.
		queue_free()
	else:
		print("El nodo que interactuó no es un jugador.")
