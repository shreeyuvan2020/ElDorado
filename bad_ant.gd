extends CharacterBody2D
@export var movement_speed =  80
@onready var navigation: NavigationAgent2D = $NavigationAgent2D
@onready var target_to_chase: CharacterBody2D = get_node("../Player")
@onready var biter = $Biter
var health: int = 3
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
static var visible_collisions: bool = false
func _physics_process(delta: float) -> void:
	biter.play("default") 
	navigation.target_position = target_to_chase.global_position
	velocity = global_position.direction_to(navigation.get_next_path_position()) * movement_speed
	move_and_slide()
	while abs(global_position - target_to_chase.global_position) < Vector2(5,5):
		biter.play("biting")
		await get_tree().create_timer(0.5).timeout
		biter.stop
		biter.play("default")
		
