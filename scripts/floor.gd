extends ParallaxBackground

var scrolling_speed = 100

func _process(delta):
	scroll_base_offset.x -= scrolling_speed * delta

func stop():
	scrolling_speed = 0
