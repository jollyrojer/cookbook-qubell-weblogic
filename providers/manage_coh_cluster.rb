#
# Creates Coherence cluster
#

#
#Creates coherence cluster
#

action :create do
  template "#{node[:weblogic][:tmp_path]}/create_#{new_resource.name}_coh_cluster.py" do
    source "wlst/create_coh_cluster.py.erb"
    owner new_resource.owner
    group new_resource.group
    mode "0640"
    variables({
      :ctx => new_resource.settings
    })
  end

  wlst_script "Creating #{new_resource.name} coherence cluster" do
    script "#{node[:weblogic][:tmp_path]}/create_#{new_resource.name}_coh_cluster.py"
    log "/tmp/create_#{new_resource.name}.log"
  end
end
