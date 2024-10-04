extends ProgressBar

var sb

func _ready():
	sb = StyleBoxFlat.new()
	add_theme_stylebox_override("fill", sb)
	sb.bg_color=Color("#d6458d")
