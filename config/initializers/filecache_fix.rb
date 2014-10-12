module ActiveSupport
  module Cache
    class Store
    private
      def merged_options(call_options)
        options ||= {}
        if call_options
          options.merge(call_options)
        else
          options.dup
        end
      end    
    end

    class FileStore < Store
      attr_reader :cache_path

      def initialize(cache_path)
        @cache_path = cache_path
      end

      def increment(name, amount = 1, options = nil)
      end

      def decrement(name, amount = 1, options = nil)
      end


      def delete_matched(matcher, options = nil)
        #search_dir(@cache_path) do |f|
        #  if f =~ matcher
        #    begin
        #      File.delete(f)
        #    rescue SystemCallError => e
        #      # If there's no cache, then there's nothing to complain about
        #    end
        #  end
        #end
      end

      def read_entry(name, options)
        File.open(real_file_path(name), 'rb') { |f| Marshal.load(f) } rescue nil
      end

      def write_entry(name, value, options)
          ensure_cache_path(File.dirname(real_file_path(name)))
          File.atomic_write(real_file_path(name), cache_path) { |f| Marshal.dump(value, f) }
          value
          rescue => e
              logger.error "Couldn't create cache directory: #{name} (#{e.message})" if logger
      end

      def delete_entry(name, options)
          if name =~ /\*$/
            s=File.join(@cache_path,  name)
            #puts "====================#{s}========================"
            FileUtils.rm_f(Dir.glob(s))          
          else
            File.delete(real_file_path(name))
          end
          
          rescue SystemCallError => e
                # If there's no cache, then there's nothing to complain about
      end

      # Delete empty directories in the cache.
      def delete_empty_directories(dir)
        return if dir == cache_path
        if Dir.entries(dir).reject{|f| ['.', '..'].include?(f)}.empty?
          File.delete(dir) rescue nil
          delete_empty_directories(File.dirname(dir))
        end
      end

      def exist?(name, options = nil)
        File.exist?(real_file_path(name))
      end

      def real_file_path(name)
        '%s/%s.cache' % [@cache_path, name.gsub('?', '.').gsub(':', '.')]
      end

      def ensure_cache_path(path)
        FileUtils.makedirs(path) unless File.exist?(path)
      end

      def search_dir(dir, &callback)
        Dir.foreach(dir) do |d|
          next if d == "." || d == ".."
          name = File.join(dir, d)
          if File.directory?(name)
            search_dir(name, &callback)
          else
            callback.call name
          end
        end
      end
    end
  end
end
