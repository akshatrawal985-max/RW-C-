#include <iostream>
#include <string>
#include <regex>
#include <limits>
#include <stdexcept>

using namespace std;

class LibraryItem
{
private:
    string title;
    string author;
    string dueDate;
    bool checkedOut;

protected:
    void setCheckedOut(bool status)
    {
        checkedOut = status;
    }

public:
    LibraryItem(
        string title = "",
        string author = "",
        string dueDate = ""
    )
    {
        this->title = title;
        this->author = author;
        this->dueDate = dueDate;
        this->checkedOut = false;
    }

    virtual ~LibraryItem()
    {
    }

    string getTitle() const
    {
        return title;
    }

    string getAuthor() const
    {
        return author;
    }

    string getDueDate() const
    {
        return dueDate;
    }

    bool isCheckedOut() const
    {
        return checkedOut;
    }

    void setTitle(string newTitle)
    {
        if (newTitle.empty())
        {
            throw invalid_argument("Title cannot be empty.");
        }

        title = newTitle;
    }

    void setAuthor(string newAuthor)
    {
        if (newAuthor.empty())
        {
            throw invalid_argument("Author cannot be empty.");
        }

        author = newAuthor;
    }

    void setDueDate(string newDueDate)
    {
        dueDate = newDueDate;
    }

    virtual void checkOut() = 0;
    virtual void returnItem() = 0;
    virtual void displayDetails() const = 0;
};


class Book : public LibraryItem
{
private:
    string isbn;
    int quantity;

public:
    Book(
        string title,
        string author,
        string dueDate,
        string isbn,
        int quantity
    ) : LibraryItem(title, author, dueDate)
    {
        if (quantity < 0)
        {
            throw invalid_argument(
                "Book quantity cannot be negative."
            );
        }

        regex isbnPattern("^[0-9]{13}$");

        if (!regex_match(isbn, isbnPattern))
        {
            throw invalid_argument(
                "Invalid ISBN. ISBN must contain exactly 13 digits."
            );
        }

        this->isbn = isbn;
        this->quantity = quantity;
    }

    string getISBN() const
    {
        return isbn;
    }

    int getQuantity() const
    {
        return quantity;
    }

    void checkOut() override
    {
        if (isCheckedOut())
        {
            cout << "\nBook is already checked out.\n";
            return;
        }

        if (quantity <= 0)
        {
            cout << "\nBook is currently unavailable.\n";
            return;
        }

        quantity--;

        setCheckedOut(true);

        cout << "\nBook checked out successfully!\n";
        cout << "Title : " << getTitle() << endl;
    }

    void returnItem() override
    {
        if (!isCheckedOut())
        {
            cout << "\nThis book is not currently checked out.\n";
            return;
        }

        quantity++;

        setCheckedOut(false);

        cout << "\nBook returned successfully!\n";
        cout << "Title : " << getTitle() << endl;
    }

    void displayDetails() const override
    {
        cout << "\n----------------------------------------\n";
        cout << "Type       : Book\n";
        cout << "Title      : " << getTitle() << endl;
        cout << "Author     : " << getAuthor() << endl;
        cout << "Due Date   : " << getDueDate() << endl;
        cout << "ISBN       : " << isbn << endl;
        cout << "Quantity   : " << quantity << endl;

        if (isCheckedOut())
        {
            cout << "Status     : Checked Out\n";
        }
        else
        {
            cout << "Status     : Available\n";
        }

        cout << "----------------------------------------\n";
    }
};


class DVD : public LibraryItem
{
private:
    int duration;

public:
    DVD(
        string title,
        string author,
        string dueDate,
        int duration
    ) : LibraryItem(title, author, dueDate)
    {
        if (duration <= 0)
        {
            throw invalid_argument(
                "DVD duration must be greater than 0."
            );
        }

        this->duration = duration;
    }

    int getDuration() const
    {
        return duration;
    }

    void checkOut() override
    {
        if (isCheckedOut())
        {
            cout << "\nDVD is already checked out.\n";
            return;
        }

        setCheckedOut(true);

        cout << "\nDVD checked out successfully!\n";
        cout << "Title : " << getTitle() << endl;
    }

    void returnItem() override
    {
        if (!isCheckedOut())
        {
            cout << "\nThis DVD is not currently checked out.\n";
            return;
        }

        setCheckedOut(false);

        cout << "\nDVD returned successfully!\n";
        cout << "Title : " << getTitle() << endl;
    }

    void displayDetails() const override
    {
        cout << "\n----------------------------------------\n";
        cout << "Type       : DVD\n";
        cout << "Title      : " << getTitle() << endl;
        cout << "Author     : " << getAuthor() << endl;
        cout << "Due Date   : " << getDueDate() << endl;
        cout << "Duration   : " << duration << " minutes" << endl;

        if (isCheckedOut())
        {
            cout << "Status     : Checked Out\n";
        }
        else
        {
            cout << "Status     : Available\n";
        }

        cout << "----------------------------------------\n";
    }
};


