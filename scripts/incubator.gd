extends CharacterBody2D

@export var incubator_texture_intact : Texture2D
@export var incubator_texture_broken : Texture2D
@export var incubator_texture_off : Texture2D

@onready var sprite : Sprite2D = $Sprite2D

var active : bool = false

func _ready() -> void:
	Signals.connect("incubate", Callable(self, "_on_incubate"))
	sprite.texture = incubator_texture_off

func _process(delta: float) -> void:
	if not active:
		sprite.texture = incubator_texture_off
		return
	if Game._get_incubator_state():
		sprite.texture = incubator_texture_broken
	else:
		sprite.texture = incubator_texture_intact
		

func _on_incubate(value) -> void:
	active = value
	if value:
		sprite.texture = incubator_texture_intact
	else:
		sprite.texture = incubator_texture_off
	
