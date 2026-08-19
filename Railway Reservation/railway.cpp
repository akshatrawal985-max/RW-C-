#include <iostream>
#include <string>
using namespace std;

// ================= TRAIN CLASS =================

class Train
{
private:
    int trainNumber;
    string trainName;
    string source;
    string destination;
    string trainTime;

    static int trainCount;

public:

    // Default Constructor
    Train()
    {
        trainNumber = 0;
        trainName = "";
        source = "";
        destination = "";
        trainTime = "";
    }

    // Parameterized Constructor
    Train(int number, string name, string src,
          string dest, string time)
    {
        trainNumber = number;
        trainName = name;
        source = src;
        destination = dest;
        trainTime = time;

        trainCount++;
    }

    // Destructor
    ~Train()
    {
        if (trainNumber != 0)
        {
            trainCount--;
        }
    }

    // Getters
    int getTrainNumber()
    {
        return trainNumber;
    }

    string getTrainName()
    {
        return trainName;
    }

    string getSource()
    {
        return source;
    }

    string getDestination()
    {
        return destination;
    }

    string getTrainTime()
    {
        return trainTime;
    }

    // Setters
    void setTrainNumber(int number)
    {
        trainNumber = number;
    }

    void setTrainName(string name)
    {
        trainName = name;
    }

    void setSource(string src)
    {
        source = src;
    }

    void setDestination(string dest)
    {
        destination = dest;
    }

    void setTrainTime(string time)
    {
        trainTime = time;
    }

    // Input Train Details
    void inputTrainDetails()
    {
        cout << "Enter Train Number: ";
        cin >> trainNumber;

        cin.ignore();

        cout << "Enter Train Name: ";
        getline(cin, trainName);

        cout << "Enter Source: ";
        getline(cin, source);

        cout << "Enter Destination: ";
        getline(cin, destination);

        cout << "Enter Train Time: ";
        getline(cin, trainTime);

        trainCount++;
    }

    // Display Train Details
    void displayTrainDetails()
    {
        cout << "\nTrain Number : " << trainNumber << endl;
        cout << "Train Name   : " << trainName << endl;
        cout << "Source       : " << source << endl;
        cout << "Destination  : " << destination << endl;
        cout << "Train Time   : " << trainTime << endl;
    }

    // Static Function
    static int getTrainCount()
    {
        return trainCount;
    }
};


// Initialize static variable
int Train::trainCount = 0;


// ================= RAILWAY SYSTEM CLASS =================

class RailwaySystem
{
private:
    Train* trains[100];
    int totalTrains;

public:

    // Constructor
    RailwaySystem()
    {
        totalTrains = 0;

        for (int i = 0; i < 100; i++)
        {
            trains[i] = nullptr;
        }
    }

    // Destructor
    ~RailwaySystem()
    {
        for (int i = 0; i < totalTrains; i++)
        {
            delete trains[i];
        }
    }

    // Add New Train
    void addTrain()
    {
        if (totalTrains >= 100)
        {
            cout << "\nTrain limit reached!\n";
            return;
        }

        Train* newTrain = new Train();

        newTrain->inputTrainDetails();

        trains[totalTrains] = newTrain;
        totalTrains++;

        cout << "\nTrain added successfully!\n";
    }

    // Display All Trains
    void displayAllTrains()
    {
        if (totalTrains == 0)
        {
            cout << "\nNo trains available.\n";
            return;
        }

        cout << "\n===== All Train Records =====\n";

        for (int i = 0; i < totalTrains; i++)
        {
            trains[i]->displayTrainDetails();
            cout << "-----------------------------\n";
        }
    }

    // Search Train By Number
    void searchTrainByNumber(int number)
    {
        for (int i = 0; i < totalTrains; i++)
        {
            if (trains[i]->getTrainNumber() == number)
            {
                cout << "\nTrain found!\n";
                trains[i]->displayTrainDetails();
                return;
            }
        }

        cout << "\nTrain with number "
             << number << " not found!\n";
    }
};


// ================= MAIN FUNCTION =================

int main()
{
    RailwaySystem railway;

    int choice;

    do
    {
        cout << "\n====================================\n";
        cout << "      RAILWAY RESERVATION SYSTEM\n";
        cout << "====================================\n";

        cout << "1. Add New Train Record\n";
        cout << "2. Display All Train Records\n";
        cout << "3. Search Train By Number\n";
        cout << "4. Exit\n";

        cout << "\nEnter your choice: ";
        cin >> choice;

        switch (choice)
        {
            case 1:
                railway.addTrain();
                break;

            case 2:
                railway.displayAllTrains();
                break;

            case 3:
            {
                int number;

                cout << "Enter Train Number to search: ";
                cin >> number;

                railway.searchTrainByNumber(number);

                break;
            }

            case 4:
                cout << "\nExiting Railway Reservation System...\n";
                break;

            default:
                cout << "\nInvalid choice! Please try again.\n";
        }

    } while (choice != 4);


    cout << "\nTotal trains currently stored: "
         << Train::getTrainCount() << endl;

    return 0;
}