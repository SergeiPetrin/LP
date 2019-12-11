#include <iostream>
#include <iomanip>
#include <fstream>
#include <map>
#include <vector>
#include <string>

using namespace std;

struct Family { 
	string Child;
	string Mother;
	string Father;
};

void clear_family(Family& family) { 
	family.Child.clear();
	family.Mother.clear();
	family.Father.clear();
}

void GeneratePred(const vector<Family>& families, ofstream& output) { 
	for (const auto& item : families) {
		string pred = "parents(" + item.Child + ", " + item.Father + ", " + item.Mother + ")";
		output << pred << endl;
	}
}

int main() {
	map<string, string> persons; // ñëîâàðü ñ ïàðîé id - èìÿ
	vector<Family> families;
	string id;
	string person; // ñ÷èòûâàåìîå èìÿ, êîòîðîå çàòåì áóäåò äîáàâëåíî â persons
	Family family;

	ifstream input("C:\\Users\\User\\Downloads\\tree.ged");
	ofstream output("prolog.txt");
	string line; // ïåðåìåííàÿ, â êîòîðóþ áóäåì ñ÷èòûâàòü
	if (input) {
		while (getline(input, line)) {
			if (line[0] == '0' && line[12] == 'I') {
				id.clear();
				person.clear();
				GET_LINE(3)
			} else if (line.substr(0, 6) == "1 NAME") {
				person = line.substr(7);
				persons[id] = person;
			} else if (line.substr(0, 4) == "0 @F") {
				id.clear();
				clear_family(family);
			} else if (line.substr(0, 6) == "1 HUSB") {
				GET_LINE(8)
				family.Father = persons.at(id);
			} else if (line.substr(0, 6) == "1 WIFE") {
				GET_LINE(8);
				family.Mother = persons.at(id);
			} else if (line.substr(0, 6) == "1 CHIL") {
				GET_LINE(8)
				family.Child = persons.at(id);
				families.push_back(family);
			}
		}
	} else {
		cout << "Input the correct path" << endl;
	}

	GeneratePred(families, output);
	cout << "Done!" << endl;
	return 0;
}
