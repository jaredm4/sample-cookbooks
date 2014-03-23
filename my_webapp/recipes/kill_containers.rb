
# Stop and remove all containers
script "kill_all_containers" do
  interpreter "ruby"
  user "root"
  code <<-EOH
    `docker ps -q`.split("\n").each do |container_id|
      `docker stop \#{container_id}`
    end
    # In the event of a crashed container, this will clean them up as well
    `docker ps -a -q`.split("\n").each do |container_id|
      `docker rm \#{container_id}`
    end
  EOH
end
