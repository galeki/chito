# encoding: utf-8
class IndexMatch
    def self.matches?(request)
        Site.instance.get_index(request)
    end
end
