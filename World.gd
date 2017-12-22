extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var _camera2D
var _isCameraUp
var _cameraTargetAngle
var _cameraAngleNormal
var _cameraAngleInversed
var _rigidBodies

var _gravityVector = Vector2(0,-1)

func _ready():
#	Init gravity
	Physics2DServer.area_set_param(get_world_2d().get_space() , Physics2DServer.AREA_PARAM_GRAVITY_VECTOR , _gravityVector)
#	get all rigid bodies in the group "rigid bodies"
	_rigidBodies = get_tree().get_nodes_in_group("RigidBodies")
	var temp = _rigidBodies[0]
	# Called every time the node is added to the scene.
	# Initialization here
	_camera2D = get_node("Camera2D")
	_isCameraUp = true;
	
	_cameraAngleNormal = _camera2D.get_rotd()
	_cameraAngleInversed = _camera2D.get_rotd() + 180
	_cameraTargetAngle = _cameraAngleNormal
	set_process(true)
	set_process_input(true)


func _process(delta):
	if ( _camera2D.get_rotd() < _cameraTargetAngle):
		_camera2D.set_rotd(_camera2D.get_rotd() + 5)
	if ( _camera2D.get_rotd() > _cameraTargetAngle):
		_camera2D.set_rotd(_camera2D.get_rotd() - 5)
	if ( _camera2D.get_rotd() < _cameraTargetAngle && _isCameraUp):
				_camera2D.set_rotd(0)
	if ( _camera2D.get_rotd() > _cameraTargetAngle && !_isCameraUp):
		_camera2D.set_rotd(180)


func _input(event):
	if  _camera2D.get_rotd() == _cameraAngleNormal || _camera2D.get_rotd() == _cameraAngleInversed:
		_rotate_camera(event)
	
	
func _rotate_camera(event):
#	set speed of all rigid bodies to 
	for rb in _rigidBodies:
		rb.set_linear_velocity( Vector2(0,0) )
	if event.is_action_pressed("rotate_camera"): 
		if _isCameraUp:	
			_cameraTargetAngle = _cameraAngleInversed
			_isCameraUp = !_isCameraUp
			_gravityVector = Vector2(0, 1)
		else:
			_cameraTargetAngle = _cameraAngleNormal
			_isCameraUp = !_isCameraUp
			_gravityVector = Vector2(0, -1)
		Physics2DServer.area_set_param(get_world_2d().get_space() , Physics2DServer.AREA_PARAM_GRAVITY_VECTOR , _gravityVector)
		
		
		