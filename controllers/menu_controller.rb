require_relative '../models/address_book'

class MenuController
	attr_reader :address_book
	def initialize
		@address_book = AddressBook.new
	end

	def main_menu

    	puts "Main Menu - #{address_book.entries.count} entries"
    	puts "1 - View all entries"
    	puts "2 - Create an entry"
    	puts "3 - Search for an entry"
    	puts "4 - Import entries from a CSV"
        puts "5 - Destroy all entries"
    	puts "6 - Exit"

    	puts "Enter you selection: "

    	selection = gets.to_i #set the input param to integer
        
        case selection
            when 1
                system "clear"
                view_all_entries
                main_menu
            when 2
                system "clear"
                create_entry
                main_menu
            when 3
                system "clear"
                search_entries
                main_menu
            when 4
                system "clear"
                read_csv
                main_menu
            when 5
                system "clear"
                puts "you sure? (y for yes n for no): "
                answer = gets.chomp.to_s
                if answer = 'y'
                    address_book.destroy_all
                    puts "Destroyed all documents"
                    main_menu
                else
                    system "clear"
                    puts "cancelling and returning to main"
                    main_menu
                end
            when 6
                puts "Good-bye"
                exit(0)
            else
                system "clear"
                puts "Sorry that is not a valid input"
                main_menu
        end

	end



    def view_all_entries
            address_book.entries.each do |entry|
                system "clear"
                puts entry.to_s

                entry_submenu(entry)
            end

            system "clear"
            puts "End of Entries"
    end

    def delete_entry(entry)
        address_book.entries.delete(entry)
        puts "#{entry.name} has been deleted"
    end

    def edit_entry(entry)
        print "Updated Name: "
        name = gets.chomp
        print "Updated Phone Number: "
        phone_number = gets.chomp
        print "Updated Email: "
        email = gets.chomp

        entry.name = name if !name.empty? #set attributes on entry only if a valid attribute was read from user input.
        entry.phone_number = phone_number if !phone_number.empty?
        entry.email = email if !email.empty?
        system "clear"

        puts "Updated Entry: "
        puts entry
    end



    def create_entry
            system "clear"
            puts "New AddressBloc Entry"
            print "Name: "
            name = gets.chomp

            print "Phone Number: "
            phone_number = gets.chomp

            print "Email: "
            email = gets.chomp

            address_book.add_entry(name, phone_number, email)

            system "clear"
            puts "New entry created"
    end

    def search_entries
        print "Search by name: "
        name = gets.chomp

        match = address_book.binary_search(name)
        system "clear"

        if match 
            puts match.to_s
            search_submenu(match)
        else
            puts "no match found for #{name}"
        end
    end
        
    def read_csv
         #promp user to enter CSV to import
        print "Enter CSV file to import:"
        file_name = gets.chomp
        #check file to see if its empty if it is return to main mentu
        if file_name.empty?
            system "clear"
            puts "No CSV file to read"
            main_menu
        end
        #import file with import_from_csv to addressbook 
        #clear screen and print number of entries that the file read from
        #begin rescue bloc will protect the program from crashing if exception is thrown
        begin
            entry_count = address_book.import_from_csv(file_name).count
            system "clear"
            puts "#{entry_count} new entries added from #{file_name}"
        rescue
            puts "#{file_name} is not a valid CSV file please enter a valid name: "
            read_csv
        end

    end 

    def entry_submenu(entry)
        puts "n - next entry"
        puts "d - delete entry"
        puts "e - edit this entry"
        puts "m - return to the mains state"

        selection = gets.chomp

        case selection
            when "n"

            when "d"
                delete_entry(entry)
            when "e"
                edit_entry(entry)
                entry_submenu(entry)
            when "m"
                system "clear"
                main_menu
            else
                system "clear"
                puts "#{selection} is not a valid input"
                entry_submenu(entry)
        end
    end

    def search_submenu(entry)

     puts "\nd - delete entry"
     puts "e - edit this entry"
     puts "m - return to main menu"
     
     selection = gets.chomp
 
  
     case selection
       when "d"
         system "clear"
         delete_entry(entry)
         main_menu
       when "e"
         edit_entry(entry)
         system "clear"
         main_menu
       when "m"
         system "clear"
         main_menu
       else
         system "clear"
         puts "#{selection} is not a valid input"
         puts entry.to_s
         search_submenu(entry)
     end
   end
    
end


