module Admin::ArticleHelper
    include Admin::ArticleHelperPlugin
    @@edit_modes = nil

    def article_edit_field
        if params[:mode] && respond_to?("#{params[:mode]}_edit_mode")
            send("#{params[:mode]}_edit_mode")
        elsif @article.mode && respond_to?("#{@article.mode}_edit_mode")
            send("#{@article.mode}_edit_mode")
        else
            ck_editor
        end
    end

    def ck_editor
        render :partial => 'admin/share/ck'
    end
    
    def edit_modes
        @@edit_modes ||= methods.select{|h| h =~ /_edit_mode$/}.map{|h| h.sub("_edit_mode", "")}
    end

end