class Magazine : public LibraryItem
{
private:
    int issueNumber;

public:
    Magazine(
        string title,
        string author,
        string dueDate,
        int issueNumber
    ) : LibraryItem(title, author, dueDate)
    {
        if (issueNumber <= 0)
        {
            throw invalid_argument(
                "Issue number must be greater than 0."
            );
        }

        this->issueNumber = issueNumber;
    }

    int getIssueNumber() const
    {
        return issueNumber;
    }

    void checkOut() override
    {
        if (isCheckedOut())
        {
            cout << "\nMagazine is already checked out.\n";
            return;
        }

        setCheckedOut(true);

        cout << "\nMagazine checked out successfully!\n";
        cout << "Title : " << getTitle() << endl;
    }

    void returnItem() override
    {
        if (!isCheckedOut())
        {
            cout << "\nThis magazine is not currently checked out.\n";
            return;
        }

        setCheckedOut(false);

        cout << "\nMagazine returned successfully!\n";
        cout << "Title : " << getTitle() << endl;
    }

    void displayDetails() const override
    {
        cout << "\n----------------------------------------\n";
        cout << "Type       : Magazine\n";
        cout << "Title      : " << getTitle() << endl;
        cout << "Author     : " << getAuthor() << endl;
        cout << "Due Date   : " << getDueDate() << endl;
        cout << "Issue No.  : " << issueNumber << endl;

        if (isCheckedOut())
        {
            cout << "Status     : Checked Out\n";
        }
        else
        {
            cout << "Status     : Available\n";
        }

        cout << "----------------------------------------\n";
    }
};


class Library
{
private:
    static const int MAX_ITEMS = 100;

    LibraryItem* libraryItems[MAX_ITEMS];

    int itemCount;

public:
    Library()
    {
        itemCount = 0;

        for (int i = 0; i < MAX_ITEMS; i++)
        {
            libraryItems[i] = nullptr;
        }
    }

    ~Library()
    {
        for (int i = 0; i < itemCount; i++)
        {
            delete libraryItems[i];
            libraryItems[i] = nullptr;
        }
    }

    void addItem(LibraryItem* item)
    {
        if (item == nullptr)
        {
            throw invalid_argument(
                "Cannot add a null item."
            );
        }

        if (itemCount >= MAX_ITEMS)
        {
            throw runtime_error(
                "Library is full."
            );
        }

        libraryItems[itemCount] = item;
        itemCount++;

        cout << "\nItem added successfully!\n";
    }

    void displayAllItems()
    {
        if (itemCount == 0)
        {
            cout << "\nNo items available in library.\n";
            return;
        }

        cout << "\n\n========================================\n";
        cout << "          ALL LIBRARY ITEMS\n";
        cout << "========================================\n";

        for (int i = 0; i < itemCount; i++)
        {
            cout << "\nItem ID : " << i + 1;

            libraryItems[i]->displayDetails();
        }
    }

    void searchItem(string keyword)
    {
        if (keyword.empty())
        {
            throw invalid_argument(
                "Search keyword cannot be empty."
            );
        }

        bool found = false;

        cout << "\n\n========== SEARCH RESULT ==========\n";

        for (int i = 0; i < itemCount; i++)
        {
            string title = libraryItems[i]->getTitle();
            string author = libraryItems[i]->getAuthor();

            if (
                title.find(keyword) != string::npos ||
                author.find(keyword) != string::npos
            )
            {
                cout << "\nItem ID : " << i + 1;

                libraryItems[i]->displayDetails();

                found = true;
            }
        }

        if (!found)
        {
            cout << "\nNo item found for : "
                 << keyword << endl;
        }
    }

    void checkoutItem(int id)
    {
        if (id < 1 || id > itemCount)
        {
            throw out_of_range(
                "Invalid Item ID."
            );
        }

        libraryItems[id - 1]->checkOut();
    }

    void returnItem(int id)
    {
        if (id < 1 || id > itemCount)
        {
            throw out_of_range(
                "Invalid Item ID."
            );
        }

        libraryItems[id - 1]->returnItem();
    }

    void removeItem(int id)
    {
        if (id < 1 || id > itemCount)
        {
            throw out_of_range(
                "Invalid Item ID."
            );
        }

        delete libraryItems[id - 1];

        for (int i = id - 1; i < itemCount - 1; i++)
        {
            libraryItems[i] = libraryItems[i + 1];
        }

        libraryItems[itemCount - 1] = nullptr;

        itemCount--;

        cout << "\nItem removed successfully!\n";
    }
};


int getInteger(string message)
{
    int value;

    while (true)
    {
        cout << message;

        cin >> value;

        if (cin.fail())
        {
            cin.clear();

            cin.ignore(
                numeric_limits<streamsize>::max(),
                '\n'
            );

            cout << "\nInvalid input!";
            cout << " Please enter a number.\n";
        }
        else
        {
            cin.ignore(
                numeric_limits<streamsize>::max(),
                '\n'
            );

            return value;
        }
    }
}


