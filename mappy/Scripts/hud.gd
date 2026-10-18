extends Control

var key_parts
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	key_parts = []
	for child in get_children():
		if child.get_class() == "Sprite2D":
			key_parts.append(child)
	for kp: Sprite2D in key_parts:
		kp.visible = false
		
	for key:Area2D in get_node("../../Keys").get_children():
		if key.has_signal("key_taken"):
			key.key_taken.connect(set_key_part_visible)

func set_key_part_visible(index: int):
	get_child(index-1).visible = true
	
func reset():
	for kp: Sprite2D in key_parts:
		kp.visible = false
		
	for key:Area2D in get_node("../../Keys").get_children():
		if key.has_signal("key_taken"):
			key.key_taken.connect(set_key_part_visible)
