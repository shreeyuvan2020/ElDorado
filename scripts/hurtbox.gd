class_name HurtBox
extends Area2D
signal received_damage (damage: int)
@export var health = get_parent()
func _ready():
	print("hello")
	connect("area_entered", _on_area_entered)
func _on_area_entered(hitbox: HitBox) -> void:
	print("hi")
	if hitbox != null:
		health.health -= hitbox.damage
		print(health.health)
		received_damage.emit(hitbox.damage)
