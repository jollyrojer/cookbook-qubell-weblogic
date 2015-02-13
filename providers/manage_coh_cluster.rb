#
# Creates Coherence cluster
#

action :create do
  template "#{node[:weblogic][:tmp_path]}/create_#{node[:weblogic][:coh_cluster][:name]}_coh_cluster.py" do
    source "wlst/create_coh_cluster.py.erb"
    owner new_resource.owner
    group new_resource.group
    mode "0640"
  end

  wlst_script "Creating #{node[:weblogic][:coh_cluster][:name]} coherence cluster" do
    script "#{node[:weblogic][:tmp_path]}/create_#{node[:weblogic][:coh_cluster][:name]}_coh_cluster.py"
    log "/tmp/create_#{node[:weblogic][:coh_cluster][:name]}.log"
  end
end
