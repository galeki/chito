    module Admin::ArticleHelperPlugin
	def textile_edit_mode
	    plugin_render :textile_mode, :textile_editor
	end
    end
    module Admin::ArticleControllerPlugin
	private
 	def parse_textile_before_article_save
 	    if @article.is_textile
 		require 'redcloth'
 		@article.content = RedCloth.new(@article.raw_content).to_html
 	    end
 	end
    end
