extends StaticBody2D

@onready var player = get_node("../../Astronaut")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.connect("has_all_keys", open_door)



func open_door():
	print("abrindo")
	$AnimationPlayer.active = true
	$AnimationPlayer.play("Open")


func close_door():
	$AnimationPlayer.active = true
	$AnimationPlayer.play("RESET")
