extends RigidBody2D

export var damage = 1

func _ready():
	set_process(true)
	
func _process(delta):
	pass

func get_damage():
	return damage
	
func get_hit():
	queue_free()

func _on_Timer_timeout():
	queue_free()






