extends ProgressBar

var timer : float = 0.3
var time : float = 0.0
var start : bool = false

func _ready() -> void:
	Signals.connect("incubate_bar", Callable(self, "_on_incubate_bar"))
	Signals.connect("incubate", Callable(self, "_on_incubate"))
	
	_reset_time()
	self.value = 100

func _reset_time() -> void:
	time = 0.0

func _on_incubate_bar(value) -> void:
	self.value = value
	if _get_percent() <= 0:
		Signals.emit_signal("incubate", false)

func _on_incubate(value) -> void:
	start = value

func _process(delta: float) -> void:
		if start:
			time += delta
	
			if time >= timer:
				Signals.emit_signal("incubate_bar", (_get_percent() - 1))
				_reset_time()


func _set_percent(value : int) -> void:
	self.value = value


func _get_percent() -> int:
	return self.value
