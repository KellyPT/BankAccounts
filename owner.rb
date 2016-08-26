require 'csv'

module Bank
    class Owner
        attr_accessor :owner_id, :last_name, :first_name, :street, :city, :state

        def initialize(owner_id, last_name, first_name, street, city, state)
            @owner_id = owner_id
            @last_name = last_name
            @first_name = first_name
            @street = street
            @city = city
            @state = state
        end

        def owner_info()
            puts "Owner ID: #{ @owner_id }"
            puts "Owner last_name: #{ @last_name }"
            puts "Owner first_name: #{ @first_name }"
            puts "Owner street: #{ @street }"
            puts "Owner city: #{ @city }"
            puts "Owner state: #{ @state }"
        end

        def self.all
            owner_list = []

            CSV.read('support/owners.csv', 'r').each do |line|
                owner_list << self.new(line[0].to_i, line[1], line[2], line[3], line[4], line[5])
            end

            return owner_list
        end

        def self.find(id)
            self.all.each do |owner|
                if owner.owner_id == id
                    # puts owner.owner_info
                    return owner
                end
            end
            puts "Sorry, we can't find that owner ID."
            return nil
        end
    end
end
