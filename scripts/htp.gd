extends Control

# ------------------------------------------------------------------
# Signal public – on l’émettra quand on veut changer de slide
signal slide(id)

var texts : Array[String] = [
	"Get familiar with the game interface",
	"To decrease the humidity, please keep pressing this button. REMEMBER the higher the himidity percentage is, the quicker to rotting process is.",
	"The lamp allow you to keep the fruit edible, put be careful the lamp can be off for no reason, or when the power cuts off. Just press where the red arrow is to turn it on.",
	"The incubator, the only thing that can really carry you, it reduce the rotting process a lot, but it cames with a disadventage, see that progress bar ? Use the red button to refill it, if it breaks, nothing can bring him back, not even ctrl + z",
	"The temperature, it is in your interest to be careful while using it, keep it near 0, even 0 is better. but if you missclick you can increase the temperature even if it's not on purpose. And I think you know the consequances of this...",
	"One last thing, some time, and the more you go through the game the more you'll have power break, just to repair them, find the correct path, but while power off, you cant do anything else, so hurry up pal.."
]

var images : Array[Texture2D] = [
	preload("res://assets/htp/main.png"),
	preload("res://assets/htp/humidity.png"),
	preload("res://assets/htp/lamp.png"),
	preload("res://assets/htp/incubator.png"),
	preload("res://assets/htp/temperature.png"),
	preload("res://assets/htp/power.png")
]

@export var imager : TextureRect
@export var descriptor : Label

var _current_index : int = 0

func _ready() -> void:
	self.connect("slide", Callable(self, "_on_slide"))
	_show_current_slide()


func _on_slide(id: int) -> void:
	_current_index = clamp(id, 0, texts.size() - 1)
	_show_current_slide()


func _show_current_slide() -> void:
	descriptor.text = texts[_current_index]
	imager.texture = images[_current_index]


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		match event.keycode:
			KEY_LEFT, KEY_A:
				_navigate(-1)
			KEY_RIGHT, KEY_D:
				_navigate(1)
			KEY_ESCAPE:
				get_tree().change_scene_to_file("res://nodes/menu.tscn")


func _navigate(delta: int) -> void:
	var new_index = _current_index + delta
	new_index = clamp(new_index, 0, texts.size() - 1)

	if new_index != _current_index:
		emit_signal("slide", new_index)
