Dir[Rails.root.join('lib', 'vendor', '*')].each do |plugin|

  lib = File.join(plugin, 'lib')
  $LOAD_PATH.unshift lib
  puts lib

  require File.join(plugin, 'init.rb')

end
