Dir[Rails.root.join('lib', 'vendor', '*')].each do |plugin|

  lib = File.join(plugin, 'lib')
  $LOAD_PATH.unshift lib
  print "Loading Vendor: #{File.basename(plugin)} ...."

  require File.join(plugin, 'init.rb')

  print " done.\n"

end
