extends CharacterBody2D

@export var incubator_texture_intact : Texture2D
@export var incubator_texture_broken : Texture2D

@onready var sprite : Sprite2D = $Sprite2D

func _ready() -> void:
	Signals.connect("incubate", Callable(self, "_on_incubate"))
	self.visible = false

func _process(delta: float) -> void:
	if Game._get_incubator_state():
		sprite.texture = incubator_texture_broken
	else:
		sprite.texture = incubator_texture_intact
		

func _on_incubate(value) -> void:
	self.visible = value
	
