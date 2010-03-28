#!/usr/bin/ruby
require "xmlrpc/server"

require "rubygems"
require "sys/cpu"
require 'sys/uptime'
require 'sys/filesystem'
require "json"


puts "log: starting connection"

s = XMLRPC::Server.new(20100)

class SystemHandler
  def cpu_info
        processors = {}
      	Sys::CPU.processors{ |cs|
      	 cs.members.each{ |m|
      	   processors[m] = cs[m].to_s
      	 }
      	}

    { 'cpu_avr' => Sys::CPU.load_avg, 'cpu_stats' => Sys::CPU.cpu_stats, 'cpu_processors' => processors }
  end
  
  def filesystem_info
    { 'filesystem' => Sys::Filesystem.stat("/").inspect.to_s }
  end
  
  def uptime_info
    {'boot_time' => Sys::Uptime.boot_time, 'uptime' => Sys::Uptime.uptime, 'seconds' => Sys::Uptime.seconds}
  end
  
  def mem_info
    mem = %x[free -m]

    memory_array = []
    mem_array_str = mem.to_s.split("\n")
    mem_array_str.each do |str|
      temp_data = str.split(" ")
      if temp_data
        temp_data.each do |data|
          memory_array << data
        end
      end
    end
    
    unless memory_array.empty?
      result_hash = {}
      result_hash[memory_array[0]] = memory_array[7] if memory_array[0] && memory_array[7]
      result_hash[memory_array[1]] = memory_array[8] if memory_array[1] && memory_array[8]
      result_hash[memory_array[2]] = memory_array[9] if memory_array[2] && memory_array[9]
      result_hash[memory_array[3]] = memory_array[10] if memory_array[3] && memory_array[10]
      result_hash[memory_array[4]] = memory_array[11] if memory_array[4] && memory_array[11]
      result_hash[memory_array[5]] = memory_array[12] if memory_array[5] && memory_array[12]
      
      result_hash["swap_#{memory_array[0]}"] = memory_array[18] if memory_array[0] && memory_array[18]
      result_hash["swap_#{memory_array[1]}"] = memory_array[19] if memory_array[1] && memory_array[19]
      result_hash["swap_#{memory_array[2]}"] = memory_array[20] if memory_array[2] && memory_array[20]
    end
    
    result_hash
  end
  
  def processes_info
    count_of_running_process = %x[ps | wc -l]
    count_of_all_process = %x[ps auxh | wc -l]
    {'all' => count_of_all_process.to_i, 'running' => count_of_running_process.to_i}
  end
  
  def link_time(time)
    time
  end
end

s.add_handler("system_server_info", SystemHandler.new)
s.serve