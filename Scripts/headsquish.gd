extends Area2D

class_name Headsquish

func _on_body_entered(body: Node2D) -> void:
	body.jump(1)
	get_parent().queue_free()
