extends CharacterBody2D
const SPEED = 150.0
@export var player : Node2D
@onready var navigation := $NavigationAgent2D as NavigationAgent2D
func _on_timer_timeout():
	makepath()
func _physics_process(_delta : float) -> void:
	var dir = to_local(navigation.get_next_path_position()).normalized()
	velocity = dir * SPEED
	move_and_slide()

func makepath() -> void:
	navigation.target_position = player.global_position
