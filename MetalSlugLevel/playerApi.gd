extends Node2D

var score: int = 0  # 🔥 Puntuación del jugador
var max_score: int = 0  # 🔹 Guardará la puntuación máxima

var request_get
var request_post


func _ready():

	request_get = get_node("HTTPRequestGet")
	request_post = get_node("HTTPRequestPost")
	request_post.request_completed.connect(_on_post_completed)
	request_get.request_completed.connect(_on_request_completed)

func add_score(points: int) -> void:
	score += points
	print("Puntuación actual: ", score)

# 🚀 Función para enviar la puntuación máxima al servidor
func send_score():
	
	
		max_score = score  # 🔹 Actualiza el puntaje máximo
		var data_to_send = {"name": "Jugador", "maxScore": max_score}
		var json = JSON.stringify(data_to_send)
		var headers = ["Content-Type: application/json"]
		request_post.request("https://nthapi.onrender.com/api/Players", headers, HTTPClient.METHOD_POST, json)
		print("Enviando puntaje:", max_score)
		

func _on_post_completed(result, response_code, headers, body):
	if response_code == 200 or response_code == 201:
		print("Puntuación enviada correctamente")
		request_get.request("https://nthapi.onrender.com/api/players")  # 🔹 Obtiene el ranking de jugadores

func _on_request_completed(result, response_code, headers, body):
	if response_code == 200:
		var json = JSON.parse_string(body.get_string_from_utf8())
		print("Ranking de jugadores:")
		for player in json:
			print(player["name"], "-", player["maxScore"])

# 🚀 Función para llamar cuando el jugador llegue al final del nivel
func on_level_complete():
	print("¡Nivel completado! Enviando puntuación...")
	send_score()


func _on_http_request_get_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if response_code == 200:
		var json = JSON.parse_string(body.get_string_from_utf8())
		print("Ranking de jugadores:")
		for player in json:
			print(player["name"], "-", player["maxScore"])


func _on_http_request_post_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	print("operacion completada")
