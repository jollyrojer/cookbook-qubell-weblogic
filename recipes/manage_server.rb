#
# Setup weblogic server
#
require 'resolv'
Array(node[:weblogic][:server][:address]).each do |server|
  name, port = server.split(':')
  ip = Resolv.getaddress(name)
  

  weblogic_manage_server server do
    case node[:platform_family]
      when "windows"
        owner node[:curent_user]
        group node[:curent_user]
      when "rhel", "debian"
        owner "root"
        group "root"
    end
    settings({
      :server_name => server,
      :server_address => ip,
      :server_port => node[:weblogic][:server][:port],
      :server_port_enabled => node[:weblogic][:server][:port_enabled],
      :server_java_compiler => node[:weblogic][:server][:java_compiler],
      :server_proxy_enabled => node[:weblogic][:server][:proxy_enabled],
      :machine_name => name,
      :cluster_name => node[:weblogic][:cluster][:name],
      :server_is_ssl => node[:weblogic][:server][:is_ssl]
    })
  end
end
