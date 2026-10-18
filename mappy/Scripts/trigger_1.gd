extends Area2D

@export var enemy1: PackedScene
@export var enemy2: PackedScene
@export var key_parts: PackedScene
@export var textures_keys: Array[Texture]
@onready var player: CharacterBody2D = $"../../Astronaut"
var nmbr_enemies_type_1: int
var nmbr_enemies_type_2: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	nmbr_enemies_type_1 = 3
	nmbr_enemies_type_2 = 2





func _on_body_entered(_body: Node2D) -> void:
	triger.call_deferred()
	

func triger():
	queue_free_enemies()
	close_door()
	realocate_and_reset_keys()
	spawn_new_enemies()
	player.reset()
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
		
func spawn_new_enemies():
	var node_enemies = get_node("../../Enemies")
	if node_enemies:
		for i in nmbr_enemies_type_1:
			var new_enemy = enemy1.instantiate()
			new_enemy.player_to_pursuit = player
			new_enemy.global_position = $"Enemies positions".get_children()[i].global_position
			node_enemies.add_child(new_enemy)
			
		for i in nmbr_enemies_type_2:
			var new_enemy = enemy2.instantiate()
			new_enemy.player_to_pursuit = player
			new_enemy.global_position = $"Enemies positions".get_children()[i + nmbr_enemies_type_1].global_position
			node_enemies.add_child(new_enemy)
			
	
func realocate_and_reset_keys():
	var node_keys = get_node("../../Keys")
	for i in range(4):
		var new_key = key_parts.instantiate()
		new_key.textura = textures_keys[i]
		new_key.name = "Key Part" + str(i + 1)
		new_key.global_position = $"Keys positions".get_children()[i].global_position
		node_keys.add_child(new_key)
		
	var complete_key_hud = get_node("../../Camera2D/HUD")
	complete_key_hud.reset()
