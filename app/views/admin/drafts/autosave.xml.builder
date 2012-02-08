xml.instruct! :xml, :version => "1.0", :encoding=>"UTF-8"
if @success
    xml.result(:status => "ok")
else
    xml.error(:statuscode => "500")
end
