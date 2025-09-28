class_name HurtBox
extends Area2D
signal received_damage (damage: int)
func _ready():
	connect("area_entered", _on_area_entered)
func _on_area_entered(area: Area2D) -> void:
	if area != null and area is HitBox:
		received_damage.emit(area.damage)
