class NodeTest
  require "yaml"
  require "test/unit/assertions"
  include Test::Unit::Assertions
  def run (node)
    nodes_info = YAML.load_file(node[:test][:yaml])
    info = nodes_info[ node[:hostname] ]

    assert info, "host is defined in nodes.yaml"

    Chef::Log::info "\n\n=== Chef Server Settings Check Test Start =========="


    ### CPU Check
    assert_equal node[:cpu][:total], info["cpu"], "Number of CPU"
    Chef::Log::info "CPU: #{info["cpu"]}  ... OK"


    ### Memory Size Check
    memory_diff = node[:memory][:total].to_i / (info["memory"] * 1024 * 1024).to_f
    if 0.9 <= memory_diff and 1.1 >= memory_diff
      Chef::Log::info "Memory: #{node[:memory][:total]}  ... OK"
    else 
      abort("memory size so Baaaaaaaaaaaaaaaaaaaaaat!!!!")
    end


    ### Disk Size Check and Mount Point Check
    info["disk"].each do |disk_one| 

      disk_name  = disk_one["name"] 
      disk_size  = disk_one["size"] 
      disk_mount = disk_one["mount"] 

      if node[:filesystem].key?("#{disk_name}") 
        disk_size_diff = (node[:filesystem]["#{disk_name}"][:kb_size].to_f / (disk_size * 1024 * 1024)).to_f 
        if 0.9 <= disk_size_diff and 1.1 >= disk_size_diff 
          Chef::Log::info "Disk size : #{node[:filesystem]["#{disk_name}"][:kb_size]}  ... OK" 
        else 
          abort("Disk  size so Baaaaaaaaaaaaaaaaaaaaaat!!!!") 
        end 
      end 

      assert_equal disk_mount, node[:filesystem]["#{disk_name}"][:mount], "mount point error" 
      Chef::Log::info "mount #{disk_mount}: #{node[:filesystem]["#{disk_name}"][:mount]} ... OK" 
    end 


    ### Network Check
    info["network"].each do |nic, addr|
      device = node[:network][:interfaces][nic.to_sym]
      assert device, "#{nic} device exists"
      Chef::Log::info "#{nic}: exists  ... OK"

      assert device[:addresses][addr], "#{nic}: #{addr}"
      Chef::Log::info "#{nic}: #{addr}  ... OK"
    end


    ### Ping Check
    unless info["ping"].nil? 
      if `ping -c 1 #{info["ping"]}` =~ /rtt/
        Chef::Log::info "ping : #{info["ping"]} ... OK"
      else 
        abort("ping not ok")
      end
    end


    Chef::Log::info "\n=== Chef Server Settings Check Test Done ==========\n"
  end
end

NodeTest.new.run(node)
