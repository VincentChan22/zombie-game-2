extends StaticBody2D

class_name wall

@export var sprite: Sprite2D
@export var coll2D: CollisionShape2D
var holding: bool
var player: Node2D
@export var health_comp: HealthComp 
func _ready():
	#sprite = get_node("Sprite2D")
	#coll2D = get_node("CollisionShape2D")
	pass
func setPlayer(_player: Node2D):
	player = _player
func preview():
	#print("preview")
	coll2D.disabled = true
	sprite.modulate.a = 0.5
	holding = true
	
func place():
	sprite.modulate.a = 1
	coll2D.disabled = false
	holding = false
	
func _process(delta):
	
	if(holding):
		var mouseDir : Vector2 = get_global_mouse_position() - player.global_position
		position = player.global_position + 20 * (mouseDir.normalized())
		look_at(get_global_mouse_position())

func handle_destroy():
	if health_comp.health <= 0:
		queue_free()

func _input(event):
	if(event.is_action_pressed("place") && holding):
		place()
