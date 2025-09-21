extends ProgressBar
var health = 3
var ant = get_parent()
func _on_hurt_box_received_damage(damage: int) -> void:
	if health - damage > 0:
		print(ant)
		print(value)
		value -= damage
	else:
		ant.queue_free()
