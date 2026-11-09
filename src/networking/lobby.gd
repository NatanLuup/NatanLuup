## Main menu for co-op: host a game or join a friend by IP, then load the arena.
## Implements design/game-brief.md MVP feature 2 (Story 002).
extends Node

const ARENA_SCENE: PackedScene = preload("res://src/levels/test_arena.tscn")

## Network port used to host and join. Both players must use the same one.
@export var port: int = 7777

var _arena: CoopArena = null

@onready var _session: NetworkSession = $NetworkSession
@onready var _world: Node = $World
@onready var _menu: CanvasLayer = $Menu
@onready var _host_button: Button = %HostButton
@onready var _join_button: Button = %JoinButton
@onready var _address_edit: LineEdit = %AddressEdit
@onready var _addresses_label: Label = %AddressesLabel
@onready var _status_label: Label = %StatusLabel


func _ready() -> void:
	_host_button.pressed.connect(_on_host_pressed)
	_join_button.pressed.connect(_on_join_pressed)
	_session.joined.connect(_on_joined)
	_session.join_failed.connect(_on_join_failed)
	_session.host_lost.connect(_on_host_lost)

	var addresses: PackedStringArray = NetworkSession.local_ipv4_addresses()
	if addresses.is_empty():
		_addresses_label.text = tr("Nenhum IP de rede encontrado neste PC.")
	else:
		_addresses_label.text = tr("Se for hospedar, passe um destes IPs para o amigo: %s") % ", ".join(addresses)
	_status_label.text = tr("Testando no mesmo PC? Hospede numa janela e entre com 127.0.0.1 na outra.")
	_host_button.grab_focus()


func _on_host_pressed() -> void:
	var error: Error = _session.host(port)
	if error != OK:
		_status_label.text = tr("Não deu para hospedar na porta %d (erro %d). Outro jogo já está usando?") % [port, error]
		return
	_start_arena()
	_menu.hide()


func _on_join_pressed() -> void:
	var address: String = _address_edit.text.strip_edges()
	if not address.is_valid_ip_address():
		_status_label.text = tr("Digite o IP do seu amigo (ex.: 192.168.0.10).")
		_address_edit.grab_focus()
		return
	var error: Error = _session.join(address, port)
	if error != OK:
		_status_label.text = tr("Não deu para conectar (erro %d).") % error
		return
	# Load the arena before the connection completes, so it is ready when the
	# host sends the players.
	_start_arena()
	_set_buttons_enabled(false)
	_status_label.text = tr("Conectando a %s...") % address


func _on_joined() -> void:
	_menu.hide()
	_set_buttons_enabled(true)


func _on_join_failed() -> void:
	_stop_arena()
	_set_buttons_enabled(true)
	_status_label.text = tr("Não conectou. Confira o IP e se o amigo está hospedando.")
	_join_button.grab_focus()


func _on_host_lost() -> void:
	_stop_arena()
	_set_buttons_enabled(true)
	_menu.show()
	_status_label.text = tr("A conexão com o anfitrião caiu.")
	_host_button.grab_focus()


func _start_arena() -> void:
	_arena = ARENA_SCENE.instantiate() as CoopArena
	_arena.session = _session
	_world.add_child(_arena)


func _stop_arena() -> void:
	if _arena != null:
		_arena.queue_free()
		_arena = null


func _set_buttons_enabled(enabled: bool) -> void:
	_host_button.disabled = not enabled
	_join_button.disabled = not enabled
