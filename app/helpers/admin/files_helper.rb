module Admin::FilesHelper

    def link_to_files(text, params={})
	link_to text, list_admin_files_path(:type => params[:type], :folder => params[:folder]),
			     :method => :get, :remote => true, :onclick => "$('#in_pro').show();"
    end

end
