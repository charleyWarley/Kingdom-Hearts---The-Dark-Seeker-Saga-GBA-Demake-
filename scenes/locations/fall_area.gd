extends Area2D



func _on_body_entered(body):
	if body.name == "sora":
		body.is_grounded = false
		body.is_falling = true
		body.ground_position = body.position.y + (get_parent().ledge_height * 16)
