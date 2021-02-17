extends Node

var intro_music = load("res://Assets/Audio/escape_the_lab_intro.wav")
var theme_music = load("res://Assets/Audio/escape_the_lab_main_theme.wav")

func _ready():
	pass
	
func play_intro():
	$Music.stream = intro_music
	$Music.play()

func play_theme():
	$Music.stream = theme_music
	$Music.play()
