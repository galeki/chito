module Chito
 module CacheController
    def chito_cache_enable(options={}, &block)
	read_fragment chito_cache_key(options), &block
    end

    def sidebar_cache_enable(id, options={}, &block)
	read_fragment chito_cache_key(options.merge(:part => :plugins, :type => :sidebars, :id => id)), &block 
    end

    def postbar_cache_enable(id, options={}, &block)
	read_fragment chito_cache_key(options.merge(:part => :plugins, :type => :postbars, :id => id)), &block 
    end

    def sidebar_cache_expire(id, options={})
	expire_fragment chito_cache_key(options.merge(:part => :plugins, :type => :sidebars, :id => id)) 
    end

    def postbar_cache_expire(id, options={})
	expire_fragment chito_cache_key(options.merge(:part => :plugins, :type => :postbars, :id => id)) 
    end

    def chito_cache_expire(options={})
	ckey = chito_cache_key(options)
	ckey = Regexp.new(ckey) if ckey =~ /\*$/
	expire_fragment ckey
    end

    def chito_cache_key(options={})
        ckey = []
        ckey << @user.name if @user
	ckey << (options.delete(:part) || 'blog')
        ckey << (options.delete(:type) || 'main')
	ckey << options.delete(:id)
        ckey << options.delete(:post)
        ckey << (@now.to_i / options.delete(:in).to_i) if options[:in]
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
 end
end
