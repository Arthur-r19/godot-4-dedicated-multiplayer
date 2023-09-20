extends TextureButton


@export var fullscreen_on_icon: Texture2D
@export var fullscreen_off_icon: Texture2D

func _ready():
	set_button_texture()

func _on_pressed():
	GameSettings.fullscreen = !GameSettings.fullscreen
	set_button_texture()

func set_button_texture():
	if GameSettings.fullscreen:
		texture_normal = fullscreen_off_icon
	else:
		texture_normal = fullscreen_on_icon
