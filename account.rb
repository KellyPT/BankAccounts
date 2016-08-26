require_relative "owner"
require 'csv'

module Bank
    class Account
        attr_reader :account_id, :balance, :owner, :opendate

        def initialize(account_id, balance, opendate) #remember to add owner back if i don't use associate_owner method
            @account_id = account_id #nil
            @balance = balance #nil
            @opendate = opendate #nil

            # csv_accounts
            # @owner = owner

            if balance.to_i <= 0
                raise ArgumentError.new("Your account must have a positive balance!")
            end
        end

        def account_info()
            puts "Account ID: #{ @account_id }"
            puts "Account balance: #{ @balance }"
            puts "Account open date: #{ @opendate }"
        end

        # Wave 2, primary requirement #1
        # def csv_accounts
        #     accounts = CSV.read('support/accounts.csv', 'r')
        #     puts "There are 12 accounts in this list. Please tell me an ordinal number to retrieve account information."
        #     user_input = gets.chomp.to_i
        #     index = user_input - 1
        #     @id = accounts[index][0]
        #     @balance = accounts[index][1]
        #     @opendate = accounts[index][2]
        # end

        #returns a collection of Account instances, representing all of the Accounts described in the CSV. See below for the CSV file specifications
        def self.all
            account_list = []

            account_file = CSV.read('support/accounts.csv', 'r')
            account_file.each do |line|
                account_list << self.new(line[0].to_i, line[1].to_i, line[2].to_i)
            end

            return account_list
        end

        # returns an instance of Account where the value of the id field in the CSV matches the passed parameter
        def self.find(id)
            self.all.each do |item|
                if item.account_id == id
                    # puts item.account_info()
                    return item
                end
            end
            puts "Sorry, invalid ID."
            return nil
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

        # Wave 2 optional enhancements: to create the relationship between the accounts and the owners use the account_owners CSV file
        def self.account_owner_assoc()
            CSV.read('support/account_owners.csv', 'r').each do |line|
                account = Bank::Account.find(line[0].to_i)
                owner = Bank::Owner.find(line[1].to_i)
                if account != nil && owner != nil
                    puts "\nTHIS IS THE MATCHING INFO:"
                    account.account_info()
                    account.associate_owner(owner)
                    account.owner_info()
                end
            end
            return "Thank you for checking with us."
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
