extends RigidBody

export var speed = 2
var dir = get_transform().basis.y

var timer = null
var flapDelay = 0.5
var canFlap = true

func get_input(delta):
	##velocity = Vector3.ZERO
	if (Input.is_action_pressed("ui_accept") && canFlap):
		dir = get_transform().basis.y * 400
		add_central_force(dir)
		canFlap = false
		timer.start()
	if Input.is_action_pressed("ui_right"):
		add_torque(Vector3(0,0,-10))
	if Input.is_action_pressed("ui_left"):
		add_torque(Vector3(0,0,10))

# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_axis_lock(PhysicsServer.BODY_AXIS_LINEAR_Z, true)
	self.set_axis_lock(PhysicsServer.BODY_AXIS_ANGULAR_X, true)
	self.set_axis_lock(PhysicsServer.BODY_AXIS_ANGULAR_Y, true)
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(flapDelay)
	timer.connect('timeout',self,"on_timer_complete")
	add_child(timer)
func on_timer_complete():
	canFlap = true

func _process(delta):
	#velocity += gravity * delta
	get_input(delta)
	
	
