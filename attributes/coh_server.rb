default[:weblogic][:coh_server][:name] = "CohServer-0"
default[:weblogic][:coh_server][:unicast_address] = "localhost"
default[:weblogic][:coh_server][:unicast_port] = "8888"
default[:weblogic][:coh_server][:unicast_port_autoadjust] = "true"
default[:weblogic][:coh_server][:classpath] = ["coherence_3.7/lib/coherence.jar","coherence_3.7/lib/coherence-web.jar","modules/features/weblogic.server.modules.coherence.server_10.3.5.0.jar"]
default[:weblogic][:coh_server][:arguments] = ["-Dtangosol.coherence.session.localstorage=true","-Dtangosol.coherence.distributed.localstorage=true","-Dtangosol.coherence.cluster=#{node[:weblogic][:coh_cluster][:name]}","-Dtangosol.coherence.override=#{node[:weblogic][:bea_home]}/wka.xml","-Dtangosol.coherence.cacheconfig=session-cache-config.xml"]
