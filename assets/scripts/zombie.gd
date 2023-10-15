extends CharacterBody2D

@onready var player := get_tree().root.get_node("TEST/TileMap/Player") 
#@export var player : Node2D
@export var corpse : PackedScene
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var slow_timer := $SlowTimer as Timer
@onready var attack_timer := $AttackTimer as Timer

@export var acc : float = 10
@export var speed : float = NORMAL_SPEED
const NORMAL_SPEED := 100
const SLOWED_SPEED := 0
@export var health_comp : HealthComp
@export var game_controller: Node2D
var is_attacking : bool = false
var curBody: Node2D = null

func _ready() -> void:
	speed = player.speed * 1
	game_controller = get_tree().root.get_child(0).find_child("game_controller")


func make_path() -> void:
	nav_agent.target_position = player.global_position

func _physics_process(_delta) -> void:
#	shuffle()
	navigate()
	handle_die()
	
#func shuffle() -> void:
#	velocity = get_global_transform().basis_xform(Vector2.RIGHT) * speed 
#	move_and_slide()
#	look_at(player.position)
	
func navigate():
	var direction := to_local(nav_agent.get_next_path_position()).normalized()
	velocity = direction * speed
	move_and_slide()
	
func _on_timer_timeout():
	make_path()

func cripple():
	speed = SLOWED_SPEED
	slow_timer.start()

func handle_die():
	
	if (health_comp.health <= 0):
		game_controller.zombieDied()
		var new_corpse := corpse.instantiate() 
		get_tree().root.add_child(new_corpse)
		new_corpse.position = self.global_position
		queue_free()


func _on_slow_timer_timeout():
	speed = NORMAL_SPEED

func _on_area_2d_body_entered(body):
	print(body )
	if (body.is_in_group("wall")):
		body = body as wall
		curBody = body
		is_attacking = true
		attack_timer.start()

func _on_attack_timer_timeout():
	print("attack timer called")
	attack_timer.stop()
	if curBody:
		curBody.health_comp.take_damage(1)
		attack_timer.start()


func _on_area_2d_body_exited(body):
	if (body.is_in_group("wall")):
		is_attacking
		curBody = null
