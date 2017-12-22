extends AnimatedSprite

var elapsedTime = 0

func _ready():
	set_process(true)
	pass

func _process(delta):
	elapsedTime +=  delta
	if(elapsedTime > 0.1):
		if(get_frame() == self.get_sprite_frames().get_frame_count( "default" ) - 1):
			set_frame(0)
		else:
			self.set_frame(get_frame() + 1)
	elapsedTime = 0