extends CanvasLayer

func _ready():
	Main.connect("finished_game", self, "_on_finished_game")
	
func _on_StartButton_pressed():
	$BackgroundColorRect.hide()
	$StartButton.hide()
	$Header.hide()
	
func _on_finished_game():
	$BackgroundColorRect.show()
	$StartButton.show()
	$Header.show()
