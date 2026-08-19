#include <iostream>
using namespace std;

class TimeConverter
{
private:
    int hours;
    int minutes;
    int seconds;

public:

    // Default Constructor
    TimeConverter()
    {
        hours = 0;
        minutes = 0;
        seconds = 0;
    }

    // Parameterized Constructor
    TimeConverter(int h, int m, int s)
    {
        hours = h;
        minutes = m;
        seconds = s;
    }

    // Convert seconds to HH:MM:SS
    void secondsToTime(int totalSeconds)
    {
        hours = totalSeconds / 3600;
        totalSeconds = totalSeconds % 3600;

        minutes = totalSeconds / 60;
        seconds = totalSeconds % 60;

        cout << "HH:MM:SS = "
             << hours << ":"
             << minutes << ":"
             << seconds << endl;
    }

    // Convert HH:MM:SS to total seconds
    int timeToSeconds()
    {
        return (hours * 3600) + (minutes * 60) + seconds;
    }
};

int main()
{
    TimeConverter converter;

    int choice;

    do
    {
        cout << "\n===== TIME CONVERTER =====" << endl;
        cout << "1. Convert Seconds to HH:MM:SS" << endl;
        cout << "2. Convert HH:MM:SS to Seconds" << endl;
        cout << "3. Exit" << endl;

        cout << "Enter your choice: ";
        cin >> choice;

        switch (choice)
        {
            case 1:
            {
                int totalSeconds;

                cout << "Enter total seconds: ";
                cin >> totalSeconds;

                converter.secondsToTime(totalSeconds);

                break;
            }

            case 2:
            {
                int h, m, s;

                cout << "Enter hours: ";
                cin >> h;

                cout << "Enter minutes: ";
                cin >> m;

                cout << "Enter seconds: ";
                cin >> s;

                TimeConverter time(h, m, s);

                cout << "Total seconds = "
                     << time.timeToSeconds()
                     << endl;

                break;
            }

            case 3:
                cout << "Exiting program..." << endl;
                break;

            default:
                cout << "Invalid choice!" << endl;
        }

    } while (choice != 3);

    return 0;
}