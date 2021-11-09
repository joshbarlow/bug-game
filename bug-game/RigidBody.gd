extends RigidBody

export var speed = 2
var dir = get_transform().basis.y

var timer = null
var timer2 = null
var flapDelay = 0.2
var canFlap = true

func get_input(delta):
	##velocity = Vector3.ZERO
	if (Input.is_action_pressed("ui_accept") && canFlap):
		#dir = get_transform().basis.y * 400
		#add_central_force(dir)
		canFlap = false
		get_node("butterfly_anim/AnimationPlayer").play("Animation")
		timer.start()
	if Input.is_action_pressed("ui_right"):
		add_torque(Vector3(0,0,-4))
	if Input.is_action_pressed("ui_left"):
		add_torque(Vector3(0,0,4))

# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_axis_lock(PhysicsServer.BODY_AXIS_LINEAR_Z, true)
	self.set_axis_lock(PhysicsServer.BODY_AXIS_ANGULAR_X, true)
	self.set_axis_lock(PhysicsServer.BODY_AXIS_ANGULAR_Y, true)
	self.set_angular_damp(1)
	self.set_contact_monitor(true)
	self.set_max_contacts_reported(1)
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(flapDelay)
	timer.connect('timeout',self,"on_timer_complete")
	add_child(timer)
	timer2 = Timer.new()
	timer2.set_one_shot(true)
	timer2.set_wait_time(0.3)
	timer2.connect('timeout',self,"on_timer_2_complete")
	add_child(timer2)
	
func on_timer_complete():
	dir = get_transform().basis.y * 400
	add_central_force(dir)
	timer2.start()
	#canFlap = true

func on_timer_2_complete():
	canFlap = true

func checkUpsideDown():
	if (self.transform.basis.y.y < -0.75 && self.get_colliding_bodies()):
		get_tree().reload_current_scene()
	
func _process(delta):
	#velocity += gravity * delta
	get_input(delta)
	checkUpsideDown()
	
	
