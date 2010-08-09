navbar = Navbar.new
navbar.id = :home
navbar.title = "Home"
navbar.default_position = 0
navbar.url = "/"
navbar.plugin_id = :default_navbars
Navbar.add(navbar)

navbar = Navbar.new
navbar.id = :admin
navbar.title = "Admin"
navbar.url = {:controller => 'admin/dashboard'}
navbar.default_position = 999
navbar.plugin_id = :default_navbars
Navbar.add(navbar)

navbar = Navbar.new
navbar.id = :guestbook
navbar.default_position = 998
navbar.title = "Guestbook"
navbar.url = "/guestbook"
navbar.plugin_id = :default_navbars
Navbar.add(navbar)
