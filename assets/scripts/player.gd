extends CharacterBody2D

class_name Player

@export var speed := 100
@export var acc := 10
@export var slow_duration := 0.5
const NORMAL_SPEED := 100
const SLOWED_SPEED := 50
var corpse 
var is_holding : bool = false

@export var health_comp : HealthComp
@onready var hold_point := $Holdable

func _physics_process(_delta):
	var input_direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity.x = move_toward(velocity.x, speed * input_direction.x, acc) 
	velocity.y = move_toward(velocity.y, speed * input_direction.y, acc) 
	
	look_at(get_global_mouse_position())
	
	move_and_slide()
	
	if is_holding && Input.is_action_pressed("rmb"):
		corpse.position = hold_point.global_position
		speed = SLOWED_SPEED
	else:
		speed = NORMAL_SPEED
		

func _on_area_2d_area_entered(area):
	if area.name == "Corpse": # add pickup code
		is_holding = true
		corpse = area

func _on_area_2d_area_exited(area):
	if area.name == "Corpse":
		is_holding = false
