(1..5).each do |x|
    navbar = Navbar.new
    navbar.id = "custom_navbar_#{x}".to_sym
    #navbar.title = @user.send("custom_navbar_#{x}_title")
    navbar.config = true
    navbar.plugin_id = :custom_navbars
    navbar.default_position = 10 + x
    navbar.default_title = "Custom Navbar #{x}"
    #navbar.url = @user.send("custom_navbar_#{x}_url") || "http://"
    Navbar.add(navbar)
end
