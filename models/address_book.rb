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
   
    def binary_search(name)
         #save the index of the leftmost item to a variable lower
        #index of rightmost item in array set as upper
        #leftmost is the zeroth index and right is the entries.len-1 index
        lower = 0
        upper = entries.length - 1
            #set a loop while the lower index is less than or equal to upper
        while lower <= upper
            #find the middle index by taking the sum of lower and upper and divide it by 2
            #it truncates decimal (5upper 0 lower == 2 middle)
            mid = (lower + upper) / 2
            mid_name = entries[mid].name
            #compare the name we are searching for to the middle index
            if name == mid_name
                #if its the middle then the job is done
                return entries[mid]
            elsif name < mid_name
                #if it is less than or before the middle then we set upper to mid-1
                #basically limiting the scope of the search to half of the initial 
                #array list size 
                #|++++++++++++++++++++++++++++++++|
                #|++++++++++++++|-----------------|
                upper = mid - 1
            elsif name > mid_name
                #if name is greater than or after the middle then we set the lower to mid+1
                #becasue we can automatically deduce the number underneath mid are irrelevant
                #|++++++++++++++++++++++++++++++++|
                #|--------------|+++++++++++++++++|
                lower = mid + 1
            end
        end
        #divide and concour until a mid is reached, otherwise return nil
        return nil
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
