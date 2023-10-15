extends Node2D

class_name Bullet

@export var speed : float = 200

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_body_entered(body):
	if(body.is_in_group("zombie")):
		print("hit zombiona")
		#zombie takes damage
		body.health_comp.take_damage(1)
		body.cripple()
		pass
	queue_free()
