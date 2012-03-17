class ThemeController < ApplicationController
    skip_before_filter :get_site

    def user_theme_file
        render :text => 'Not Found', :status => '404'                
        #get_theme_file_of(UserTheme)
    end

    def index_theme_file
        render :text => 'Not Found', :status => '404'                
        #get_theme_file_of(IndexTheme)
    end

    private

    def get_theme_file_of(klass)
        @theme, @file = params[:theme], File.join(params[:anything]+"."+params[:format])
        @path = klass.file_path(@theme, @file)
        raise "Access denied" unless File.expand_path(@path).start_with?(klass::PATH)

        if File.exists?(@path)
            #klass.copy_to_public(@theme)
            send_file(@path, :type => mime_for(@file), :disposition => 'inline', :stream => true) 
        else
            return (render :text => "Not Found", :status => 404)
        end
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
