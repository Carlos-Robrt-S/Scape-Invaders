extends CharacterBody2D

var speed: float = 13000.0
var flying_speed: float = 1400
var enemy_is_flying: bool
var direction: float
var define_random_direction: bool = true
var can_break_door: bool
@export var player_to_pursuit: CharacterBody2D
@export var treshold_wall_collision: float = 17
@onready var animation = get_node("AnimatedSprite2D")
@onready var player = player_to_pursuit
@onready var ray_right: RayCast2D = RayCast2D.new()
@onready var ray_left: RayCast2D = RayCast2D.new()

func _ready() -> void:
	can_break_door = false
	enemy_is_flying = false
	
	
	#Add Rays to the tree
	add_child(ray_right)
	add_child(ray_left)
	
	#Defines size, direction and collision masks
	ray_right.target_position = Vector2(10000, 0)
	ray_left.target_position = Vector2(-10000, 0)
	ray_left.collision_mask = 1
	ray_right.collision_mask = 1
	ray_left.set_collision_mask_value(3, true)
	ray_right.set_collision_mask_value(3, true)
	
	

func _physics_process(delta: float) -> void:
	if not player:
		return
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if enemy_is_flying:
		velocity.y -= flying_speed * delta
	

		
	pursuit_player(player, delta)

	move_and_slide()

func start_flying():
	enemy_is_flying = true 
	
func stop_flying():
	enemy_is_flying = false

func pursuit_player(_player: CharacterBody2D, delta: float):

	define_direction(ray_left, ray_right)

	if enemy_is_flying:
		velocity.x = speed * direction * delta * 0.3
	else:
		velocity.x = speed * direction * delta
			
	animation.play("move")
	
func set_speed(s: float):
	speed = s
	
func set_flying_speed(s: float):
	flying_speed = s

func is_ray_colliding_with_player(ray: RayCast2D) -> bool:
	var obj = ray.get_collider()
	return obj == player
	
func is_ray_collinding_with_wall(ray: RayCast2D):
	var collision_point = ray.get_collision_point()
	var distance_to_wall = global_position.distance_to(collision_point)
	return distance_to_wall <= treshold_wall_collision
	
	
func define_direction(ray_left_: RayCast2D, ray_right_: RayCast2D):
	
	if is_ray_colliding_with_player(ray_left_) or is_ray_colliding_with_player(ray_right_):
		direction = position.direction_to(player.position).x
		direction = clampf(direction, -1, 1)
		define_random_direction = true
		
	elif is_ray_collinding_with_wall(ray_left_) or is_ray_collinding_with_wall(ray_right_):
		direction *= -1
		
	else:
		if define_random_direction:
			direction = 1 if randi()%2 == 0 else -1
			define_random_direction = false

	if direction > 0:
		animation.flip_h = true
		direction = ceil(direction)
			
	elif direction < 0:
		animation.flip_h = false
		direction = floor(direction)
		
