require_relative "account"

module Bank
    class SavingsAccount < Account

        MIN_BALANCE = 10 # Constants can't be set inside of a method. It must stay in a class but outside of a method

        def initialize(account_id, balance, opendate)
            super # or super(account_id, balance, opendate); never put super()
            @withdrawal_fee = 2
        end

        def withdraw(amount)
            super
            # minimum balance = $10, withdrawal fee = $2
        end

        def add_interest(rate)
            interest = @balance * rate / 100
            @balance = @balance + interest # updated balance
            return interest
        end
    end
end
