module Chito
 module CacheController
    def chito_cache_enable(options={}, &block)
        read_fragment chito_cache_key(options), &block
    end

    def sidebar_cache_enable(id, options={}, &block)
        chito_cache_enable(options.merge(:part => :plugins, :type => :sidebars, :id => id), &block)
    end

    def postbar_cache_enable(id, options={}, &block)
        chito_cache_enable(options.merge(:part => :plugins, :type => :postbars, :id => id), &block) 
    end

    def sidebar_cache_expire(id, options={})
        chito_cache_expire(options.merge(:part => :plugins, :type => :sidebars, :id => id)) 
    end

    def postbar_cache_expire(id, options={})
        chito_cache_expire(options.merge(:part => :plugins, :type => :postbars, :id => id)) 
    end

    def chito_cache_expire(options={})
        ckey = chito_cache_key(options)
        ckey = Regexp.new(ckey) if ckey =~ /\*$/
        expire_fragment ckey
    end

    def expire_index(index)
        chito_cache_expire :part => :_index, :type => :indices_index, :id => "#{index.id}/*"
    end

    def chito_cache_key(options={})
        ckey = []
        ckey << @user.name if @user && options[:part] != :_index
        ckey << (options.delete(:part) || 'blog')
        ckey << (options.delete(:type) || 'main')
        ckey << options.delete(:id)
        ckey << options.delete(:post)
        if options[:tag_name]
            options[:tag_name] = options[:tag_name].hash
        end
        if options[:in] == :all
            ckey << "*"
            options.delete(:in)
        elsif options[:in].to_i > 0
            ckey << (@now.to_i / options.delete(:in).to_i)
        end
        ckey << options.to_param unless options.blank?
        ckey.compact.join('/')
    end    
 end

 module CacheHelper
    def chito_cache(options={}, &block)
        cache( chito_cache_key(options), &block )
    end

    def sidebar_cache(id, options={}, &block)
        cache chito_cache_key(options.merge(:part => :plugins, :type => :sidebars, :id => id)), &block 
    end

    def postbar_cache(id, options={}, &block)
        cache chito_cache_key(options.merge(:part => :plugins, :type => :postbars, :id => id)), &block 
    end

    def indices_cache(&block)
        chito_cache _params.merge(:part => :_index, :type => :indices_index, :theme => @index.theme, :id => @index.id), &block
    end
 end
end
