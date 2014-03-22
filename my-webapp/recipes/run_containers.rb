
# Run each app. We don't expose any ports since Nginx will handle all incoming traffic as a proxy
node[:my_apps].each do |name, image|
  script "run_app_#{name}_container" do
    interpreter "bash"
    user "root"
    code <<-EOH
      docker run -d --name=#{name} #{image}
    EOH
  end
end

# Run Nginx, linking it to all the other Apache containers, and expose its port.
script "run_nginx_container" do
  links = ''
  node[:my_apps].keys.each do |name|
    # prefixed with "app_" here for ease of discovery
    # see: http://jaredmarkell.com/nginx-proxy-through-linked-docker-containers/
    links += " --link=#{name}:app_#{name}"
  end
  interpreter "bash"
  user "root"
  code <<-EOH
    docker run -d -p 80:80 --name=nginx #{links} #{node[:my_nginx]}
  EOH
end
