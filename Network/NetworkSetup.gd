extends Control

onready var configuration = $configuration
onready var server_ip_adress = $configuration/server_ip_adress
onready var device_ip_adress = $CanvasLayer/device_ip_adress

func _ready():
	get_tree().connect("network_peer_connected", self, "_connected_player")
	get_tree().connect("network_peer_disconnected", self, "_disconnected_player")
	get_tree().connect("connected_to_server", self, "_server_connected")
	
	device_ip_adress.text = Network.ip_adress

func _connected_player(id):
	print("Player " + str(id) + " has been connected" )

func _disconnected_player(id):
	print("Player " + str(id) + " has been disconnected" )
func _on_create_server_pressed():
	configuration.hide()
	Network.create_server()


func _on_join_server_pressed():
	if server_ip_adress.text != "":
		configuration.hide()
		Network.ip_adress = server_ip_adress.text
		Network.join_server()
