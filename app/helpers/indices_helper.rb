module IndicesHelper

    def indices_cache(&block)
	 chito_cache _params.merge(:part => :index, :type => :indices_index, :theme => @index.theme, :id => @index.id), &block
    end

end
