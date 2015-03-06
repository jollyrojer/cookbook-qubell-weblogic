#
# Setup coherence cluster
#
require 'resolv'
weblogic_manage_coh_cluster node[:weblogic][:coh_cluster][:name] do

  servers = Array(node[:weblogic][:server][:name]).map { |x| x.split(':')[0] }
  coh_servers = []
  Array(node[:weblogic][:coh_server][:name]).each do |coh|
    name, port = coh.split(":", 2)
    ip = Resolv.getaddress(name)
    h = { :coh_ip => ip, :coh_port => port, :coh_name => name }
    coh_servers << h
  end

  case node[:platform_family]
    when "windows"
      owner node[:curent_user]
      group node[:curent_user]
    when "rhel", "debian"
      owner "root"
      group "root"
  end
  settings({
    :coh_cluster_name => node[:weblogic][:coh_cluster][:name],
    :coh_cluster_unicast_port_autoadjust => node[:weblogic][:coh_cluster][:unicast_port_autoadjust],
    :server_name => servers,
    :wka_list => coh_servers
  })
end
