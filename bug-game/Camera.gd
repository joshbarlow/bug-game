extends Camera

var mothNode

var camMult

# Called when the node enters the scene tree for the first time.
func _ready():
	mothNode = get_node("../ButterflyCharacter/Position3D").get_global_transform()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mothNode = get_node("../ButterflyCharacter/Position3D").get_global_transform()
	var camMult = (mothNode.origin * Vector3(0.6,1,1))
	if (camMult[1] > 42):
		camMult[1] = 42
	self.translation = (camMult) + Vector3(0,3,20)
	pass
