desc "Update pot/po files."
task :updatepo do
  require 'gettext/utils'
  GetText.update_pofiles("chito", Dir.glob("{app,lib,bin,themes}/**/*.{rb,rhtml,erb}"), "Chito 1.0.0")
end

desc "Create mo-files"
task :makemo do
  require 'gettext/utils'
  GetText.create_mofiles(true, "po", "locale")
end
