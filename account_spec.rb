require "rspec"

require_relative "account"

describe Account do
    let (:acc) {Account.new("1234567890")}
    let (:transactions) {[0]}
    describe "#initialize" do 
        it "check initialization type" do
            expect( Account.new("1123456789", 50) ).to be_a_kind_of(Account)
        end

        it "initialize with at least 1 argument" do
            expect{Account.new()}.to raise_error(ArgumentError)
        end

        it "initialize with more than 3 argument" do
            expect{Account.new("1123456789", 50, 12)}.to raise_error(ArgumentError)
        end

        it "bank account must be digits" do
            expect{Account.new("abcdefghijkl")}.to raise_error(InvalidAccountNumberError)
        end
        
        it "bank account cannot be less than 10 digits long" do
            expect{Account.new("12345")}.to raise_error(InvalidAccountNumberError)
        end

        it "bank account cannot be less than 10 digits long" do
            expect{Account.new("12345123456789s")}.to raise_error(InvalidAccountNumberError)
        end
    end

    describe "#transactions" do 
        it "returns transaction" do
            expect(acc.transactions).to eq(transactions)
        end
    end

    describe "#balance" do
        it "returns sum of transaction" do
            expect( acc.balance ).to eq(0)
        end

        it "returns sum of transaction" do
            expect( acc.balance ).to_not eq(5)
        end

    end

    describe "#account_number" do 
        it "account number length not similar to original" do
            expect( acc.acct_number ).to eq("******7890")
        end

        it "account number length not similar to original" do
            expect( acc.acct_number ).to_not eq("1234567890")
        end
    end

    describe "deposit!" do 
        it "raise error if negative deposit" do
            expect{acc.deposit!(-1)}.to raise_error(NegativeDepositError)
        end

        it "deposit updates balance" do
            expect{acc.deposit!(50)}.to change(acc, :balance).from(0).to(50)
        end
    end

    describe "#withdraw!" do
        it "withdraw changes balance" do
            acc.deposit!(100)
            expect{acc.withdraw!(50)}.to change(acc, :balance).from(100).to(50)
        end

        it "Cannot withdraw more than account balance" do
            acc.deposit!(100)
            expect{acc.withdraw!(101)}.to raise_error(OverdraftError)
        end
    end
end