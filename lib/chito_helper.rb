class Array
    def separate(&block)
	result = self.partition(&block)
	return result[0], result[1]
    end
end

module Kernel
    def to_num(default=0)
	self.to_i == 0 ? default : self.to_i
    end

    def to_tf
	self ? true : false
    end
end

class TrueClass
    def to_i
	1
    end
end

class FalseClass
    def to_i
	nil
    end
end

class Dir
    def self.size(dir)
	sum = 0
	Dir.foreach(dir) do |entry|
	   next if entry =~ /^\./
	   path = File.join(dir, entry)
	   FileTest.directory?(path) ? sum += Dir.size(path) : sum += File.size(path)
	end
	sum
    end
end

class String
    def to_url
	self =~ /^http:\/\// ? url = self : url = "http://" + self
	if url =~ /^http:\/\/.+\..+/
	    url
	else
	    nil
	end
    end
end
