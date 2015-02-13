#
# Create Coherence servers Well Known Addresses file
#
template "#{node[:weblogic][:bea_home]}/wka.xml" do
  source "wka.xml.erb"
  case node[:platform_family]
    when "windows"
      owner node[:current_user]
      group node[:current_user]
    when "rhel", "debian"
      owner "root"
      group "root"
  end
  mode "0640"
  variables({
    :coh_server => Array(node[:weblogic][:coh_server][:unicast_address]),
    :coh_server_port => node[:weblogic][:coh_server][:unicast_port]
  })
end
