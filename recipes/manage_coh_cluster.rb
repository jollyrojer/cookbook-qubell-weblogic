#
# Setup coherence cluster
#
weblogic_manage_coh_cluster [:weblogic][:coh_cluster][:name] do

  Array(node[:weblogic][:server][:name]).each do | servername|
    server_name = server.split(':')
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
    :coh_cluster_unicast_address => node[:weblogic][:coh_cluster][:unicast_address],
    :coh_cluster_unicast_port => node[:weblogic][:coh_cluster][:unicast_port],
    :server_name => server_name 
  })
end
