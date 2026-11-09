## A player bullet: flies in a straight line and is removed once it leaves the screen.
## Implements design/game-brief.md MVP feature 1 (Story 001).
class_name Bullet
extends Area2D

var _velocity: Vector2 = Vector2.ZERO


func _ready() -> void:
	$VisibleOnScreenNotifier2D.screen_exited.connect(queue_free)


## Sets the bullet's direction and speed (pixels per second). Call before adding it to the tree.
func setup(direction: Vector2, speed: float) -> void:
	_velocity = direction.normalized() * speed
	rotation = direction.angle()


func _physics_process(delta: float) -> void:
	position += _velocity * delta
