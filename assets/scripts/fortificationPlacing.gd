extends Node2D

class_name fortification_placing

@export var wall: PackedScene
signal place(player : Node2D)
var holding :bool = false
var num_fortification = 0;
func _input(event):
	if(event.is_action_pressed("place") and num_fortification > 0):
		if(!holding):
			var newWall = wall.instantiate()
			get_tree().root.add_child(newWall)
			place.connect(newWall.setPlayer)
			place.emit(get_parent());
			newWall.preview()
			num_fortification -= 1
			holding = true
		else:
			holding = false
