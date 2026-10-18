extends "./enemy.gd"

func _ready() -> void:
	super()
	set_speed(7000)
	set_flying_speed(1200)
	can_break_door = true
