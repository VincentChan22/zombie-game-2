extends Node2D

@export var pos: Vector2
@export var bullet: PackedScene
	
@export var reloadTime: float
var reload : float = 0
func _input(event):
	if (event.is_action_pressed("lmb") and reload <= 0):
		
		#print("shoot")
		$AudioStreamPlayer2D.play()
		var newBullet = bullet.instantiate() as Bullet
		get_tree().root.add_child(newBullet)
		newBullet.position = pos + global_position
		newBullet.rotation = global_rotation
		reload = reloadTime

func _physics_process(delta):
	
	var mouseDir : Vector2 = get_global_mouse_position() - get_parent().global_position
	global_position = get_parent().global_position + 20 * (mouseDir.normalized())
	look_at(get_global_mouse_position())
		
	if(reload > 0):
		reload -= delta
	

