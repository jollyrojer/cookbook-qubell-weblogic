require 'resolv'
Array(node[:weblogic][:machine][:address]).each do |machine|
  name, port = machine.split(':')
  ip = Resolv.getaddress(name)

  weblogic_manage_machine name do
    case node[:platform_family]
      when "windows"
        owner node[:curent_user]
        group node[:curent_user]
      when "rhel", "debian"
        owner "root"
        group "root"
    end
    settings ({
      :machine_name => name,
      :machine_ip => ip,
      :machine_port => port
    })
  end
end
