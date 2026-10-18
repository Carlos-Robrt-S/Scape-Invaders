extends Camera2D

@export var player: CharacterBody2D 
var offset_limit: int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	offset_limit = limit_right-limit_left

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if player.position.x > limit_right:
		#position.x = move_toward(position.x, position.x + limit_right_f*2, limit_right_f*2)
		position.x += offset_limit
		limit_left = limit_right
		limit_right += offset_limit
		
	elif player.position.x < limit_left:
		#position.x = move_toward(position.x, position.x - limit_left_f*2, limit_left_f*2)
		position.x -= offset_limit
		limit_right = limit_left
		limit_left -= offset_limit
