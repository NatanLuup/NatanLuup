## Host/join menu, in-session notices and player spawning for online co-op.
## Implements design/game-brief.md MVP feature 2 (Story 002).
class_name Lobby
extends CanvasLayer

const PLAYER_SCENE: PackedScene = preload("res://src/gameplay/player/player.tscn")

const MSG_HOST_FAILED: String = "Não foi possível hospedar. A porta %d pode estar em uso."
const MSG_HOSTING: String = "Passe para o amigo: %s (porta UDP %d)"
const MSG_HOSTING_NO_LAN: String = "Passe seu IP para o amigo (porta UDP %d)"
const MSG_EMPTY_ADDRESS: String = "Digite o IP de quem está hospedando."
const MSG_JOIN_FAILED: String = "Não foi possível iniciar a conexão com esse IP."
const MSG_CONNECTING: String = "Conectando a %s..."
const MSG_CONNECTION_FAILED: String = "Não foi possível conectar. Confira o IP e se o amigo está hospedando."
const MSG_CONNECTED: String = "Conectado"
const MSG_HOST_LOST: String = "Quem hospedava saiu da partida."
const MSG_GUEST_LEFT: String = "Seu amigo saiu da partida. Ele pode entrar de novo."
const IP_SEPARATOR: String = " ou "

## Node that holds the spawned players. Must match the MultiplayerSpawner's spawn path.
@export var players_path: NodePath
## The MultiplayerSpawner that replicates the players to both peers.
@export var spawner_path: NodePath
## Node whose children mark the spawn positions, in player order.
@export var spawn_points_path: NodePath

@onready var _network: NetworkManager = $NetworkManager
@onready var _players: Node2D = get_node(players_path)
@onready var _spawner: MultiplayerSpawner = get_node(spawner_path)
@onready var _spawn_points: Node2D = get_node(spawn_points_path)
@onready var _menu: Control = $Menu
@onready var _host_button: Button = $Menu/Layout/HostButton
@onready var _address_edit: LineEdit = $Menu/Layout/AddressEdit
@onready var _join_button: Button = $Menu/Layout/JoinButton
@onready var _status_label: Label = $Menu/Layout/StatusLabel
@onready var _hud: Control = $Hud
@onready var _info_label: Label = $Hud/InfoLabel
@onready var _notice_label: Label = $Hud/NoticeLabel
@onready var _leave_button: Button = $Hud/LeaveButton


func _ready() -> void:
	_spawner.spawn_function = _create_player
	_host_button.pressed.connect(_on_host_pressed)
	_join_button.pressed.connect(_on_join_pressed)
	_leave_button.pressed.connect(_on_leave_pressed)
	_network.connected_to_host.connect(_on_connected_to_host)
	_network.connection_failed.connect(_on_connection_failed)
	_network.guest_joined.connect(_on_guest_joined)
	_network.guest_left.connect(_on_guest_left)
	_network.host_lost.connect(_on_host_lost)
	_show_menu("")


func _on_host_pressed() -> void:
	var error: Error = _network.host()
	if error != OK:
		_show_menu(MSG_HOST_FAILED % _network.config.port)
		return
	_show_hud(_hosting_text())
	_spawn_player(multiplayer.get_unique_id(), 0)


func _on_join_pressed() -> void:
	var address: String = _address_edit.text.strip_edges()
	if address.is_empty():
		_show_menu(MSG_EMPTY_ADDRESS)
		return
	if _network.join(address) != OK:
		_show_menu(MSG_JOIN_FAILED)
		return
	_set_menu_enabled(false)
	_status_label.text = MSG_CONNECTING % address


func _on_leave_pressed() -> void:
	_network.leave()
	_end_session("")


func _on_connected_to_host() -> void:
	_show_hud(MSG_CONNECTED)


func _on_connection_failed() -> void:
	_show_menu(MSG_CONNECTION_FAILED)


func _on_guest_joined(peer_id: int) -> void:
	_notice_label.text = ""
	_spawn_player(peer_id, 1)


func _on_guest_left(peer_id: int) -> void:
	_players.get_node(str(peer_id)).queue_free()
	_notice_label.text = MSG_GUEST_LEFT


func _on_host_lost() -> void:
	_end_session(MSG_HOST_LOST)


func _spawn_player(peer_id: int, spawn_index: int) -> void:
	var spawn_position: Vector2 = (_spawn_points.get_child(spawn_index) as Node2D).position
	_spawner.spawn([peer_id, spawn_position])


## Runs on every peer. The start position travels in the spawn data because a
## guest owns its own position, so the host's value is not replicated to it.
func _create_player(data: Array) -> Node:
	var player: Node2D = PLAYER_SCENE.instantiate()
	player.name = str(data[0])
	player.position = data[1]
	return player


func _end_session(message: String) -> void:
	for child: Node in _players.get_children():
		child.queue_free()
	_show_menu(message)


func _hosting_text() -> String:
	var addresses: PackedStringArray = NetworkManager.private_ipv4_addresses(IP.get_local_addresses())
	if addresses.is_empty():
		return MSG_HOSTING_NO_LAN % _network.config.port
	return MSG_HOSTING % [IP_SEPARATOR.join(addresses), _network.config.port]


func _show_menu(status: String) -> void:
	_hud.hide()
	_menu.show()
	_set_menu_enabled(true)
	_status_label.text = status


func _show_hud(info: String) -> void:
	_menu.hide()
	_hud.show()
	_info_label.text = info
	_notice_label.text = ""
	get_viewport().gui_release_focus()


func _set_menu_enabled(enabled: bool) -> void:
	_host_button.disabled = not enabled
	_join_button.disabled = not enabled
	_address_edit.editable = enabled
