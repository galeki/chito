class ChitoPluginGenerator < Rails::Generators::Base 
  source_root File.expand_path('../templates', __FILE__)
  argument :plugin_name, :type => :string

  def manifest 
    basedir = "plugins/#{file_name}"

    template "app/views/_config.html.erb", "#{basedir}/app/views/_config.html.erb"
    template "lib/plugin_code.rb", "#{basedir}/lib/#{file_name}.rb"
    template "locale/locales.yml", "#{basedir}/locale/locales.yml"
    template "lib/tasks/plugin_tasks.rake", "#{basedir}/lib/tasks/#{file_name}_tasks.rake"
    template "test/plugin_test.rb", "#{basedir}/test/#{file_name}_test.rb"
    template "init.rb", "#{basedir}/init.rb"
    template "install.rb", "#{basedir}/install.rb"
    template "Rakefile", "#{basedir}/Rakefile"
    template "init.rb", "#{basedir}/init.rb"
    template "readme", "#{basedir}/readme"
    template "uninstall.rb", "#{basedir}/uninstall.rb"
  end

  private

  def file_name
    plugin_name.underscore
  end

  def class_name
    plugin_name.camelize
  end
end
