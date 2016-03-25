require_relative 'controllers/menu_controller'

menu = MenuController.new
#create new menucontroller when addressbloc starts
system "clear"
#system clear the command line
puts "Welcome to AddressBloc"
#call main menu to display the menu
menu.main_menu
