extends KinematicBody2D

var boost_press = false
var time = 0.0
var boost_timer = 0
var boost
export var health = 2
onready var bullet = preload("res://Scenes/bullet2.tscn")
onready var bullet_container = get_node("bullet_container")
onready var gun_timer = get_node("gun_timer")
onready var sprite = get_node("sprite")
onready var muzzle = get_node("muzzle")

func _ready():
	set_process(true)
	set_physics_process(true)
	self.position = Vector2(get_viewport().size.x/1.1, get_viewport().size.y/2)
	self.rotation = deg2rad(90)

func _input(event):
	if(Input.is_key_pressed(KEY_CONTROL) and boost_press == false and time <= 0 and boost_timer <= 0):
		boost = 2
		boost_press = true
		boost_timer = 1

func _physics_process(delta):
	var move_by = Vector2(0,0)

	
	#TRANSLATIONAL INPUT
	if(Input.is_key_pressed(KEY_LEFT)):
		if(Input.is_key_pressed(KEY_DOWN)):
			move_by = Vector2(-5,5)
		elif(Input.is_key_pressed(KEY_UP)):
			move_by = Vector2(-5,-5)
		else:
			move_by = Vector2(-5,0)
	if(Input.is_key_pressed(KEY_RIGHT)):
		if(Input.is_key_pressed(KEY_DOWN)):
			move_by = Vector2(5,5)
		elif(Input.is_key_pressed(KEY_UP)):
			move_by = Vector2(5,-5)
		else:
			move_by = Vector2(5,0)
	if(Input.is_key_pressed(KEY_UP)):
		if(Input.is_key_pressed(KEY_RIGHT)):
			move_by = Vector2(5, -5)
		elif(Input.is_key_pressed(KEY_LEFT)):
			move_by = Vector2(-5, -5)
		else:
			move_by = Vector2(0, -5)
	if(Input.is_key_pressed(KEY_DOWN)):
		if(Input.is_key_pressed(KEY_RIGHT)):
			move_by = Vector2(5, 5)
		elif(Input.is_key_pressed(KEY_LEFT)):
			move_by = Vector2(-5, 5)
		else:
			move_by = Vector2(0, 5)
	
	#ROTATIONAL INPUT 
	if(Input.is_key_pressed(KEY_LEFT)):
		if(Input.is_key_pressed(KEY_UP)):
			self.rotation = deg2rad(-45)
		elif(Input.is_key_pressed(KEY_DOWN)):
			self.rotation = deg2rad(-130)
		else:
			self.rotation = deg2rad(-90)
	if(Input.is_key_pressed(KEY_RIGHT)):
		if(Input.is_key_pressed(KEY_UP)):
			self.rotation = deg2rad(45)
		elif(Input.is_key_pressed(KEY_DOWN)):
			self.rotation = deg2rad(130)
		else:
			self.rotation = deg2rad(90)
	if(Input.is_key_pressed(KEY_UP)):
		if(Input.is_key_pressed(KEY_RIGHT)):
			self.rotation = deg2rad(45)
		elif(Input.is_key_pressed(KEY_LEFT)):
			self.rotation = deg2rad(-45)
		else:
			self.rotation = deg2rad(0)
	if(Input.is_key_pressed(KEY_DOWN)):
		if(Input.is_key_pressed(KEY_RIGHT)):
			self.rotation = deg2rad(130)
		elif(Input.is_key_pressed(KEY_LEFT)):
			self.rotation = deg2rad(-130)
		else:
			self.rotation = deg2rad(180)


	if(Input.is_action_just_pressed("shoot2")):
		var angle = $Sprite.global_rotation + deg2rad(-90)
		var direction = Vector2(cos(angle), sin(angle))
		var b = bullet.instance()
		b.add_collision_exception_with(self)
		b.position = $Sprite/muzzle.global_position
		b.rotation = $Sprite.global_rotation
		b.linear_velocity = direction * 1000
		get_parent().add_child(b)

	#BOOST FUNCTIONALITY
	if(boost_press == true):
		move_by *= boost
		boost_timer -= delta
		if(boost_timer <= 0):
			boost_press = false
			move_by /= boost
			time = 3
	time -= delta
	#FINAL MOVEMENT COMMAND
	self.move_and_collide(move_by)
	

func _on_Area2D_body_entered(body):
	var groups = body.get_groups()
	
	if(groups.has("bullet1")):
		health -= body.get_damage()
		body.get_hit()
		
		if(health <= 0):
			queue_free()
