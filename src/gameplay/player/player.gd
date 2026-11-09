## Player character: runs, jumps and shoots.
## Implements design/game-brief.md MVP feature 1 (Story 001).
class_name Player
extends CharacterBody2D

const BULLET_SCENE: PackedScene = preload("res://src/gameplay/weapons/bullet.tscn")

## Tuning values. The scene assigns assets/data/player_stats.tres.
@export var stats: PlayerStats

var _facing: float = 1.0
var _shot_cooldown: float = 0.0

@onready var _visual: Node2D = $Visual


func _ready() -> void:
	InputActions.ensure_defaults()


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += stats.gravity * delta

	var axis: float = Input.get_axis(InputActions.MOVE_LEFT, InputActions.MOVE_RIGHT)
	velocity.x = axis * stats.run_speed
	if axis != 0.0:
		_facing = signf(axis)
		_visual.scale.x = _facing

	if Input.is_action_just_pressed(InputActions.JUMP) and is_on_floor():
		velocity.y = -stats.jump_velocity

	move_and_slide()

	_shot_cooldown = maxf(_shot_cooldown - delta, 0.0)
	if Input.is_action_pressed(InputActions.SHOOT) and _shot_cooldown == 0.0:
		_shoot()


## Direction a shot travels: straight up while aiming up, otherwise the way
## the player faces (facing is 1.0 for right, -1.0 for left).
static func aim_direction(aiming_up: bool, facing: float) -> Vector2:
	if aiming_up:
		return Vector2.UP
	return Vector2(facing, 0.0)


func _shoot() -> void:
	_shot_cooldown = stats.fire_interval
	var aiming_up: bool = Input.is_action_pressed(InputActions.AIM_UP)
	var direction: Vector2 = aim_direction(aiming_up, _facing)

	var spawn_offset: Vector2
	if aiming_up:
		spawn_offset = Vector2(0.0, -stats.muzzle_up_offset)
	else:
		spawn_offset = Vector2(stats.muzzle_offset.x * _facing, stats.muzzle_offset.y)

	var bullet: Bullet = BULLET_SCENE.instantiate() as Bullet
	bullet.setup(direction, stats.bullet_speed)
	get_parent().add_child(bullet)
	bullet.global_position = global_position + spawn_offset
