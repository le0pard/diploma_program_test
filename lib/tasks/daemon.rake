require "#{RAILS_ROOT}/lib/client/main"
namespace :daemon do
  desc "Start daemon for web task"
  task :start => :environment do
    # Make an object to represent the XML-RPC server.
    server = XMLRPC::Client.new( "127.0.0.1", '/', 20100)
    
    WebTest.waiting.all.each do |web_test|
      
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
      
      
      require 'net/http'
      require 'net/https'
      
      http = Net::HTTP.new('dailydeal.coupons.com', 80)
      http.use_ssl = false
      path = '/'
      
      # GET request -> so the host can set his cookies
      resp, data = http.get(path, nil)
      puts data
      cookie = resp.response['set-cookie']
      
      
      # POST request -> logging in
      data = 'serwis=wp.pl&url=profil.html&tryLogin=1&countTest=1&logowaniessl=1&login_username=blah&login_password=blah'
      headers = {
        'Cookie' => cookie,
        'Referer' => 'http://profil.wp.pl/login.html',
        'Content-Type' => 'application/x-www-form-urlencoded'
      }
      
      resp, data = http.post(path, data, headers)
      
      
      # Output on the screen -> we should get either a 302 redirect (after a successful login) or an error page
      puts 'Code = ' + resp.code
      puts 'Message = ' + resp.message
      resp.each {|key, val| puts key + ' = ' + val}
      puts data


      
    end
    
  end

end