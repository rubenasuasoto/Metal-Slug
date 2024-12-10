extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		print("pase")
		body.gun_type = 2  # Cambia a la escopeta, 
		queue_free()  # Elimina el `Collectible` de la escena
