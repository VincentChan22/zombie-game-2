extends Node

class_name HealthComp

@export var max_health : int = 3
var health : int 

func _ready():
	health = max_health

func take_damage(val: int):
	set_health(health - val)
#	if(health <= 0):
#		die()
	
func set_health(val: int):
	if val > max_health:
		health = max_health
	elif health - val < 0:
		health = 0
	else:
		health = val
		
func die():
	#body
	get_parent().queue_free()
