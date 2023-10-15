extends Node2D

class_name GameController

@export var zombie : PackedScene
@export var center_pos: Vector2
@export var spawn_radius: float
@onready var zombie_timer := $zombie_timer as Timer
@onready var prep_phase_timer := $prep_phase_timer as Timer

var isAttackPhase: bool = false
var waveNumber: int = 0
var numZombiesToSpawn :int = 0

func _ready():
	startPrepPhase()
func startAttackPhase():
	print("attack!")
	waveNumber += 1
	numZombiesToSpawn = waveNumber
	zombie_timer.start()
func startPrepPhase():
	print("prep")
	prep_phase_timer.start()

func zombieDied():
	var zombie_size := get_tree().get_nodes_in_group("zombie").size()
	print(zombie_size)
	if (zombie_size <= 1):
		print("all died")
		startPrepPhase()
	
#spawn zombie
#respawn zombie
#identify when all zombie dead
#timer for prep phase


func _on_timer_timeout():
	zombie_timer.stop()
	var newZombie = zombie.instantiate() as Node2D
	get_tree().root.add_child(newZombie)
	var randomAngle :float = randf_range(0, 2 * PI)
	newZombie.global_position = center_pos + spawn_radius * Vector2(cos(randomAngle), sin(randomAngle))
	#newZombie.game_controller = self
	numZombiesToSpawn -= 1
	if(numZombiesToSpawn > 0):
		zombie_timer.start()


func _on_prep_phase_timer_timeout():
	prep_phase_timer.stop()
	startAttackPhase()
