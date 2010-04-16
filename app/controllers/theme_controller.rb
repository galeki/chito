class ThemeController < ApplicationController
    skip_before_filter :get_site
    before_filter :get_path
    session :off

    def file
	if File.exists?(@path)
	    Theme.copy_to_public(@theme)
	    send_file(@path, :type => mime_for(@file), :disposition => 'inline', :stream => true) 
	else
	    return (render :text => "Not Found", :status => 404)
	end
    end

    private

    def get_path
	@theme, @file = params[:theme], File.join(params[:anything])
	@path = Theme.file_path(@theme, @file)
	raise "Access denied" unless File.expand_path(@path).start_with?(Theme::THEME_PATH)
    end

    def mime_for(filename)
	case File.basename(filename.downcase)
	when /\.js$/
	    'text/javascript'
	when /\.css$/
	    'text/css'
	when /\.gif$/
	    'image/gif'
	when /(\.jpg|\.jpeg)$/
	    'image/jpeg'
	when /\.png$/
	    'image/png'
	when /\.swf$/
	    'application/x-shockwave-flash'
	else
	    'application/binary'
	end
    end

end
