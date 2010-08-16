module Admin::FilesHelper

    def link_to_files(text, options={})
	link_to text, list_admin_files_path(:type => options[:type], :folder => options[:folder], :editor => params[:editor]),
			     :method => :get, :remote => true, :onclick => "$('#in_pro').show();"
    end

    def in_editor?
        params[:editor] || params[:CKEditorFuncNum]
    end
end
