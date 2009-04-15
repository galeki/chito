xml.instruct! :xml, :version=>"1.0", :encoding=>"utf-8"
xml.response do
  xml.error(@error_message.blank? ? 0 : 1)
  xml.message(@error_message) if @error_message
end
