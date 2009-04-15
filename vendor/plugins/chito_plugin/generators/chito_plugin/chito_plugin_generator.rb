class ChitoPluginGenerator < Rails::Generator::NamedBase 
  def manifest 
    record do |m|
      basedir = "vendor/plugins/chito_plugins/#{file_name}"
      m.directory "#{basedir}/app" 
      m.directory "#{basedir}/app/views" 
      m.directory "#{basedir}/lib" 
      m.directory "#{basedir}/locale" 
      m.directory "#{basedir}/tasks" 
      m.directory "#{basedir}/test"
      m.directory "#{basedir}/public"
      m.directory "#{basedir}/public/images"
      m.directory "#{basedir}/public/stylesheets"
      m.directory "#{basedir}/public/javascripts"

      m.template "app/views/_config.html.erb", "#{basedir}/app/views/_config.html.erb"
      m.template "lib/plugin_code.rb", "#{basedir}/lib/#{file_name}.rb"
      m.template "locale/locales.yml", "#{basedir}/locale/locales.yml"
      m.template "tasks/plugin_tasks.rake", "#{basedir}/tasks/#{file_name}_tasks.rake"
      m.template "test/plugin_test.rb", "#{basedir}/test/#{file_name}_test.rb"
      m.template "init.rb", "#{basedir}/init.rb"
      m.template "install.rb", "#{basedir}/install.rb"
      m.template "Rakefile", "#{basedir}/Rakefile"
      m.template "init.rb", "#{basedir}/init.rb"
      m.template "readme", "#{basedir}/readme"
      m.template "uninstall.rb", "#{basedir}/uninstall.rb"
	
    end 
  end
end
