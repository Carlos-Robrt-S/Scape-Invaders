extends StaticBody2D

@export var door_states_sprites: Array[Texture]
@onready var sprite: Sprite2D = $Sprite2D
var in_active_area: bool = false
var life: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.texture = door_states_sprites[0]
	$Label.visible = false
	life = 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if in_active_area:
		$Label.visible = true
		if Input.is_action_just_pressed("action"):
			$HitBox.disabled = not $HitBox.disabled
			change_state_door_sprite()

func is_body_the_player(body: Node2D):
	return body.get_class() == "CharacterBody2D" and body.get_visibility_layer_bit(0) 

func _on_activation_area_body_entered(body: Node2D) -> void:
	if is_body_the_player(body):
		in_active_area = true

	if body.get_visibility_layer_bit(1):
		if body.can_break_door and not $HitBox.disabled:
			life -= 1
			check_destruction()

func _on_activation_area_body_exited(body: Node2D) -> void:
	if is_body_the_player(body):
		in_active_area = false
		$Label.visible = false
	
	
func change_state_door_sprite():
	if $HitBox.disabled == false:
		sprite.texture = door_states_sprites[0]
	elif $HitBox.disabled == true:
		sprite.texture = door_states_sprites[1]
		
func check_destruction():
	if life <= 0:
		queue_free()
