class PluginController < ThemeController

    def file
        get_path
        if File.exists?(@path)
            ChitoPlugin.copy_to_public(@plugin)
            send_file(@path, :type => mime_for(@file), :disposition => 'inline', :stream => true) 
        else
            return (render :text => "Not Found", :status => 404)
        end
    end

    private

    def get_path
        @plugin, @file = params[:plugin], File.join(params[:anything])
        @path = ChitoPlugin.file_path(@plugin, @file)
        raise "Access denied" unless File.expand_path(@path).start_with?(ChitoPlugin::PLUGIN_PATH)
    end
end
