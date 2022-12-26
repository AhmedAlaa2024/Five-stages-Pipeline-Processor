#include <iostream>
#include <math.h>
#include <algorithm>
#include <fstream>
#include <string>
#include <unordered_map>
#include <tuple>
#include <vector>
using namespace std;
unordered_map<string, string> regesters;
unordered_map<string, vector<string>> instructions;
unordered_map<string, string>labels;
string hexa_index[] = { "0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F" };
vector<string> memory(1 << 19, "");
/// <summary>
/// 
/// </summary>
/// <param name="input"></param>
/// <returns></returns>
string to_lower(string input);
void prepare_resesters();
void prepare_opcode(ifstream& InputFile);
vector<string> split_line(string& line);
vector<string> translate_line(string line, long long index);
string translate_line_index(long long);
void prepare_lables(ifstream& Inst);
void fill_inst_memory(ifstream& Inst, ofstream& MemFile);
void fill_interrupt(ofstream& MemFile);

string convert_to_binary(long long num, int size = 32);
string convert_to_hexa(long long num, int size = 8);

int main(int argc, char* argv[]) {
	ofstream MemFile("memory_test.mem");
	ifstream InputFile("ISA.txt");
	ifstream Inst(argv[1]);
	ifstream Inst_lables(argv[1]);
	prepare_resesters();
	prepare_opcode(InputFile);
	prepare_lables(Inst_lables);
	fill_interrupt(MemFile);
	fill_inst_memory(Inst, MemFile);

	// Close the file
	MemFile.close();
	InputFile.close();
	Inst.close();

	return 0;

}
string to_lower(string input) {
	transform(input.begin(), input.end(), input.begin(),
		[](unsigned char c) { return std::tolower(c); });

	return input;

}
void prepare_resesters() {
	regesters = { {"r0","000"},
		{ "r1", "001" },
		{ "r2", "010" },
		{ "r3", "011" },
		{ "r4", "100" },
		{ "r5", "101" },
		{ "r6", "110" },
		{ "r7", "111" }
	};

}
void prepare_opcode(ifstream& InputFile) {
	string line;
	while (getline(InputFile, line)) {
		// convert the line to lower case
		line = to_lower(line);
		vector<string>splited_line = split_line(line);
		string inst = splited_line[0];
		vector<string> inst_data = { splited_line[1],splited_line[2],splited_line[3],splited_line[4] };

		instructions.insert({ inst,inst_data });
	}
}
vector<string> split_line(string& line) {
	vector<string>splited_line;
	string subString = "";
	int N = line.length();
	int i = 0;
	while (i < N)
	{
		if (line[i] == ':') {
			if (subString.length() > 0) {
				splited_line.push_back(subString);
			}
			splited_line.push_back(":");
			subString = "";

		}
		else if ((line[i] >= 'a' && line[i] <= 'z') || (line[i] <= '9' && line[i] >= '0')) {
			subString += line[i];
		}
		else if (subString.length() > 0) {
			splited_line.push_back(subString);
			subString = "";
		}
		i++;
	}
	if (subString.length() > 0)
		splited_line.push_back(subString);
	return splited_line;
}
vector<string> translate_line(string line, long long index) {

	vector<string>splited_line = split_line(line);
	vector<string> translated_line = vector<string>(0);
	string instruction_line = "";
	if (splited_line.size() == 0)
		return vector<string>(0);
	if ((instructions.find(splited_line[0]) == instructions.end()) && (splited_line[1] == ":"))
	{
		splited_line.erase(splited_line.begin());
		splited_line.erase(splited_line.begin());
	}
	if (splited_line.size() > 0 && instructions.find(splited_line[0]) != instructions.end())
	{
		vector<string> inst = instructions[splited_line[0]];
		instruction_line = inst[0] + "   ";
		if (splited_line[0] == "jz" || splited_line[0] == "jn" || splited_line[0] == "jc" || splited_line[0] == "jo" || splited_line[0] == "jmp" || splited_line[0] == "jmpi" || splited_line[0] == "call" || splited_line[0] == "calli") {
			if (splited_line[0] == "jmpi" || splited_line[0] == "calli") {

				translated_line.push_back(instruction_line + "0000000");
				translated_line.push_back(convert_to_binary(stoi(labels[splited_line[1]]), 16));
			}
			else {
				translated_line.push_back(instruction_line + "0000" + regesters[splited_line[1]]);
			}
		}
		else {
			if (inst[1] == "1" && inst[3] == "0")
			{
				instruction_line += ("0" + regesters[splited_line[1]]);
			}
			else if (inst[1] == "0" && inst[2] == "1" && inst[3] == "0") {
				instruction_line += ("0" + regesters[splited_line[1]]);
			}
			else {
				instruction_line += "0000";
			}
			instruction_line += (inst[2] == "1") ? (splited_line.size() > 2 ? regesters[splited_line[2]] : regesters[splited_line[1]]) : "000";
			translated_line.push_back(instruction_line);
			if (inst[3] == "1")
			{
				translated_line.push_back(convert_to_binary(stoi(splited_line[1]), 16));
			}
		}
	}
	return translated_line;

}
void prepare_lables(ifstream& Inst) {
	string line;
	long long index = (long long)(1 << 5);
	while (getline(Inst, line)) {
		if (line.empty())continue;
		line = to_lower(line);
		vector<string> splited_line = split_line(line);
		if ((instructions.find(splited_line[0]) == instructions.end()) && (splited_line[1] == ":"))
		{
			labels.insert({ splited_line[0] ,to_string(index) });
		}
		index += 2;
	}
}
void fill_interrupt(ofstream& MemFile) {
	long long index = 0;
	long long size = (long long)(1 << 5);
	while (index < size)
	{
		//MemFile << translate_line_index(index) + ":\t\t" + "0000000000000000" << endl;
		memory[index / 2] = translate_line_index(index) + ":\t\t" + "0000000000000000";

		index += 2;
	}
}
void fill_inst_memory(ifstream& Inst, ofstream& MemFile) {
	string line;
	long long index = (long long)(1 << 5);
	while (getline(Inst, line)) {
		line = to_lower(line);
		vector<string> out = translate_line(line, index);
		for (int i = 0; i < out.size(); i++) {
			//MemFile << translate_line_index(index) + ":\t\t" + out[i] << endl;
			memory[index / 2] = translate_line_index(index) + ":\t\t" + out[i];
			index += 2;
		}
	}
	long long size = (long long)(1 << 20);
	//long long size = 200;
	string end_line = "";
	long long max = end_line.max_size();
	while (index < size)
	{
		//MemFile << translate_line_index(index) + ":\t\t" + "0000000000000000" << endl;;
		memory[index / 2] = translate_line_index(index) + ":\t\t" + "0000000000000000";
		index += 2;
	}
	MemFile << "// memory data file (do not edit the following line - required for mem load use)\n" <<
		"// instance=/Processor_tb/processor/InstrCache/cache\n" <<
		"// format=mti addressradix=h dataradix=b version=1.0 wordsperline=1\n";
	for (int i = ((1 << 19) - 1); i > 0; i--)
	{
		MemFile << memory[i] << endl;

	}

	MemFile << memory[0];

}
string translate_line_index(long long index) {
	return convert_to_hexa(index);
}
string convert_to_binary(long long num, int size) {
	string binary_num = "";
	while (num != 0)
	{
		binary_num = to_string(num % 2) + binary_num;
		num /= 2;
	}
	int empty_size = size - binary_num.size();
	while (empty_size)
	{
		binary_num = "0" + binary_num;
		empty_size = empty_size - 1;
	}
	return binary_num;
}

string convert_to_hexa(long long num, int size) {
	string binary_num = convert_to_binary(num);
	string hexa_num = "";
	for (int i = 0; i < binary_num.size(); i += 4) {
		int sub_binary_num = stoi(binary_num.substr(i, 4));
		int sub_decimal_num = (sub_binary_num % 10);
		sub_binary_num /= 10;
		sub_decimal_num += 2 * (sub_binary_num % 10);
		sub_binary_num /= 10;
		sub_decimal_num += 4 * (sub_binary_num % 10);
		sub_binary_num /= 10;
		sub_decimal_num += 8 * (sub_binary_num % 10);
		hexa_num += hexa_index[sub_decimal_num];
	}
	return hexa_num;
}