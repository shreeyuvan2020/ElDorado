extends Area2D

var velocity: Vector2 = Vector2.ZERO  # Set from player on shoot
var direction: Vector2 = Vector2.ZERO
func _physics_process(delta: float) -> void:
	position += velocity * delta
