extends StaticBody2D

@export var fan_speed: float

func _on_fan_area_body_entered(body: CharacterBody2D) -> void:
	body.start_flying()

func _on_fan_area_body_exited(body: CharacterBody2D) -> void:
	body.stop_flying()
