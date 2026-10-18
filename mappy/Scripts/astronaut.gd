extends CharacterBody2D

const SPEED = 8000.0
const JUMP_VELOCITY = -400.0
var player_is_flying: bool
var nmbr_of_keys: int
signal has_all_keys

func _ready() -> void:
	player_is_flying = false
	nmbr_of_keys = 0
	for key:Area2D in get_node("../Keys").get_children():
		if key.has_signal("key_taken"):
			key.key_taken.connect(increase_nmbr_keys)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if player_is_flying:
		velocity.y += -1600 * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction < 0:
		$AnimatedSprite2D.flip_h = true
	elif direction > 0:
		$AnimatedSprite2D.flip_h = false
	if direction:
		velocity.x = direction * SPEED * delta
		$AnimatedSprite2D.play("move")
	else:
		#Vai de velocity.x para 0 a uma taxa de SPEED, ou seja, para imediatamende
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.play("idle")

	move_and_slide()
	
	var obj_collided := get_last_slide_collision()
	if obj_collided and obj_collided.get_collider().get_class() == "CharacterBody2D":
		set_physics_process(false)
		visible = false


func start_flying():
	player_is_flying = true
	
func stop_flying():
	player_is_flying = false
	
func increase_nmbr_keys(_index):
	nmbr_of_keys += 1
	print(nmbr_of_keys)
	if nmbr_of_keys == 4:
		has_all_keys.emit()
		print ("coletou todas as chaves")
	
func reset():
	nmbr_of_keys = 0
	print (get_node("../Keys").get_children())
	for key:Area2D in get_node("../Keys").get_children():
		print (key)
		if key.has_signal("key_taken"):
			key.key_taken.connect(increase_nmbr_keys)
	
