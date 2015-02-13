#
# Deploy library to weblogic
#

action :deploy do
  template "#{node[:weblogic][:tmp_path]}/deploy_#{node[:weblogic][:lib][:name]}_lib.py" do
    source "wlst/deploy_lib.py.erb"
    owner new_resource.owner
    group new_resource.group
    mode "0640"
  end

  wlst_script "Deploy #{node[:weblogic][:lib][:name]} library" do
    script "#{node[:weblogic][:tmp_path]}/deploy_#{node[:weblogic][:lib][:name]}_lib.py"
    log "/tmp/deploy_#{node[:weblogic][:lib][:name]}.log"
  end
end
