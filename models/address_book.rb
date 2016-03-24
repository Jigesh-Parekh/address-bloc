require_relative 'entry'

class AddressBook
	attr_reader :entries
	def initialize
		@entries = []
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
