require_relative 'account_copy'

module Bank
    class SavingsAccount < Account

        def initialize(account_id, balance, opendate)
            super # or super(account_id, balance, opendate); never put super()

            if balance.to_i <= 10
                raise ArgumentError.new("Your account must have at least $10.")
            end
        end

        def withdraw(amount)
            withdrawal_fee = 2
            if (@balance - amount - withdrawal_fee) < 10
                puts "You can't withdraw $#{amount}! Your account balance can't be lower than $10."
                puts "Your original balance: $#{@balance}"
                return @balance
            else
                @balance = @balance - amount - withdrawal_fee
                puts "You just withdrew $#{amount}."
                puts "Your new balance: $#{@balance}"
                return @balance
            end
        end

        def add_interest(rate)
            interest = @balance * rate / 100
            @balance = @balance + interest # updated balance.
            return interest
        end
    end
end
