module Admin::FilesHelper

    def link_to_files(text, params={})
	link_to_remote text, :update => 'file_list', :url => list_admin_files_path(:type => params[:type], :folder => params[:folder]),
			     :method => :get, :loading => "$('#in_pro').show();"
    end

end
