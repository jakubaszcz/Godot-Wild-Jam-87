extends TextureButton

@export var on_texture : Texture2D
@export var off_texture : Texture2D

func _on_pressed() -> void:
	var value = not Game.incubator
	if value:
		self.texture_normal = on_texture
	else:
		self.texture_normal = off_texture
	Signals.emit_signal("incubate", value)
