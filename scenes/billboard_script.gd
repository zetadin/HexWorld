extends Sprite3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var lbl = $SubViewport/BillboardText
	lbl.text = ""
	lbl.append_text("[center]")
	lbl.push_color(Color("white"))
	lbl.append_text("This is a ")
	lbl.pop()
	lbl.push_color(Color("red"))
	lbl.push_bold()
	lbl.append_text("Billboard")
	lbl.pop_all()
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.transform
	pass
