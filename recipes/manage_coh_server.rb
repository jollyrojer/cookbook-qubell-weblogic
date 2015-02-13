#
# Setup coherence server
#
Array(node[:weblogic][:machine][:address]).each do |machine|
  name, port = machine.split(':')
  ip = Resolv.getaddress(name)

  coh_server_name = "coh_server_#{ip}"
  weblogic_manage_coh_server coh_server_name do
    case node[:platform_family]
      when "windows"
        owner node[:curent_user]
        group node[:curent_user]
      when "rhel", "debian"
        owner "root"
        group "root"
    end
    settings({
      :coh_server_name => coh_server_name,
      :machine_name => name,
      :coh_cluster_name => node[:weblogic][:coh_cluster][:name],
      :coh_server_unicast_address => ip,
      :coh_server_unicast_port => node[:weblogic][:coh_server][:unicast_port],
      :coh_server_unicast_port_autoadjust => node[:weblogic][:coh_server][:unicast_port_autoadjust],
      :coh_server_classpath => node[:weblogic][:coh_server][:classpath],
      :coh_server_arguments => node[:weblogic][:coh_server][:arguments]
    })
  end
end
