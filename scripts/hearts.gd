extends CanvasLayer
var full_heart = preload("res://images/heartHUD.png")
var half_heart = preload("res://images/halfheart.png")
var third_quarter_heart = preload("res://images/4heart.png")
var quarter_heart = preload("res://images/quarterheart.png")
var empty_heart = preload("res://images/emptyheart.png")
@onready var hearts = get_children()
func update_health(health):
	for i in range(hearts.size()):
		var heart_node = hearts[i]
		var full_health_for_this_heart = (i + 1) * 4 # Each heart represents 4 quarter-health points
		var health_remaining_for_this_heart = health - (i * 4)

		if health_remaining_for_this_heart >= 4:
			heart_node.texture = full_heart
		elif health_remaining_for_this_heart == 3:
			heart_node.texture = third_quarter_heart
		elif health_remaining_for_this_heart == 2:
			heart_node.texture = half_heart
		elif health_remaining_for_this_heart == 1:
			# If there are 1/4 health points left, show a quarter heart.
			heart_node.texture = quarter_heart
		else:
			heart_node.texture = empty_heart
	
	
