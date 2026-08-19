#include <iostream>
using namespace std;

class BankAccount
{

protected:
    int accountNumber;
    string accountHolderName;
    int balance;

public:
    BankAccount()
    {
        accountNumber = 0;
        accountHolderName = "";
        balance = 0;
    };

    BankAccount(int accountNumber, string accountHolderName, int balace)
    {
        this->accountNumber = accountNumber;
        this->accountHolderName = accountHolderName;
        this->balance = balance;
    };

    void deposit(double amount)
    {
        balance = balance + amount;
    };

    void withdraw(double amount)
    {
        balance = balance - amount;
    };

    void setAccountNumber(int accountNumber)
    {
        this->accountNumber = accountNumber;
    };

    void setAccountHolderName(string accountHolderName)
    {
        this->accountHolderName = accountHolderName;
    };

    void setBalance(int balance)
    {
        this->balance = balance;
    };

    int getAccountNumber()
    {
        return accountNumber;
    };

    string getAccountHolderName()
    {
        return accountHolderName;
    };

    int getBalance()
    {
        return balance;
    };

    void AccountInfo()
    {

        cout << "The current balance is : " << balance << endl;
        cout << "The Account holder name is : " << accountHolderName << endl;
        cout << "The Account number is  :" << accountNumber << endl;
    };
};

class SavingAccount : public BankAccount
{

public:
private:
    float rateIntrest;

public:
    SavingAccount()
    {
        rateIntrest = 0;
    }

    void setIntrestRate(float rateIntrest)
    {
        this->rateIntrest = rateIntrest;
    }

    float getIntrestRate()
    {
        return rateIntrest;
    }

    void calculateIntrest()
    {

        float intrest = balance * rateIntrest / 100;

        cout << "Clculate rate of intrest based on current balance is : " << intrest << endl;
    }
};

class CheckingAccount : public BankAccount
{

public:
private:
    int overdraftLimit;

public:
    CheckingAccount()
    {
        overdraftLimit = 0;
    }

    void setCheckingAccount(int overdraftLimit)
    {
        this->overdraftLimit = overdraftLimit;
    }

    int getCheckingAccount()
    {
        return overdraftLimit;
    }

    void checkOverdraftlimit(int amount)
    {
        if (amount > balance + overdraftLimit)
        {
            cout << "Withdrawal exceeds the overdraft limit...." << endl;
        }
        else
        {
            cout << "Withdrawal is allowed ...." << endl;
        }
    }
};

class FixedDepositAccount : public BankAccount
{

public:
private:
    int term;
    float intrestRate;

public:
    FixedDepositAccount()
    {
        term = 0;
        intrestRate = 0;
    }

    void setTerm(int term)
    {
        this->term = term;
    }

    void setIntrestRate(float intrestRate)
    {
        this->intrestRate = intrestRate;
    }

    int getTerm()
    {
        return term;
    }

    float getIntrestRate()
    {
        return intrestRate;
    }

    void calculateIntrestRate()
    {

        float intrest = balance * intrestRate * term / (100 * 12);

        cout << "Fixed deposit intrest is ....... " << intrest << endl;
    }
};

int main()
{

    cout << ".......Bank account info......" << endl;
    BankAccount ba;
    ba.setAccountNumber(123456789);
    ba.setAccountHolderName("AKSHAT RAWAL");
    ba.setBalance(500);

    ba.deposit(100);
    ba.withdraw(100);

    ba.getAccountNumber();
    ba.getAccountHolderName();
    ba.getBalance();
    ba.AccountInfo();

    cout << ".......Saving account info......" << endl;

    SavingAccount sa;
    sa.setAccountNumber(123456789);
    sa.setAccountHolderName("AKSHAT RAWAL");
    sa.setBalance(5000);
    sa.AccountInfo();
    sa.setIntrestRate(5);
    sa.getIntrestRate();
    sa.calculateIntrest();

    cout << ".......Check account info......" << endl;

    CheckingAccount ca;
    ca.setAccountNumber(24789);
    ca.setAccountHolderName("Akshat Rawal");
    ca.setBalance(500);

    ca.setCheckingAccount(1000);

    ca.AccountInfo();

    ca.checkOverdraftlimit(1600);

    cout << ".......Fixed deposite accoount......" << endl;

    FixedDepositAccount fa;
    fa.setAccountNumber(347289);
    fa.setAccountHolderName("AKSHAT RAWAL");
    fa.setBalance(10000);

    fa.setTerm(12);
    fa.setIntrestRate(6);

    fa.AccountInfo();

    fa.calculateIntrestRate();

    return 0;
}