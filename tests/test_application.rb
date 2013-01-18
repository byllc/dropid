require "minitest/autorun"
require_relative "../lib/dropid/application"

class TestApplication < MiniTest::Unit::TestCase
   def setup
     @pid_file_name      = "test_pid_file"
     @pid_file_directory = "pids"
     @pid_file_path      = "#{@pid_file_directory}/#{@pid_file_name}.pid"
     
     @application = Dropid::Application.new
     @application.pid_file_directory = @pid_file_directory
     @application.pid_file_name      = @pid_file_name
   end
   
   def test_pid_name_is_set
     @application.drop_pid
     assert_equal @pid_file_name, @application.pid_file_name
     @application.clear_pid
   end
   
   def test_pid_directory_is_set
     @application.drop_pid
     assert_equal @pid_file_directory, @application.pid_file_directory
     @application.clear_pid
   end
   
   def test_that_pid_exists
     @application.drop_pid
     assert File.file?(@pid_file_path), "Pid file is not created properly"
     @application.clear_pid 
   end
   
   def test_that_pid_can_be_effectively_cleared
     @application.drop_pid #other tests must assert this is functioning
     @application.clear_pid
     assert_equal File.file?(@pid_file_path),false
   end
   
end