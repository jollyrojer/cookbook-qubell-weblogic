#
# Resource for manage_coh_cluster.rb
#

actions :create
default_action :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :settings, :kind_of => Hash
attribute :owner, :kind_of => String
attribute :group, :kind_of => String
