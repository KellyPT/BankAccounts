require_relative "owner"
require 'csv'

module Bank
    class Account
        attr_reader :account_id, :balance, :owner, :opendate

        def initialize(account_id, balance, opendate)
            @account_id = account_id
            @balance = balance
            @opendate = opendate 

            if balance.to_i <= 0
                raise ArgumentError.new("Your account must have a positive balance!")
            end
        end

        def account_info()
            puts "Account ID: #{ @account_id }"
            puts "Account balance: #{ @balance }"
            puts "Account open date: #{ @opendate }"
        end

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

        # Wave 1 optional enhancements has 2 methods below
        def associate_owner(owner)
            @owner = owner
            # remember to remove @owner from the initializer if I want to use this method
        end

        def owner_info()
            @owner.owner_info() #calling owner_info() method of class Owner
        end

    end
end

=begin

Wave 1 testing

my_info = Bank::Owner.new('Kelly', 'Sammamish', '12345')
my_account = Bank::Account.new(2432423, 9800, my_info)

puts my_account.balance
puts my_account.withdraw(19700)
puts my_account.withdraw(700)
puts my_account.deposit(1000)

puts my_account.balance

puts my_account.owner_info()

my_info.name = "Dan Roberts" #==> attr_accessor in Owner will allow me to modify

puts my_account.owner_info()

=end

=begin

Wave 2, primary requirement #1 testing

my_info = Bank::Owner.new('Kelly', 'Sammamish', '12345')
my_account = Bank::Account.new(my_info)

puts my_account.id
puts my_account.balance
puts my_account.opendate

=end

# list_of_account = Bank::Account.all
#
# puts list_of_account
