extends StaticBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#axis_lock_angular_x = true
	#axis_lock_angular_y = true
	#axis_lock_angular_z = true
	#axis_lock_linear_x = true
	#axis_lock_linear_y = false # only move up/down
	#axis_lock_linear_z = true
	
	## create area that handles mouse events
	#var area = Area3D.new()
	#var select_shape = CollisionShape3D.new()
	#select_shape.shape = load("res://assets/collision_shapes/Hex_inner_cylinder.tres")
	#area.add_child(select_shape)
	#area.input_ray_pickable = true
	##area.input_event.connect(_on_area_3d_input_event) # hook up event listener
	#add_child(area)
	##print_debug("added area")
	
	self.input_event.connect(_on_input_event)
	
	var collidable = CollisionShape3D.new()
	collidable.shape = load("res://assets/collision_shapes/Hex_outer_cylinder.tres")
	self.add_child(collidable)
	#print_debug("added collidable")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# update position with constant_linear_velocity
	self.position += delta * self.constant_linear_velocity
	
	# constrain vertical movement
	if(self.position.y > 1):
		self.position.y = 1
		self.constant_linear_velocity.y = 0
	elif(self.position.y < 0):
		self.position.y = 0
		self.constant_linear_velocity.y = 0



func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if(event is InputEventMouseButton):
		if(event.button_index == MOUSE_BUTTON_LEFT and event.pressed == true):
			#print_debug("clicked")
			if(constant_linear_velocity.y<=0 and self.position.y<1):
				self.constant_linear_velocity.y = 0.5
			else:
				self.constant_linear_velocity.y = -0.5

			
	pass # Replace with function body.
