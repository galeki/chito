module Admin

end
module ApplicationPlugin
    @@hooks = {}

    private
    def do_something(hook)
	@@hooks[hook] ||= private_methods.select{|h| h =~ /_#{hook}$/}.map{|x| x.to_sym}
	@@hooks[hook].each { |h| send(h)}
    end
end    

module ApplicationHelperPlugin
    @@vhooks={}

    def show_something(hook)
	html = ''
	@@vhooks[hook] ||= methods.select{|h| h =~ /_#{hook}$/}.sort.map{|x| x.to_sym}
	@@vhooks[hook].each {|h| html << send(h).to_s }
	html
    end
end

module Admin::ArticleControllerPlugin

end
module Admin::ArticleHelperPlugin

end
module CommentControllerPlugin
end
