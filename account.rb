require_relative "owner"
require 'csv'

module Bank
    class Account
        attr_reader :account_id, :balance, :owner, :opendate, :withdrawal_fee

        MIN_BALANCE = 0

        def initialize(account_id, balance, opendate)
            #remember to add owner back if i don't use associate_owner method

            @account_id = account_id
            @balance = balance
            @opendate = opendate

            @withdrawal_fee = 0

            if balance.to_i <= self.class::MIN_BALANCE
                raise ArgumentError.new("Your account balance can't be below $#{self.class::MIN_BALANCE}!")
            end
        end

        def account_info()
            puts "Account ID: #{ @account_id }"
            puts "Account balance: #{ @balance }"
            puts "Account open date: #{ @opendate }"
        end

        def withdraw(amount)
            update_balance = @balance - amount - @withdrawal_fee
            if update_balance < self.class::MIN_BALANCE
                puts "You can't withdraw $#{amount}!"
                puts "Your original balance: $#{@balance}"
                return @balance
            else
                puts "Your original balance: $#{@balance}"
                @balance = update_balance
                puts "You just withdrew $#{amount}"
                puts "Withdrawal fee: $#{@withdrawal_fee}"
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

        # Wave 1 optional enhancements for Owners
        def associate_owner(owner)
            @owner = owner
            # remember to remove @owner from the initializer if I want to use this method
        end

        def owner_info()
            @owner.owner_info() #calling owner_info() method of class Owner
        end

        # Wave 2: returns a collection of Account instances, representing all of the Accounts described in the CSV. See below for the CSV file specifications
        def self.all
            account_list = []

            account_file = CSV.read('support/accounts.csv', 'r')
            account_file.each do |line|
                account_list << self.new(line[0].to_i, line[1].to_i, line[2].to_i)
            end

            return account_list
        end

        # Wave 2: returns an instance of Account where the value of the id field in the CSV matches the passed parameter
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
