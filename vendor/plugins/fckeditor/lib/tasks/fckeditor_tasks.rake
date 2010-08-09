# desc "Explaining what the task does"
# task :fckeditor do
#   # Task goes here
# end

namespace :fckeditor do
  desc 'Install the FCKEditor components'
  task :install do
    require 'fileutils'
    
    directory = File.join(RAILS_ROOT, '/vendor/plugins/fckeditor/')
    require "#{directory}lib/fckeditor"
    require "#{directory}lib/fckeditor_version"
    require "#{directory}lib/fckeditor_file_utils"
      
    puts "** Installing FCKEditor Plugin version #{FckeditorVersion.current}..."           

    FckeditorFileUtils.destroy_and_install 
         
    puts "** Successfully installed FCKEditor Plugin version #{FckeditorVersion.current}"
  end

  desc "Update the FCKEditor plugin"    
  task :update do
    puts "Not yet implemented."
  end  
end

