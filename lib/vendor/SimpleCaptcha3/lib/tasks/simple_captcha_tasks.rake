# Copyright (c) 2008 [Sur http://expressica.com]

require 'fileutils'

namespace :simple_captcha do
  desc "Set up the plugin SimpleCaptcha"
  task :setup => :environment do
    SimpleCaptcha::SetupTasks.do_setup
  end
end
