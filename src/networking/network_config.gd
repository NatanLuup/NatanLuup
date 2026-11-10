## Connection settings for online co-op.
## Implements design/game-brief.md MVP feature 2 (Story 002). The live values
## live in assets/data/network_config.tres; the defaults below are fallbacks only.
class_name NetworkConfig
extends Resource

## UDP port the host listens on and the guest connects to.
@export var port: int = 7777
## Guests allowed besides the host. The brief caps the game at 2 players.
@export var max_guests: int = 1
