extends Parallax2D

var tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tween = get_tree().create_tween()
	tween.tween_property($Ray,"auto_translate_mode", Color.WHITE, 1.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
