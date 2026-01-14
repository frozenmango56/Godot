extends Area2D
var just_punched = false
func _ready():
	self.hide()
	$CollisionShape2D.disabled = true
	
func _physics_process(delta):
	if Input.is_action_just_pressed("punch") and globalvariables.facing == "down" and just_punched == false:
		rotation_degrees = 0
		scale.x = 1
		scale.y = 1
		position = Vector2(-3,11)
		self.show()
		$CollisionShape2D.disabled = false
		for i in range(0,2):
			position.y += 1
			await get_tree().create_timer(.04).timeout
		await get_tree().create_timer(.1).timeout
		position.y += -2
		self.hide()
		$CollisionShape2D.disabled = true
		just_punched = true
		await get_tree().create_timer(.6).timeout
		just_punched = false

	if Input.is_action_just_pressed("punch") and globalvariables.facing == "up" and just_punched == false:
		rotation_degrees = 0
		scale.x = 1
		scale.y = -1
		position = Vector2(-3,-15)
		self.show()
		$CollisionShape2D.disabled = false
		for i in range(0,2):
			position.y += 1
			await get_tree().create_timer(.04).timeout
		await get_tree().create_timer(.1).timeout
		position.y += -2
		self.hide()
		$CollisionShape2D.disabled = true
		just_punched = true
		await get_tree().create_timer(.6).timeout
		just_punched = false

	if globalvariables.facing == "left":
		rotation_degrees = -90
		position = Vector2(-13,4)
		if Input.is_action_just_pressed("punch") and just_punched == false:
			scale.x = 1
			scale.y = -1
			self.show()
			$CollisionShape2D.disabled = false
			for i in range(0,2):
				position.x += -1
				await get_tree().create_timer(.04).timeout
			await get_tree().create_timer(.1).timeout
			position.x += 2
			self.hide()
			$CollisionShape2D.disabled = true
			just_punched = true
			await get_tree().create_timer(.6).timeout
			just_punched = false

	if globalvariables.facing == "right":
		rotation_degrees = 90
		position = Vector2(13,4)
		if Input.is_action_just_pressed("punch") and just_punched == false:
			scale.x = -1
			scale.y = -1
			self.show()
			$CollisionShape2D.disabled = false
			for i in range(0,2):
				position.x += -1
				await get_tree().create_timer(.04).timeout
			await get_tree().create_timer(.1).timeout
			position.x += 2
			self.hide()
			$CollisionShape2D.disabled = true
			just_punched = true
			await get_tree().create_timer(.6).timeout
			just_punched = false
