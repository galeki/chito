module LatexFormula

require "digest/sha1"
  PLUGIN_NAME = 'latex_formula'
  PLUGIN_PATH = "#{RAILS_ROOT}/vendor/plugins/#{PLUGIN_NAME}"
  PLUGIN_CONTROLLER_PATH = "#{PLUGIN_PATH}/app/controllers"  
end

class LatexFormulaToPng
    def initialize(latex, size, dir)
	@latex, @size, @dir = latex, size, dir
    end

    def make_png
	@latex.gsub!("'","")
	Dir.mkdir(@dir,0775) unless File.exists?(@dir)	    
	command = "l2p -p amsmath,amsfonts -T -i '#{@latex}' -d "
	command += @size
	h_command =  Digest::SHA1.hexdigest(command)
	unless File.exists?("#{@dir}/#{h_command}.png")
	    command += " -o #{@dir}/#{h_command}.png"
	    `#{command}`
	end
	"#{h_command}.png"
    end
end
