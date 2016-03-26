require_relative 'entry'
require "csv"

class AddressBook
    attr_reader :entries
    def initialize
        @entries = []
    end
    #defined import from csv - reads in a file with File.read
    #use the CSV class the parse athe file CSV.pare is of object type CSV::Table
    def import_from_csv(file_name)
        # Implementation goes here
        csv_text = File.read(file_name)
        csv = CSV.parse(csv_text, headers: true, skip_blanks: true)
        #Iterate over the CSV::Tables rows
        csv.each do |row|
            #Create a hash for each row and convert that to an Entry by using add entry method
            row_hash = row.to_hash
            add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
        end
    end
    
    def add_entry(name, phone_number, email)
        index = 0
        entries.each do |entry|
            if name < entry.name
                break
            end
            index += 1
        end
        
        def remove_entry(name, phone_number, email)
            destroy = nil
            entries.each do |entry| #delete from addressbook
                if name == entry.name && phone_number == entry.phone_number && email == entry.email
                    destroy = entry
                end
            end
            entries.delete(destroy) #delete from array
        end
        
        entries.insert(index, Entry.new(name, phone_number, email))
        
    end
end
