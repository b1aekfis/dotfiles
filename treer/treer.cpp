/*
    output of the directory structure graphics (tree) on Windows gives unexpected characters...
*/

#include <iostream>
#include <fstream>
#include <sstream>
#include <algorithm>

#include <locale>
#include <codecvt>

    /*
        task:

        + 002B  to  251C
        - 002D  to  2500
        \ 005C  to  2514
        | 007C  to  2502

    */

#define clsChild    '\u002B'
#define clsDash     '\u002D'
#define clsLast     '\u005C'
#define clsParent   '\u007C'

#define stdChild    L'\u251C'
#define stdDash     L'\u2500'
#define stdLast     L'\u2514'
#define stdParent   L'\u2502'

using namespace std;

int main(int argc, char *argv[]){

    if(argc<3){
        return 0;
    }

    string root_path = argv[1];
    string tree_path = argv[2];
    string com = "tree " + root_path + " /a" + " > " + tree_path;

    replace(com.begin()+5, com.end(), '\\', '/');
    system(com.c_str());
  
    /*
        steps to delete the first 3 lines in the file
    */

    ifstream ifs(tree_path);
    ofstream tmp("tmp.txt"); 

    tmp << "```\n";
    tmp << ".\n";
    string line;
    int i = 0;
    while(getline(ifs, line)){
            if(i<3){
                ++i;
            }
            else{
               tmp << line+'\n';
            }
    }

    ifs.close();

    tmp << "```\n";
    tmp.close();

    /* 
        main 
    */

    wifstream ifs_tmp("tmp.txt");

    wstringstream ss;
    ss << ifs_tmp.rdbuf();

    ifs_tmp.close();
    remove("tmp.txt"); // remove temp

    wstring s = ss.str();

    for(int i=0; i < s.size(); ++i){
        if(s[i]==clsChild && s[i+1]==clsDash && s[i+2]==clsDash && s[i+3]==clsDash){
            s[i]=stdChild;
        }
        else if(s[i]==clsDash){
            s[i]=stdDash;
        }
        else if(s[i]==clsLast){
            s[i]=stdLast;
        }
        else if(s[i]==clsParent){
            s[i]=stdParent;
        }
    }

    wofstream ofs(tree_path);
    const locale utf8_locale = locale(locale(), new codecvt_utf8<wchar_t>());
    ofs.imbue(utf8_locale);

    ofs << s;

    ofs.close();
    return 0;
}
