extends CharacterBody2D

func _ready() -> void:
	Signals.connect("incubate", Callable(self, "_on_incubate"))
	self.visible = false

func _on_incubate(value) -> void:
	self.visible = value
	
