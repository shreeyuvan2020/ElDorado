extends CharacterBody2D
@onready var bow = $Bow
@onready var animated_sprite = $Bow/BowSprite
@onready var shooting_point = $Bow/ShootingPoint
@export var speed = 400
var charging: bool = false
var charge_time: float = 0.0
const MAX_CHARGE_TIME: float = 2.0
const MIN_SPEED: float = 200.0
const MAX_SPEED: float = 600.0
var health: int = 10
var first_time = true
var arrow_scene = preload("res://cool_arrow.tscn")
var current_arrow = null
func _process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	bow.look_at(mouse_pos)
	if Input.is_action_just_pressed("shoot") and not charging:
		if first_time:
			animated_sprite.play("idle")
			first_time = false
		current_arrow = arrow_scene.instantiate()
		current_arrow.add_to_group("area_scene")
		add_child(current_arrow)
		current_arrow.hide()
		current_arrow.global_position = shooting_point.global_position
		current_arrow.global_rotation = bow.global_rotation
		charging = true
		charge_time = 0.0
	if charging and current_arrow:
		charge_time += delta
		charge_time = min(charge_time, MAX_CHARGE_TIME)
	if Input.is_action_just_released("shoot") and charging:
		first_time = true
		animated_sprite.play("new_animation")
		current_arrow.show()
		var global_arrow_pos = current_arrow.global_position
		var global_arrow_rot = current_arrow.global_rotation
		var projectiles = get_tree().current_scene.get_node("Projectiles")
		if projectiles:
			pass
			#projectiles.add_child(current_arrow)
		else:
			get_tree().root.add_child(current_arrow)
		current_arrow.global_position = global_arrow_pos
		var arrow_hitbox = current_arrow.get_node("HitBox")
		current_arrow.global_rotation = global_arrow_rot
		var launch_speed = MIN_SPEED + (MAX_SPEED - MIN_SPEED) * (charge_time / MAX_CHARGE_TIME)
		arrow_hitbox.damage = randf_range(1, launch_speed / 4)
		print(arrow_hitbox.damage)
		current_arrow.speed = launch_speed
		current_arrow.direction = Vector2.RIGHT.rotated(global_arrow_rot)
		charging = false
func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if input_direction.length() > 0:
		input_direction = input_direction.normalized()
	var move_direction = input_direction.rotated(rotation)
	velocity = move_direction * speed if move_direction.length() > 0 else Vector2.ZERO
func _physics_process(delta):
	get_input()
	move_and_slide()
