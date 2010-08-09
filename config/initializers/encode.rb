ActionView::OutputBuffer.class_eval do
  undef << if defined?(:<<)

  def <<(value)
    self.force_encoding(Encoding.default_external)
    value = value.to_s.force_encoding(Encoding.default_external)
    super(value)
  end
  alias :append= :<<
end

