# encoding: utf-8
namespace :chito do
  desc "Copy user themes file to public"
  task :copy_user_themes => :environment do
      puts "Copy UserThemes(#{UserTheme::PATH}) to /public:\n"
      UserTheme::LIST.each do |t|
        print "    Copying #{t}... "
        UserTheme.copy_to_public(t)
        print "done.\n"
      end
  end

  desc "Copy index themes file to public"
  task :copy_index_themes => :environment do
      puts "Copy IndexThemes(#{IndexTheme::PATH}) to /public:\n"
      IndexTheme::LIST.each do |t|
        print "    Copying #{t}... "
        UserTheme.copy_to_public(t)
        print "done.\n"
      end
  end

  desc "Copy plugins file to public"
  task :copy_plugin_files => :environment do
      puts "Copy PluginFiles(#{ChitoPlugin::PLUGIN_PATH}) to /public:\n"
      ChitoPlugin.plugins.each do |p|
        print "    Copying #{p.id}... "
        ChitoPlugin.copy_to_public(p.id)
        print "done.\n"
      end
  end

  desc "Setup Chito config files and copy cache files of themes and plugins"
  task :setup => [:copy_user_themes, :copy_index_themes, :copy_plugin_files] do
      puts "All done :).\n"
  end

end
