
# Pull each of our defined apps
node[:my_apps].each do |name, image|
  script "pull_app_#{name}_image" do
    interpreter "bash"
    user "root"
    code <<-EOH
      docker pull #{image}
    EOH
  end
end

# Pull latest Nginx
script "pull_nginx_image" do
  interpreter "bash"
  user "root"
  code <<-EOH
    docker pull #{node[:my_nginx]}
  EOH
end
