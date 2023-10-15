extends Area2D

class_name Corpse

@export var zombie := load("res://scenes/zombie.tscn")

func _process(delta):
	pass

func revive():
	var new_zombie = zombie.instantiate() 
	get_tree().root.add_child(new_zombie)
	new_zombie.position = self.global_position
	queue_free()
