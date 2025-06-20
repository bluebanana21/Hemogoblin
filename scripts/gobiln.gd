extends CharacterBody2D

@export var speed:float = 200.0
@onready var player = get_node("/root/MainWorld/Player")



func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * (speed * 2) * delta
	move_and_slide()


func _on_tree_exited() -> void:
	print("enemy has died")
