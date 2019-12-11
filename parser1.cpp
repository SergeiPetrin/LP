//вариант 3: преобразовать файл в формате GEDCOM в набор утверждений на языке Prolog
//с использованием предиката child(ребенок, родитель), male(человек), female(человек)

#include <iostream>
#include <string>
#include <vector>
#include <fstream>

using namespace std;
auto npos = std::string::npos;

struct person {
    string ID;
    string firstName;
    string surName;
    string sex;
};

struct family {
    string dadID = "none";
    string momID = "none";
    vector<string> childrenID;
};

person findPerson(string ID, vector<person> v) {
    for (size_t i = 0; i < v.size(); i++) {
        if (v[i].ID == ID) {
            return v[i];
        }
    }
}


int main(int argc, char* argv[])
{
    if (argc != 3) {
        cout << "Usage: ./a.out inputFile outputFile";
        exit(1);
    }
    ifstream input;
    input.open(argv[1]);
    ofstream output;
    output.open(argv[2]);

    string str;
    person p;
    family f;
    vector<person> people;
    vector<family> families;
    size_t predicateCounter = 0;

    while (getline(input, str)) {
        if (str.find("INDI") != npos) {
            size_t i = 2;
            while (str[i + 1] != '@') {
                i++;
            }
            p.ID = str.substr(3, i - 2);
            while (predicateCounter < 3) {
                if (str.find("GIVN") != npos) {
                    p.firstName = str.substr(7, npos);
                    predicateCounter++;
                }
                if (str.find("SURN") != npos) {
                    p.surName = str.substr(7, npos);
                    predicateCounter++;
                }
                if (str.find("SEX") != npos) {
                    if (str[6] == 'M') {
                        p.sex = "male";
                    } else {
                        p.sex = "female";
                    }
                    predicateCounter++;
                }
                getline(input, str);
            }
            predicateCounter = 0;
            people.push_back(p);
        }
        if (str[0] == '0' && str.find("FAM") != npos) {
            while (str.find("RIN") == npos) {
                if (str.find("HUSB") != npos) {
                    size_t i = 7;
                    while (str[i + 1] != '@') {
                        i++;
                    }
                    f.dadID = str.substr(8, i - 7);
                }
                if (str.find("WIFE") != npos) {
                    size_t i = 7;
                    while (str[i + 1] != '@') {
                        i++;
                    }
                    f.momID = str.substr(8, i - 7);
                }
                if (str.find("CHIL") != npos) {
                    size_t i = 7;
                    while (str[i + 1] != '@') {
                        i++;
                    }
                    f.childrenID.push_back(str.substr(8, i - 7));
                }
                getline(input, str);
            }
            families.push_back(f);
            f.dadID = "none";
            f.momID = "none";
            f.childrenID.clear();
        }
    }
    for (size_t i = 0; i < people.size(); i++) {
        if (people[i].sex == "male") {
            output << people[i].sex << "('" << people[i].firstName << " " << people[i].surName << "')." << endl;
        }
    }
    output << endl;
    for (size_t i = 0; i < people.size(); i++) {
        if (people[i].sex == "female") {
            output << people[i].sex << "('" << people[i].firstName << " " << people[i].surName << "')." << endl;
        }
    }
    output << endl;
    for (size_t i = 0; i < families.size(); i++) {
        person dad = findPerson(families[i].dadID, people);
        person mom = findPerson(families[i].momID, people);
        for (size_t j = 0; j < families[i].childrenID.size(); j++) {
            p = findPerson(families[i].childrenID[j], people);
            if (families[i].dadID != "none") {
                output << "child('" << p.firstName << " " << p.surName << "', '" << dad.firstName << " " << dad.surName << "')." << endl;
            }
            if (families[i].momID != "none") {
                output << "child('" << p.firstName << " " << p.surName << "', '" << mom.firstName << " " << mom.surName << "')." << endl;
            }
        }
    }
    input.close();
    output.close();
    return 0;
}

//с использованием предиката
//child(ребенок, родитель),
//male(человек),
//female(человек)
