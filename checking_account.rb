require_relative "account"

module Bank
    class CheckingAccount < Account
        attr_reader :used_checks

        def initialize(account_id, balance, opendate)
            super
            @withdrawal_fee = 1
            @overdraft_fee = 2
            @used_checks = 0
        end

        def withdraw(amount)
            super
        end

        def withdraw_using_check(amount)
            update_balance = @balance - amount
            if update_balance < -10
                puts "You can't withdraw $#{amount}! You can't overdraft below -$10."
                puts "Your original balance: $#{@balance}"
                return @balance
            else
                if @used_checks < 3
                    @balance = update_balance
                    puts "You just withdrew $#{amount}."
                    puts "Your new balance: $#{@balance}"
                    @used_checks += 1
                    return @balance
                else
                    puts "Sorry, you have used more than 3 free checks."
                    puts "Your original balance: $#{@balance}"
                    @balance = update_balance - @overdraft_fee
                    puts "You just withdrew $#{amount}"
                    puts "Overdraft transaction fee: $#{@overdraft_fee}"
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
