module Dropid
   require 'fileutils'
      
   class Application
     
     #the location of the pid files to monitor, more than one process may share this path
     attr_accessor :pid_file_directory
     
     #the name of the process_id file
     attr_accessor :pid_file_name
     
     #the directory from which the process was started
     attr_accessor :pwd
     
     #the current process id
     attr_accessor :pid
    
     #the assigned name for this process
     attr_accessor :process_name
     
     attr_accessor :verbose
     
     
     def initialize
       @pid = Process.pid  
       @pwd = Dir.pwd
       @verbose = false
     end
     
     def self.init(&block)
       application = self.new
       
       #initialize any application parameters
       block.call(application) if block_given?
       
       application.pid_file_path ||= "#{application.pwd}/pids/#{application.pid}.pid" 
       application.process_name  ||= "process_{application.pid}"
       application.run
       
       application
     end 
     
     def pid_file_path
       "#{@pid_file_directory}/#{@pid_file_name}.pid"
     end
     
     #make sure the pid and pid path exist
     def touch_pid
       FileUtils.mkdir_p pid_file_directory
       FileUtils.touch   pid_file_path
     end
     
     #Drop the pid and set up the exit task
     def run
       drop_pid
       
       puts "Starting rake process with process id #{@pid}:" if @verbose
       
       at_exit do 
         clear_pid
       end
     end
     
     def drop_pid
       touch_pid
       
       File.open(pid_file_path,"w") do |file|
         file.write(@pid)
       end
     end
     
     def clear_pid
       puts FileUtils.rm(pid_file_path)
     end
   end
   
end