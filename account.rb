require_relative "owner"

module Bank
    class Account
        attr_reader :id, :balance, :owner

        def initialize(id, balance, owner)
            @id = id
            @balance = balance
            @owner = owner
            if balance <= 0
                raise ArgumentError.new("Your account must have a positive balance!")
            end
        end

        # def associate_owner(owner)
        #     @owner = owner
        # end
        # remember to remove @owner from the initializer

        def withdraw(amount)
            if (@balance - amount) < 0
                puts "You can't withdraw $#{amount}! Your account balance can't go negative."
                puts "Your original balance: $#{@balance}"
                return @balance
            else
                @balance = @balance - amount
                puts "You just withdrew $#{amount}."
                puts "Your new balance: $#{@balance}"
                return @balance
            end
        end

        def deposit(amount)
            @balance = @balance + amount
            puts "You just deposited $#{amount}."
            puts "Your new balance: $#{@balance}"
            return @balance
        end

        def owner_info()
            puts "This is the owner's information:"
            puts "Name: #{@owner.name}"
            puts "Address: #{@owner.address}"
            puts "Phone: #{@owner.phone}"
        end
    end
end


my_info = Bank::Owner.new('Kelly', 'Sammamish', '12345')
my_account = Bank::Account.new(2432423, 9800, my_info)

puts my_account.balance
puts my_account.withdraw(19700)
puts my_account.withdraw(700)
puts my_account.deposit(1000)

puts my_account.balance

puts my_account.owner_info()

# my_info.name = "Dan Roberts" ==> attr_accessor in Owner will allow me to modify

#puts my_account.owner_info()
