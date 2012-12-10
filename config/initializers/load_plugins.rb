chito_lib_dir = Rails.root.join('lib', 'chito')
lib = File.join(chito_lib_dir, 'lib')
$LOAD_PATH.unshift lib
print "Loading Chito libs in [#{chito_lib_dir}] ...."
require File.join(chito_lib_dir, 'init.rb')
print " done.\n"

Dir[Rails.root.join('plugins','*')].each do |plugin|

  lib = File.join(plugin, 'lib')
  $LOAD_PATH.unshift lib
  print "Loading Plugin: #{File.basename(plugin)} ...."

  require File.join(plugin, 'init.rb')

  print " done.\n"

end
