#
# Recipe for deployment libraries to targets
#

require 'uri'
lib = node[:weblogic][:lib][:path]
uri = URI.parse(lib)
file_name = File.basename(uri.path)
ext_name = File.extname(file_name)
target_file = "/tmp/#{file_name}"
  
#support only jar 
if ( ! %w{.jar .war}.include?(ext_name))
  fail "not supported"
end
  
# download libs
if ( lib.start_with?('http','ftp'))
  remote_file target_file do
    source lib
  end
elsif ( lib.start_with?('file'))
  target_file = URI.parse(lib).path 
else
  fail "not supported URI"
end
  
file_name = File.basename(target_file)

weblogic_deploy_lib "#{file_name}" do
  targets = Array(node[:weblogic][:lib][:target]).map { |x| x.split(':')[0] } 
  case node[:platform_family]
  when "windows"
    owner node[:curent_user]
    group node[:curent_user]
  when "rhel", "debian"
    owner "root"
    group "root"
  end
  settings({
    :lib_name => node[:weblogic][:lib][:name],
    :lib_source => target_file,
    :wl_target => Array(targets).join(','),
    :is_module => node[:weblogic][:lib][:is_module]
  }) 
end
