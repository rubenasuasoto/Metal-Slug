extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Collectible_body_entered(body):
	if body is Player:
		body.gun_type = 2
		queue_free()
