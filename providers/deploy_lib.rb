#
# Deploy library to weblogic
#

action :deploy do
  template "#{node[:weblogic][:tmp_path]}/deploy_#{new_resource.name}_lib.py" do
    source "wlst/deploy_lib.py.erb"
    owner new_resource.owner
    group new_resource.group
    mode "0640"
    variables({
      :ctx => new_resource.settings
    })
  end

  wlst_script "Deploy #{new_resource.name} library" do
    script "#{node[:weblogic][:tmp_path]}/deploy_#{new_resource.name}_lib.py"
    log "/tmp/deploy_#{new_resource.name}.log"
  end
end
