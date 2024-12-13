extends Area2D

# Llamado cuando el nodo entra en el árbol de la escena.
func _ready():
	pass

# Llamado cuando un cuerpo entra en el área de colisión.
func _on_body_entered(body: Node) -> void:
	# Asegurarse de que el nodo es un `Player`.
	if body is Player:
		# Incrementar el tipo de arma si es válido.
		body.gun_type += 1
		if body.gun_type > 2:  # Asegurar que no exceda los tipos disponibles.
			body.gun_type = 1
		print("Nuevo tipo de arma:", body.gun_type)

		# Eliminar el coleccionable de la escena.
		queue_free()
	else:
		print("El nodo que interactuó no es un jugador.")
