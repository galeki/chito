module Admin

    module ArticleHelperPlugin
	def auto_complete_tag_in_article_form
	    plugin_render :auto_complete_tag, :auto_complete_tag_field
	end
    end

end
