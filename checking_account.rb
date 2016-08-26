require_relative "account_copy"

module Bank
    class CheckingAccount < Account
        attr_accessor :free_checks

        def initialize(account_id, balance, opendate)
            super
            @used_checks = 0
        end

        def withdraw(amount)
            withdrawal_fee = 1
            if (@balance - amount - withdrawal_fee) < 0
                puts "You can't withdraw $#{amount}! Your account balance can't go below $0."
                puts "Your original balance: $#{@balance}"
                return @balance
            else
                @balance = @balance - amount - withdrawal_fee
                puts "You just withdrew $#{amount}."
                puts "Your new balance: $#{@balance}"
                return @balance
            end
        end

        def withdraw_using_check(amount)
            transaction_fee = 2
            if (@balance - amount) < -10
                puts "You can't withdraw $#{amount}! Your account balance can't go below -$10."
                puts "Your original balance: $#{@balance}"
                return @balance
            else
                if @used_checks < 3
                    @balance = @balance - amount
                    puts "You just withdrew $#{amount}."
                    puts "Your new balance: $#{@balance}"
                    @used_checks += 1
                    return @balance
                else
                    puts "Sorry, you have used more than 3 free checks."
                    @balance = @balance - amount - transaction_fee
                    puts "Your new balance: $#{@balance}"
                    return @balance
                end
            end
        end

        def reset_checks()
            @used_checks = 0
            return @used_checks
        end
    end
end
