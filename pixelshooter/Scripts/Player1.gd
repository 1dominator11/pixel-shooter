extends KinematicBody2D

export var speed = 2
export var boost = 5

func _ready():
	set_process(true)

func _process(delta):
	# movement inputs
	if (Input.is_key_pressed(KEY_LEFT)):
		if (Input.is_key_pressed(KEY_SHIFT)):
			self.position.x -= boost
		else:
			self.position.x -= speed

	if (Input.is_key_pressed(KEY_RIGHT)):
		if (Input.is_key_pressed(KEY_SHIFT)):
			self.position.x += boost
		else:
			self.position.x += speed

	if (Input.is_key_pressed(KEY_UP)):
		self.rotation = deg2rad(180)
		if (Input.is_key_pressed(KEY_SHIFT)):
			self.position.y -= boost
		else:
			self.position.y -= speed

	if (Input.is_key_pressed(KEY_DOWN)):
		self.rotation = deg2rad(0)
		if (Input.is_key_pressed(KEY_SHIFT)):
			self.position.y += boost
		else:
			self.position.y += speed

	#rotational inputs
	if (Input.is_key_pressed(KEY_LEFT)):
		if (Input.is_key_pressed(KEY_UP)):
			self.rotation = deg2rad(130)
		elif (Input.is_key_pressed(KEY_DOWN)):
			self.rotation = deg2rad(45)
		else:
			self.rotation = deg2rad(90)

	if (Input.is_key_pressed(KEY_RIGHT)):
		if (Input.is_key_pressed(KEY_UP)):
			self.rotation = deg2rad(-130)
		elif (Input.is_key_pressed(KEY_DOWN)):
			self.rotation = deg2rad(-45)
		else:
			self.rotation = deg2rad(-90)


	if (Input.is_key_pressed(KEY_Q)):
		get_tree().quit()
