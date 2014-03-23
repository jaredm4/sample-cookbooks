# Should be set via custom JSON (parameter bags), or supplied during a recipe run.
# Make sure the key ("app1") is unique from the image_name. Docker doesn't like containers and images with the same name.
default[:my_apps] = [
  # 'app1' => 'image_name:image_tag'
]
# This should be the image name of your Nginx
default[:my_nginx] = ''
