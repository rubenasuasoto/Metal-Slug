extends Node2D

var score_manager: Node  # Declaramos la variable para el score_manager
var max_score: int = 0  # Guardará la puntuación máxima

func _ready():
	$HTTPRequestPost.request_completed.connect(_on_post_completed)
	$HTTPRequestGet.request_completed.connect(_on_request_completed)

	# Acceder a la escena que contiene el score_manager
	# Cambia "Game" por el nombre real de tu escena que contiene el score_manager.
	# Esto supone que la escena que tiene el score_manager ya está cargada.
	score_manager = get_tree().get_node("Nivel01/Node")  # Cambia la ruta según sea necesario

func add_score(points: int) -> void:
	# Cambia la puntuación a la que se obtiene del score_manager
	score_manager.add_score(points)  # Llamamos a add_score de score_manager
	print("Puntuación actual: ", score_manager.score)

func send_score():
	max_score = score_manager.score  # Ahora tomamos el puntaje desde el score_manager
	var data_to_send = {"name": "Jugador", "maxScore": max_score}
	var json = JSON.stringify(data_to_send)
	var headers = ["Content-Type: application/json"]
	$HTTPRequestPost.request("https://nthapi.onrender.com/api/Players", headers, HTTPClient.METHOD_POST, json)
	print("Enviando puntaje:", max_score)

func _on_post_completed(result, response_code, headers, body):
	if response_code == 200 or response_code == 201:
		print("Puntuación enviada correctamente")
		$HTTPRequestGet.request("https://nthapi.onrender.com/api/players")  # 🔹 Obtiene el ranking de jugadores

func _on_request_completed(result, response_code, headers, body):
	if response_code == 200:
		var json = JSON.parse_string(body.get_string_from_utf8())
		print("Ranking de jugadores:")
		for player in json:
			print(player["name"], "-", player["maxScore"])

func on_level_complete():
	print("¡Nivel completado! Enviando puntuación...")
	send_score()
