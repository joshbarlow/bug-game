extends Camera

var mothNode

# Called when the node enters the scene tree for the first time.
func _ready():
	mothNode = get_node("../ButterflyCharacter/Position3D").get_global_transform()
	print(mothNode)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mothNode = get_node("../ButterflyCharacter/Position3D").get_global_transform()
	self.translation = (mothNode.origin + Vector3(0,3,6))
	pass
