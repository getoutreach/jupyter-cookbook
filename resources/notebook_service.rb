property :username, String, default: 'jupyter'
property :groupname, String, default: 'jupyter'
property :service_name, String, name_property: true
property :working_dir, String, default: ''

action :create do
  group new_resource.groupname do
    system true
  end

  if new_resource.working_dir.empty?
    working_dir = "/home/#{new_resource.username}/notebooks"
  else
    working_dir = new_resource.working_dir
  end

  user new_resource.username do
    group new_resource.groupname
    home "/home/#{new_resource.username}"
    manage_home true
    system true
    shell '/bin/bash'
  end

  directory '/usr/lib/systemd/system/' do
    owner 'root'
    group 'root'
  end

  directory working_dir do
    group new_resource.groupname
    owner new_resource.username
  end

  template "/usr/lib/systemd/system/#{new_resource.service_name}.service" do
    source 'jupyter.service.erb'
    variables(
      service_name: new_resource.service_name,
      user: new_resource.username,
      group: new_resource.groupname,
      working_dir: working_dir,
    )
    owner 'root'
    group 'root'
    mode '0644'
    action :create
  end
end
[:enable, :start].each do |proxy_action|
  action proxy_action do
    service new_resource.service_name do
      action [:enable, :start]
    end
  end
end
