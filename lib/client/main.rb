require "xmlrpc/client"
require "open-uri"
require "net/http"
require "net/https"

def get_time_investigate(url, params)
  result = nil
  url += "?" + params if params
  start_time = Time.now.utc
  open(url, "User-Agent" => "Leopard Ruby Bot/#{RUBY_VERSION}") do |f|
     data = f.read
     end_time = Time.now.utc
     result = (end_time - start_time)
 end
 return result
end

def post_time_investigate(url, params)
  result = nil
  uri = URI.parse(url.to_s)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true if uri.scheme == "https"
  path = uri.request_uri
  headers = {
    'Referer' => url,
    'Content-Type' => 'application/x-www-form-urlencoded'
  }
  start_time = Time.now.utc
  resp, data = http.post(path, params, headers)
  end_time = Time.now.utc
  result = (end_time - start_time)
  return result
end

def get_information_by_server(server)
  prms = {}
  #line load
  start_time = Time.now.utc
  res = server.call("system_server_info.link_time", start_time)
  end_time = Time.now.utc
  prms[:web_load_time] = (end_time - start_time)
  # cpu
  cpu = server.call("system_server_info.cpu_info")
  prms[:cpu_avr1] = cpu['cpu_avr'][0]
  prms[:cpu_avr5] = cpu['cpu_avr'][1]
  prms[:cpu_avr15] = cpu['cpu_avr'][2]
  # uptime
  #uptime = server.call("system_server_info.uptime_info")
  # memory
  memory_info = server.call("system_server_info.mem_info")
  prms[:mem_total] = memory_info['total']
  prms[:mem_used] = memory_info['used']
  prms[:mem_free] = memory_info['free']
  prms[:swap_total] = memory_info['swap_total']
  prms[:swap_used] = memory_info['swap_used']
  prms[:swap_free] = memory_info['swap_free']
  # process info
  process_info = server.call("system_server_info.processes_info")
  prms[:process_all] = process_info['all']
  prms[:process_running] = process_info['running']
  
  prms[:server_load_time] = (Time.now.utc - start_time)
  prms[:time_of_test] = Time.now
  prms 
rescue
  puts "Error: Please, check if server is run on right IP and port!"
  nil
end