require "xmlrpc/client"
require "open-uri"

# Make an object to represent the XML-RPC server.
server = XMLRPC::Client.new( "127.0.0.1", '/', 20100)

# Call the remote server and get our result
cpu = server.call("system_server_info.cpu_info")

puts cpu['cpu_avr'][0]
puts cpu['cpu_processors'].inspect


filesystem = server.call("system_server_info.filesystem_info")

puts filesystem['filesystem'].inspect

uptime = server.call("system_server_info.uptime_info")

puts uptime.inspect

memory_info = server.call("system_server_info.mem_info")

puts memory_info.inspect

process_info = server.call("system_server_info.processes_info")

puts process_info.inspect

start_time = Time.now.utc
res = server.call("system_server_info.link_time", start_time)
end_time = Time.now.utc
puts (end_time - start_time).to_s



#data
puts ""
puts "Http data ======= "
puts ""

data = nil
start_time = Time.now.utc
open("http://dailydeal.coupons.com/", "User-Agent" => "Leopard Ruby Bot/#{RUBY_VERSION}") do |f|
   data = f.read
   
   end_time = Time.now.utc
   puts (end_time - start_time).to_s
   
   puts f.base_uri
   puts f.content_type
   puts f.charset
   puts f.content_encoding
   puts f.last_modified
end

puts "Size: #{data.size}"

