ActionView::OutputBuffer.class_eval do
  undef << if defined?(:<<)

  def <<(value)
    self.force_encoding(Encoding.default_external)
    value = value.to_s.force_encoding(Encoding.default_external)
    super(value)
  end
  alias :append= :<<
end

Fixnum.class_eval do  
  alias_method :old_to_s, :to_s  
  def to_s  
    old_to_s.force_encoding("UTF-8")  
  end  
end  
Hash.class_eval do  
  alias_method :old_to_s, :to_s  
  def to_s  
    old_to_s.force_encoding("UTF-8")  
  end  
end  
Symbol.class_eval do  
  alias_method :old_to_s, :to_s  
  def to_s  
    old_to_s.force_encoding("UTF-8")  
  end  
end  
Array.class_eval do  
  alias_method :old_pack, :pack  
  def pack(*args)  
    old_pack(*args).force_encoding("UTF-8")  
  end  
end  

