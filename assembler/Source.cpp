#include <iostream>
#include <math.h>
#include <algorithm>
#include <fstream>
#include <string>
#include <unordered_map>
#include <tuple>
#include <vector>
using namespace std;
long long index = 0;

unordered_map<string, string> regesters;
unordered_map<string, vector<string>> instructions;
unordered_map<string, string> labels;
string hexa_index[] = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"};
vector<string> memory(1 << 20, "0000000000000000");
string to_lower(string input);
void prepare_resesters();
void prepare_opcode(ifstream &InputFile);
vector<string> split_line(string &line);
vector<string> translate_line(string line);
string translate_line_index(long long);
void prepare_lables(ifstream &Inst);
void fill_inst_memory(ifstream &Inst, ofstream &MemFile);
void fill_interrupt(ofstream &MemFile);

string convert_to_binary(long long num, int size = 32);
string convert_to_hexa(long long num, int size = 8);
int main(int argc, char *argv[])
{
	ofstream MemFile("memory_test.mem");
	ifstream InputFile("ISA.txt");
	ifstream Inst(argv[1]);
	ifstream Inst_lables(argv[1]);
	/*ifstream Inst("ex1.txt");
	ifstream Inst_lables("ex1.txt");*/
	prepare_resesters();
	prepare_opcode(InputFile);
	prepare_lables(Inst_lables);
	fill_inst_memory(Inst, MemFile);

	// Close the file
	MemFile.close();
	InputFile.close();
	Inst.close();

	return 0;
}
string to_lower(string input)
{
	transform(input.begin(), input.end(), input.begin(),
			  [](unsigned char c)
			  { return std::tolower(c); });

	return input;
}
void prepare_resesters()
{
	regesters = {{"r0", "000"},
				 {"r1", "001"},
				 {"r2", "010"},
				 {"r3", "011"},
				 {"r4", "100"},
				 {"r5", "101"},
				 {"r6", "110"},
				 {"r7", "111"}};
}
void prepare_opcode(ifstream &InputFile)
{
	string line;
	while (getline(InputFile, line))
	{
		// convert the line to lower case
		line = to_lower(line);
		vector<string> splited_line = split_line(line);
		string inst = splited_line[0];
		vector<string> inst_data = {splited_line[1], splited_line[2], splited_line[3], splited_line[4]};

		instructions.insert({inst, inst_data});
	}
}
vector<string> split_line(string &line)
{
	vector<string> splited_line;
	string subString = "";
	int N = line.length();
	int i = 0;
	while (i < N)
	{
		if (line[i] == ':')
		{
			if (subString.length() > 0)
			{
				splited_line.push_back(subString);
			}
			splited_line.push_back(":");
			subString = "";
		}
		else if ((line[i] >= 'a' && line[i] <= 'z') || (line[i] <= '9' && line[i] >= '0') || (line[i] == '.'))
		{
			subString += line[i];
		}
		else if (line[i] == '#')
		{
			if (subString.length() > 0)
			{
				splited_line.push_back(subString);
				subString = "";
			}
			break;
		}
		else if (subString.length() > 0)
		{
			splited_line.push_back(subString);
			subString = "";
		}
		i++;
	}
	if (subString.length() > 0)
		splited_line.push_back(subString);
	return splited_line;
}
vector<string> translate_line(string line)
{

	vector<string> splited_line = split_line(line);
	vector<string> translated_line = vector<string>(0);
	string instruction_line = "";
	if (splited_line.size() == 0)
		return translated_line;

	for (int i = 0; i < splited_line.size(); i++)
	{
		if (splited_line[i] == ":")
		{
			splited_line.erase(splited_line.begin() + i);
			if (i)
				splited_line.erase(splited_line.begin() + i);
		}
	}
	if (instructions.find(splited_line[0]) != instructions.end())
	{
		vector<string> inst = instructions[splited_line[0]];
		instruction_line = inst[0];
		if (splited_line[0].compare("jz") == 0 || splited_line[0].compare("jn") == 0 || splited_line[0].compare("jc") == 0 || splited_line[0].compare("jo") == 0 || splited_line[0].compare("jmp") == 0 || splited_line[0].compare("jmpi") == 0 || splited_line[0].compare("call") == 0 || splited_line[0].compare("calli") == 0)
		{
			if (splited_line[0].compare("jmpi") == 0 || splited_line[0].compare("calli") == 0)
			{

				translated_line.push_back(instruction_line + "0000000");
				translated_line.push_back(convert_to_binary(stoi(splited_line[1]), 16));
			}
			else
			{
				translated_line.push_back(instruction_line + regesters[splited_line[1]] + "0" + regesters[splited_line[1]]);
			}
		}
		else
		{
			if (inst[1] == "1" && inst[3] == "0")
			{
				instruction_line += (regesters[splited_line[1]]);
				// instruction_line += " ";
				// instruction_line += "0";
				instruction_line += (inst[2] == "1") ? (splited_line.size() > 2 ? "0" + regesters[splited_line[2]] : "0" + regesters[splited_line[1]]) : "1111";
			}
			else
			{
				instruction_line += (inst[2] == "1") ? regesters[splited_line[1]] : "000";
				// instruction_line += " ";
				// instruction_line += "0";
				instruction_line += (inst[2] == "1") ? "0" + regesters[splited_line[1]] : "1111";
			}
			translated_line.push_back(instruction_line);
			if (inst[3] == "1")
			{
				string memory_value = splited_line.size() == 3 ? splited_line[2] : splited_line[1];
				char last_char = (memory_value.length() > 0) ? memory_value[memory_value.length() - 1] : 'h';
				if (last_char >= '0' && last_char <= '9')
					last_char = 'd';
				else if (last_char != 'd' && last_char != 'h' && last_char != 'b')
				{
					last_char = 'd';
					cout << "the imadiade value must be h or b or d only (the default is d)";
					throw("the imadiade value must be h or b or d only (the default is d)");
				}
				if (last_char == 'h')
					translated_line.push_back(convert_to_binary(stoi(memory_value, 0, 16), 16));

				else if (last_char == 'd')
					translated_line.push_back(convert_to_binary(stoi(memory_value, 0, 10), 16));

				else if (last_char == 'b')
					translated_line.push_back(convert_to_binary(stoi(memory_value, 0, 2), 16));
			}
		}
	}
	else if (splited_line[0] == ".org")
	{
		string memory_value = splited_line[1];
		char last_char = (memory_value.length() > 0) ? memory_value[memory_value.length() - 1] : 'h';
		if (last_char >= '0' && last_char <= '9')
			last_char = 'h';
		else if (last_char != 'd' && last_char != 'h' && last_char != 'b')
		{
			last_char = 'h';
			cout << "the imadiade value must be h or b or d only (the default is d)";
			throw("the imadiade value must be h or b or d only (the default is h)");
		}

		if (last_char == 'h')
			index = stoi(memory_value, 0, 16);

		else if (last_char == 'd')
			index = stoi(memory_value, 0, 16);

		else if (last_char == 'b')
			index = stoi(memory_value, 0, 16);
	}
	return translated_line;
}
void prepare_lables(ifstream &Inst)
{
	string line;
	index = 0;
	while (getline(Inst, line))
	{
		if (line.empty())
			continue;
		line = to_lower(line);
		vector<string> splited_line = split_line(line);
		for (long long i = 0; i < splited_line.size(); i++)
		{
			if (splited_line[i] == ".org" && splited_line.size() > i + 1)
			{
				index = stoi(splited_line[i + 1], 0, 16);
				splited_line.erase(splited_line.begin() + i);
				splited_line.erase(splited_line.begin() + i);
			}
		}
		if (splited_line.size() > 0 && (instructions.find(splited_line[0]) == instructions.end()) && (splited_line[1] == ":"))
		{
			labels.insert({splited_line[0], to_string(index)});
			splited_line.erase(splited_line.begin());
			splited_line.erase(splited_line.begin());
		}
		if (splited_line.size() > 0)
			index += 1;
	}
}
void fill_interrupt(ofstream &MemFile)
{
	long long size = (long long)(1 << 5);
	while (index < size)
	{
		memory[index] = "0000000000000000";
		index += 1;
	}
}
void fill_inst_memory(ifstream &Inst, ofstream &MemFile)
{
	index = 0;
	string line;
	while (getline(Inst, line))
	{
		line = to_lower(line);
		vector<string> out = translate_line(line);
		for (int i = 0; i < out.size(); i++)
		{
			memory[index] = out[i];
			index += 1;
		}
	}
	long long size = memory.size();
	MemFile << "// memory data file (do not edit the following line - required for mem load use)\n"
			<< "// instance=/Processor_tb/processor/InstrCache/cache\n"
			<< "// format=mti addressradix=h dataradix=b version=1.0 wordsperline=1\n";
	for (int i = size - 1; i >= 0; i--)
	{
		MemFile << translate_line_index(i) + ":\t\t" << memory[i] << endl;
	}
}
string translate_line_index(long long index)
{
	return convert_to_hexa(index);
}
string convert_to_binary(long long num, int size)
{
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
string convert_to_hexa(long long num, int size)
{
	string binary_num = convert_to_binary(num);
	string hexa_num = "";
	for (int i = 0; i < binary_num.size(); i += 4)
	{
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