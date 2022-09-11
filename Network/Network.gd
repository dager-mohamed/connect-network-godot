extends Node

const PORT = 5000
const MAX_CLIENT = 10

var server = null
var client = null

var ip_adress = ""

func _ready():
	if OS.get_name() == "Windows":
		ip_adress = IP.get_local_addresses()[3]
	elif OS.get_name() == "Android":
		ip_adress = IP.get_local_addresses()[0]
	else:
		ip_adress = IP.get_local_addresses()[3]
	for ip in IP.get_local_addresses():
		if ip.begins_with("192.168."):
			ip_adress = ip
	get_tree().connect("connected_to_server", self, "_connected_server")
	get_tree().connect("server_disconnected", self, "_disconnect_server")
	join_server()

func create_server():
	server = NetworkedMultiplayerENet.new()
	server.create_server(PORT, MAX_CLIENT)
	get_tree().set_network_peer(server)

func join_server():
	client = NetworkedMultiplayerENet.new()
	client.create_client(ip_adress, PORT)
	get_tree().set_network_peer(client)

func _connected_server():
	print("successfully connected to server")
func _disconnect_server():
	print("disconnected from server")
