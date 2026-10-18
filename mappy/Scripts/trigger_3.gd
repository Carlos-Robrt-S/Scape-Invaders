extends Area2D




func _on_body_entered(_body: Node2D) -> void:
	triger.call_deferred()
	

func triger():
	queue_free_enemies()
	close_door()
	hide_hud()
	show_final_message()
	queue_free()


func queue_free_enemies():
	var enemies = get_node("../../Enemies")
	for enemy in enemies.get_children():
		enemy.queue_free()
		
		
func close_door():
	var doors = get_node("../../Main Doors/")
	if doors:
		for door in doors.get_children():
			door.close_door()
			
func hide_hud():
	var hud = get_node("../../Camera2D/HUD")
	hud.visible = false

func show_final_message():
	var control = get_node("../../Final Message")
	control.visible = true
