    module Admin::ArticleHelperPlugin
	def show_seo_filed_in_article_form
	    plugin_render :seo, :seo_field
	end
    end
    module BlogControllerPlugin
	include ActionView::Helpers::TextHelper	   
	include ActionView::Helpers::TagHelper	   
	private
	def set_meta_data_before_post_show
	   @meta_author = @post.writer
	   @meta_keywords = @post.seo_key_words
	   brief = truncate(escape_once(@post.brief.to_s.gsub(/<.+?>/,"").gsub("\r\n","")), :length => 200 )
	   @meta_description = "#{@post.title}-#{brief}"
	end
	def set_meta_data_before_list_show
	   @meta_author = @user.name
	   @meta_keywords = @user.meta_keywords
	   @meta_description = @user.meta_description
	end
    end
    module ArticlePlugin
	def title_in_url
	    self.seo_title.gsub(/\s+/,'-').gsub(/[\\\.\/_\?<>:]/,'-') if self.seo_title
	end
    end
