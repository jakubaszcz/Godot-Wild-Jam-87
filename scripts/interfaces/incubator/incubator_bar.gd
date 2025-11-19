extends ProgressBar

var timer : float = 0.3
var time : float = 0.0
var start : bool = false

func _ready() -> void:
	Signals.connect("incubate_bar", Callable(self, "_on_incubate_bar"))
	Signals.connect("incubate", Callable(self, "_on_incubate"))
	
	time = 0.0
	self.value = 100

func _on_incubate_bar(value) -> void:
	self.value = value

func _on_incubate(value) -> void:
	start = value

func _process(delta: float) -> void:
		print("satrt ? " + str(start))
		if start:
			time += delta
	
			print("Percent : " + str(_get_percent()))
	
			if time >= timer:
				Signals.emit_signal("incubate_bar", (_get_percent() - 1))
				time = 0.0


func _set_percent(value : int) -> void:
	self.value = value


func _get_percent() -> int:
	return self.value
