extends Node2D
var pressed = false
@export var output : Vector2
@export var deadzone = 5
@export var range = 70


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var screen_size = get_viewport_rect().size
	self.global_position = screen_size - Vector2(120,120)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(self.pressed):
		var dx = get_global_mouse_position() - self.global_position
		var l = dx.length()
		if(l>self.range):
			dx = dx * (self.range / l)
		$Knob.global_position = self.global_position + dx
		
		if(l>self.deadzone):
			self.output =  dx * (1-(self.deadzone/l))
			self.output = self.output.normalized()
			self.output.y = -self.output.y # flip y value so top is positive
		else:
			self.output = Vector2(0,0)
		
	else:
		$Knob.global_position = lerp($Knob.global_position, self.global_position, delta*10)
		self.output = Vector2(0,0)


func _on_button_button_down() -> void:
	self.pressed = true


func _on_button_button_up() -> void:
	self.pressed = false
