extends Camera3D
@export var velocity = Vector3()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var accel = Input.get_accelerometer()
	accel -= Input.get_gravity()
	var gyro = Input.get_gyroscope()
	
	var HUD_text_box = $"../HUD/DubugText"
	var vp = get_viewport().size
	HUD_text_box.size.x = vp.x
	HUD_text_box.position.x = max(5, vp.x*0.05)
	HUD_text_box.position.y = vp.y - 5 - HUD_text_box.size.y
	HUD_text_box.text=""
	HUD_text_box.push_font_size(32)
	HUD_text_box.append_text("accel: \t[color=red]x[/color] = %5.2f \t[color=green]x[/color] = %5.2f \t[color=blue]x[/color] = %5.2f\n" % [accel.x, accel.y, accel.z])
	HUD_text_box.append_text("gyro:  \t[color=red]x[/color] = %5.2f \t[color=green]x[/color] = %5.2f \t[color=blue]x[/color] = %5.2f\n" % [gyro.x, gyro.y, gyro.z])
	HUD_text_box.append_text("vel:     \t[color=red]x[/color] = %5.2f \t[color=green]x[/color] = %5.2f \t[color=blue]x[/color] = %5.2f" % [self.velocity.x, self.velocity.y, self.velocity.z])
	HUD_text_box.pop()
	
	
	
	var old_basis = self.transform.basis
	var rotate = Basis()
	rotate = rotate.rotated(old_basis.x, gyro.x * delta)
	rotate = rotate.rotated(old_basis.y, gyro.y * delta)
	rotate = rotate.rotated(old_basis.z, gyro.z * delta)
	self.transform.basis = rotate*old_basis

	#self.velocity += old_basis.x * accel.x * delta *1
	#self.velocity += old_basis.y * accel.y * delta *1
	#self.velocity += old_basis.z * accel.z * delta *1
	#
	#self.position += self.velocity * delta
	
	
