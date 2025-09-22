extends ProgressBar
var health = 3
func _on_hurt_box_received_damage(damage: int) -> void:
	var ant = get_parent()
	if value - damage > 0:
		value -= damage
		print(value)
		health = value
	elif value - damage <= 0.0:
		ant.queue_free()
