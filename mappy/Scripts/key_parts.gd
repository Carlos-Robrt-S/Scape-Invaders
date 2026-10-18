extends Area2D

signal key_taken

@export var textura: Texture2D
var direction: int
var speed: float
var amp: float
var freq: float
var time: float = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.texture = textura
	amp = 20
	freq = 2
	speed = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	speed = sin(time * freq) * amp
	translate(Vector2.UP * speed * delta)


func _on_body_entered(_body: Node2D) -> void:
	var index_str: String = $Sprite2D.texture.resource_path
	var index = index_str.to_int()
	key_taken.emit(index)
	queue_free()
