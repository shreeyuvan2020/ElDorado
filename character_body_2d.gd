extends CharacterBody2D
@onready var bow=$Bow
@onready var animated_sprite = $Bow/BowSprite
@onready var shooting_point = $Bow/ShootingPoint
@export var speed = 400
var charging: bool = false
var charge_time: float = 0.0
const MAX_CHARGE_TIME: float = 1.0
const MIN_SPEED: float = 200.0
const MAX_SPEED: float = 600.0
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
		bow.add_child(current_arrow)
		current_arrow.global_position = shooting_point.global_position
		current_arrow.global_rotation = bow.global_rotation
		charging = true
		charge_time = 0.0
	if charging and current_arrow:
		charge_time += delta
		charge_time = min(charge_time, MAX_CHARGE_TIME)
		var draw_distance = charge_time / MAX_CHARGE_TIME * 20.0
		current_arrow.position = shooting_point.position - Vector2(draw_distance, 0)
	if Input.is_action_just_released("shoot") and charging:
		first_time = true
		animated_sprite.play("new_animation")
		var global_arrow_pos = current_arrow.global_position
		var global_arrow_rot = current_arrow.global_rotation
		bow.remove_child(current_arrow)
		get_tree().current_scene.get_node("Projectiles").add_child(current_arrow)
		current_arrow.global_position = global_arrow_pos
		current_arrow.global_rotation = global_arrow_rot
		var direction = (mouse_pos - global_position).normalized()
		var speed = MIN_SPEED + (MAX_SPEED - MIN_SPEED) * (charge_time / MAX_CHARGE_TIME)
		current_arrow.velocity = direction * speed
		current_arrow.direction = direction
		current_arrow = null
		charging = false
func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()
