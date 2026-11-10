## Tuning values for the player character.
## Implements design/game-brief.md MVP feature 1 (Story 001). The live values
## live in assets/data/player_stats.tres; the defaults below are fallbacks only.
class_name PlayerStats
extends Resource

## Horizontal run speed, in pixels per second.
@export var run_speed: float = 220.0
## Upward speed applied when a jump starts, in pixels per second.
@export var jump_velocity: float = 520.0
## Downward acceleration while airborne, in pixels per second squared.
@export var gravity: float = 1400.0
## Minimum time between two shots while the shoot button is held, in seconds.
@export var fire_interval: float = 0.15
## Bullet travel speed, in pixels per second.
@export var bullet_speed: float = 900.0
## Where a sideways shot spawns, relative to the player's origin, for a player facing right.
@export var muzzle_offset: Vector2 = Vector2(22.0, -6.0)
## How far above the player's origin an upward shot spawns, in pixels.
@export var muzzle_up_offset: float = 28.0
## Body color of the guest in online co-op, so the two players can be told apart.
@export var guest_color: Color = Color(0.75, 0.3, 0.2, 1.0)
