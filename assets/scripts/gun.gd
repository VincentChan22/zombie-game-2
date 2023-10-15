extends Node2D

@export var pos: Vector2
@export var bullet: PackedScene
	
@export var reloadTime: float
var reload : float = 0
func _input(event):
	if (event.is_action_pressed("lmb") and reload <= 0):
		#print("shoot")
		var newBullet = bullet.instantiate() as Bullet
		get_tree().root.add_child(newBullet)
		newBullet.position = pos + global_position
		newBullet.rotation = global_rotation
		reload = reloadTime

func _physics_process(delta):
	#look_at(get_global_mouse_position())
	if(reload > 0):
		reload -= delta
	
