extends ParallaxBackground

var scrolling_speed = 10

func _process(delta):
	scroll_base_offset.x -= scrolling_speed * delta

