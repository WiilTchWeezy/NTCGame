extends Area2D

func _on_BtnTryAgain_input_event( viewport, event, shape_idx ):
	if (event.type == InputEvent.SCREEN_TOUCH and event.pressed):
		Transition.fade_to("res://Scenes/Main.tscn")
