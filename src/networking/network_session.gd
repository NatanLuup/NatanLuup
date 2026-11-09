## Hosts or joins a two-player co-op session over direct IP (ENet).
## Implements design/game-brief.md MVP feature 2 (Story 002).
class_name NetworkSession
extends Node

## Emitted on the client once the connection to the host is up.
signal joined
## Emitted on the client when the connection attempt fails.
signal join_failed
## Emitted on the client when the host closes the game or the connection drops.
signal host_lost
## Emitted on the host when the friend connects.
signal friend_joined(peer_id: int)
## Emitted on the host when the friend disconnects.
signal friend_left(peer_id: int)

## The host plus one friend: the brief's MVP is two players.
const MAX_CLIENTS: int = 1


func _ready() -> void:
	multiplayer.connected_to_server.connect(joined.emit)
	multiplayer.connection_failed.connect(_on_connection_failed)
	multiplayer.server_disconnected.connect(_on_server_disconnected)
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)


## Starts hosting on [param port]. Returns OK, or the error from ENet (for example, port in use).
func host(port: int) -> Error:
	var peer := ENetMultiplayerPeer.new()
	var error: Error = peer.create_server(port, MAX_CLIENTS)
	if error != OK:
		return error
	multiplayer.multiplayer_peer = peer
	return OK


## Starts connecting to a host. Returns OK if the attempt started; [signal joined]
## or [signal join_failed] reports how it ended.
func join(address: String, port: int) -> Error:
	var peer := ENetMultiplayerPeer.new()
	var error: Error = peer.create_client(address, port)
	if error != OK:
		return error
	multiplayer.multiplayer_peer = peer
	return OK


## Closes the connection, if any, and goes back to offline play.
func leave() -> void:
	if multiplayer.multiplayer_peer != null:
		multiplayer.multiplayer_peer.close()
	multiplayer.multiplayer_peer = OfflineMultiplayerPeer.new()


## This machine's IPv4 addresses (LAN and virtual-network adapters), for the host to share.
static func local_ipv4_addresses() -> PackedStringArray:
	var result := PackedStringArray()
	for address: String in IP.get_local_addresses():
		var is_ipv4: bool = address.is_valid_ip_address() and address.find(":") == -1
		if is_ipv4 and not address.begins_with("127."):
			result.append(address)
	return result


func _on_connection_failed() -> void:
	leave()
	join_failed.emit()


func _on_server_disconnected() -> void:
	leave()
	host_lost.emit()


func _on_peer_connected(peer_id: int) -> void:
	if multiplayer.is_server():
		friend_joined.emit(peer_id)


func _on_peer_disconnected(peer_id: int) -> void:
	if multiplayer.is_server():
		friend_left.emit(peer_id)
