module Prake
   
   class Application
     
     def self.init
       application = self.new
       application.run
     end 
     
     def initialize
       @pid = Process.pid  
       @pwd = Dir.pwd
       
     end 
     
     def pid_file_path
      "#{@pwd}/rake_pids/#{@pid}.pid"  
     end
     
     def run
       drop_pid
       puts "Starting rake process with process id #{@pid}:"
     end
     
     def drop_pid
       File.open(pid_file_path,'w') do |file|
         file.write(@pid)
       end
     end
     
     def clear_pid
       FileUtils.rm(pid_file_path)
     end
   end
   
end