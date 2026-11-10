## Opens and closes the online co-op connection over direct IP (ENet).
## Implements design/game-brief.md MVP feature 2 (Story 002). Knows nothing about
## players or UI: it reports what happened through signals.
class_name NetworkManager
extends Node

## The guest finished connecting to the host.
signal connected_to_host
## The guest could not reach the host.
signal connection_failed
## A guest arrived. Emitted on the host only.
signal guest_joined(peer_id: int)
## A guest left. Emitted on the host only.
signal guest_left(peer_id: int)
## The host went away. Emitted on the guest only.
signal host_lost

## Port and player cap. The Lobby scene assigns assets/data/network_config.tres.
@export var config: NetworkConfig


func _ready() -> void:
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)
	multiplayer.connected_to_server.connect(connected_to_host.emit)
	multiplayer.connection_failed.connect(_on_connection_failed)
	multiplayer.server_disconnected.connect(_on_server_disconnected)


## Starts hosting on the configured port. Returns OK, or the error from ENet
## (for example when the port is already in use).
func host() -> Error:
	var peer := ENetMultiplayerPeer.new()
	var error: Error = peer.create_server(config.port, config.max_guests)
	if error == OK:
		multiplayer.multiplayer_peer = peer
	return error


## Starts connecting to the host at [param address]. Returns OK when the attempt
## started; [signal connected_to_host] or [signal connection_failed] gives the result.
func join(address: String) -> Error:
	var peer := ENetMultiplayerPeer.new()
	var error: Error = peer.create_client(address, config.port)
	if error == OK:
		multiplayer.multiplayer_peer = peer
	return error


## Closes the connection and goes back to offline mode.
func leave() -> void:
	multiplayer.multiplayer_peer.close()
	multiplayer.multiplayer_peer = OfflineMultiplayerPeer.new()


## Returns the private IPv4 addresses in [param addresses], the ones a friend on
## the same network can use. Loopback, link-local and IPv6 entries are dropped.
## Usage: NetworkManager.private_ipv4_addresses(IP.get_local_addresses())
static func private_ipv4_addresses(addresses: PackedStringArray) -> PackedStringArray:
	var result := PackedStringArray()
	for address: String in addresses:
		if address.contains(":"):
			continue
		if address.begins_with("192.168.") or address.begins_with("10.") or _is_172_private(address):
			result.append(address)
	return result


static func _is_172_private(address: String) -> bool:
	var parts: PackedStringArray = address.split(".")
	return parts[0] == "172" and parts.size() == 4 and parts[1].to_int() >= 16 and parts[1].to_int() <= 31


func _on_peer_connected(peer_id: int) -> void:
	if multiplayer.is_server():
		guest_joined.emit(peer_id)


func _on_peer_disconnected(peer_id: int) -> void:
	if multiplayer.is_server():
		guest_left.emit(peer_id)


func _on_connection_failed() -> void:
	multiplayer.multiplayer_peer = OfflineMultiplayerPeer.new()
	connection_failed.emit()


func _on_server_disconnected() -> void:
	multiplayer.multiplayer_peer = OfflineMultiplayerPeer.new()
	host_lost.emit()
