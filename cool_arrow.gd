extends Area2D
@export var speed: float = 0
var direction: Vector2 = Vector2.RIGHT
var dot_radius: float = 10
var dot_color: Color = Color.RED

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	if direction != Vector2.ZERO:
		rotation = direction.angle()
