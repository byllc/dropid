module Dropid
   
   class Application
     
     #the location of the pid files to monitor, more than one process may share this path
     attr_accessor :pid_file_path
     
     #the name of the process_id file
     attr_accessor :pid_file_name
     
     #the directory from which the process was started
     attr_accessor :pwd
     
     #the current process id
     attr_accessor :pid
     
     
     def self.init(&:block)
       application = self.new
       
       #initialize any application parameters
       block.call(application) if block.given?
       
       application.pid_file_path ||= "#{application.pwd}/pids/#{application.pid}.pid" 
       application.process_name  ||= application.pid
       application.run
     end 
     
     def initialize
       @pid = Process.pid  
       @pwd = Dir.pwd
     end 
     
     #Drop the pid and set up the exit task
     def run
       drop_the_pid
       puts "Starting rake process with process id #{@pid}:"
       
       at_exit do 
         clear_pid
       end
     end
     
     def drop_the_pid
       File.open(pid_file_path,'w') do |file|
         file.write(@pid)
       end
     end
     
     def clear_pid
       FileUtils.rm(pid_file_path)
     end
   end
   
end