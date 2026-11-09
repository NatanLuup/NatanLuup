## Test arena for co-op: the host spawns one player per connected peer, and
## the MultiplayerSpawner replicates them to the friend.
## Implements design/game-brief.md MVP features 1 and 2 (Stories 001 and 002).
class_name CoopArena
extends Node2D

const PLAYER_SCENE: PackedScene = preload("res://src/gameplay/player/player.tscn")

## Where each player appears: the host takes the first point, the friend the second.
@export var spawn_points: Array[Vector2] = [Vector2(200, 640), Vector2(260, 640)]
## How long an on-screen notice stays visible, in seconds.
@export var notice_duration: float = 3.0

## The session that owns the connection. Set by the lobby before the arena enters the tree.
var session: NetworkSession

@onready var _players: Node2D = $Players
@onready var _projectiles: Node2D = $Projectiles
@onready var _spawner: MultiplayerSpawner = $PlayerSpawner
@onready var _notice_label: Label = %NoticeLabel


func _ready() -> void:
	_spawner.add_spawnable_scene(PLAYER_SCENE.resource_path)
	_spawner.spawned.connect(_on_player_spawned)
	if multiplayer.is_server():
		session.friend_joined.connect(_on_friend_joined)
		session.friend_left.connect(_on_friend_left)
		_add_player(multiplayer.get_unique_id())


func _add_player(peer_id: int) -> void:
	var player: Player = PLAYER_SCENE.instantiate() as Player
	player.name = str(peer_id)
	var slot: int = mini(_players.get_child_count(), spawn_points.size() - 1)
	player.position = spawn_points[slot]
	player.projectile_parent = _projectiles
	_players.add_child(player, true)


func _on_friend_joined(peer_id: int) -> void:
	_add_player(peer_id)
	_show_notice(tr("Seu amigo entrou!"))


func _on_friend_left(peer_id: int) -> void:
	var player: Node = _players.get_node_or_null(str(peer_id))
	if player != null:
		player.queue_free()
	_show_notice(tr("Seu amigo desconectou."))


func _on_player_spawned(node: Node) -> void:
	(node as Player).projectile_parent = _projectiles


func _show_notice(text: String) -> void:
	_notice_label.text = text
	_notice_label.show()
	get_tree().create_timer(notice_duration).timeout.connect(_notice_label.hide)
