extends Area2D

@onready var absorb_timer: Timer = $AbsorbTimer
@onready var player_in_scene = $/root/MainWorld/Player

var blood_ammo_in_splatter:int = 4
var is_being_absorbed:bool = false

func _physics_process(delta: float) -> void:
	if blood_ammo_in_splatter == 0:
		call_deferred("free")


func change_absorb_bool(boolean:bool) -> void:
	is_being_absorbed = boolean
	being_absorbed()


func being_absorbed():
	if !is_being_absorbed:
		print("is NOT being absorbed from blood splatter")
		absorb_timer.stop()
	else:
		print("is being absorbed from blood splatter")
		absorb_timer.start()


func _on_absorb_timer_timeout() -> void:
	give_blood_to_player(player_in_scene)
	blood_ammo_in_splatter -= 1
	print("bloood absorb timeout")


func _on_blood_expire_timeout() -> void:
	queue_free()


func give_blood_to_player(target):
	player_in_scene.receive_blood()