string getString(string message)
{
    string value;

    cout << message;

    getline(cin, value);

    return value;
}


int main()
{
    Library library;

    int choice;

    cout << "\n";
    cout << "============================================\n";
    cout << "       LIBRARY MANAGEMENT SYSTEM\n";
    cout << "============================================\n";

    try
    {
        library.addItem(
            new Book(
                "C++ Programming",
                "Bjarne Stroustrup",
                "30-08-2026",
                "1234567890123",
                5
            )
        );

        library.addItem(
            new Book(
                "Clean Code",
                "Robert Martin",
                "05-09-2026",
                "9876543210987",
                3
            )
        );

        library.addItem(
            new DVD(
                "C++ Tutorial",
                "Programming Academy",
                "01-09-2026",
                120
            )
        );

        library.addItem(
            new Magazine(
                "Technology Today",
                "Tech Publisher",
                "10-09-2026",
                25
            )
        );
    }
    catch (exception& e)
    {
        cout << "\nError : "
             << e.what() << endl;
    }

    do
    {
        cout << "\n\n";
        cout << "============================================\n";
        cout << "                 MAIN MENU\n";
        cout << "============================================\n";

        cout << "1. Display All Items\n";
        cout << "2. Search Item\n";
        cout << "3. Check Out Item\n";
        cout << "4. Return Item\n";
        cout << "5. Add Book\n";
        cout << "6. Add DVD\n";
        cout << "7. Add Magazine\n";
        cout << "8. Remove Item\n";
        cout << "9. Exit\n";

        cout << "============================================\n";

        choice = getInteger(
            "Enter your choice : "
        );

        try
        {
            if (choice == 1)
            {
                library.displayAllItems();
            }
            else if (choice == 2)
            {
                string keyword;

                keyword = getString(
                    "\nEnter title or author : "
                );

                library.searchItem(keyword);
            }
            else if (choice == 3)
            {
                int id;

                id = getInteger(
                    "\nEnter Item ID to checkout : "
                );

                library.checkoutItem(id);
            }
            else if (choice == 4)
            {
                int id;

                id = getInteger(
                    "\nEnter Item ID to return : "
                );

                library.returnItem(id);
            }
            else if (choice == 5)
            {
                string title;
                string author;
                string dueDate;
                string isbn;
                int quantity;

                cout << "\n";
                cout << "============================================\n";
                cout << "                 ADD BOOK\n";
                cout << "============================================\n";

                title = getString(
                    "Enter title : "
                );

                author = getString(
                    "Enter author : "
                );

                dueDate = getString(
                    "Enter due date : "
                );

                isbn = getString(
                    "Enter ISBN-13 : "
                );

                quantity = getInteger(
                    "Enter quantity : "
                );

                library.addItem(
                    new Book(
                        title,
                        author,
                        dueDate,
                        isbn,
                        quantity
                    )
                );
            }
            else if (choice == 6)
            {
                string title;
                string author;
                string dueDate;
                int duration;

                cout << "\n";
                cout << "============================================\n";
                cout << "                 ADD DVD\n";
                cout << "============================================\n";

                title = getString(
                    "Enter title : "
                );

                author = getString(
                    "Enter author : "
                );

                dueDate = getString(
                    "Enter due date : "
                );

                duration = getInteger(
                    "Enter duration in minutes : "
                );

                library.addItem(
                    new DVD(
                        title,
                        author,
                        dueDate,
                        duration
                    )
                );
            }
            else if (choice == 7)
            {
                string title;
                string author;
                string dueDate;
                int issueNumber;

                cout << "\n";
                cout << "============================================\n";
                cout << "              ADD MAGAZINE\n";
                cout << "============================================\n";

                title = getString(
                    "Enter title : "
                );

                author = getString(
                    "Enter author : "
                );

                dueDate = getString(
                    "Enter due date : "
                );

                issueNumber = getInteger(
                    "Enter issue number : "
                );

                library.addItem(
                    new Magazine(
                        title,
                        author,
                        dueDate,
                        issueNumber
                    )
                );
            }
            else if (choice == 8)
            {
                int id;

                id = getInteger(
                    "\nEnter Item ID to remove : "
                );

                library.removeItem(id);
            }
            else if (choice == 9)
            {
                cout << "\n";
                cout << "============================================\n";
                cout << "Thank you for using Library Management System!\n";
                cout << "============================================\n";
            }
            else
            {
                cout << "\nInvalid choice!";
                cout << " Please select 1 to 9.\n";
            }
        }
        catch (invalid_argument& e)
        {
            cout << "\nInvalid Argument Exception : ";
            cout << e.what() << endl;
        }
        catch (out_of_range& e)
        {
            cout << "\nOut of Range Exception : ";
            cout << e.what() << endl;
        }
        catch (runtime_error& e)
        {
            cout << "\nRuntime Exception : ";
            cout << e.what() << endl;
        }
        catch (exception& e)
        {
            cout << "\nGeneral Exception : ";
            cout << e.what() << endl;
        }

    } while (choice != 9);

    return 0;
}