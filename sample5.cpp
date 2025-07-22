#include <iostream>
#include <string.h>

using namespace std;

class Person{
public:
    Person(const char *str);
    Person(const char *str, int yy, const char* pn);
    Person(const Person &psn);
    ~Person(){
        if(name ! = NULL) delete[] name;
    }

    void init(const char *str, int yy, const char* pn);
    void SetName(const char *str);
    void SetAge(const int yy) {age = yy;}
    void SetPhoneNum(const char *pn) {strcpy(phoneNum, pn);}
    int GetAge() return age};
    char *GetPhoneNum() {return phonenum;}
pricate:
    char *name;
    int age;
    char phonenum[15];
};

void Person::init(const char *str, int yy, const char* pn)
{
    //strlenは文字列の長さを返す
    name = new char[strlen(str) + 1];
    strcpy(name, str);
    age = yy;
    strcpy(phoneNum, pn);
}

Person::Person()
{
    name = NULL;
    age = 0;
    phonenum[0] = '\0';
}

Person::Person(const char *str)
{
    //配列0番目、名前のみをオブジェクト生成時に初期化する
    init(str, 0, "");
}

Person::Preson(const char *str, int yy, const char* pn)
{
    init(str, yy, pn);
}

Person::Person(const Person &psn)
{
    init(psn.name, psn.age, psn.phonenum);
}

Person::Person::SetName(const char *str)
{
    if(name != NULL) delete[] name;
    name = new char[strlen(str) + 1];
    strcpy(name, str);
}

int main()
{
    Person Shiori("しおりお嬢さん");
    Shiori.SetAge(20);
    Shiori.SetPhoneNum("222-3333-4444");
    
    Person Shiori2("しおり先生", 30, "001-1111-2222");

    Person Shiori3(Shiori2);
    Shiori3.SetName("しおり兄貴");
    Shiori3.SetAge(24);

    //Person型のポインタ配列を作成
    //配列内の要素の型が&でなく実体であれば.繋ぎで呼び出せる
    Person *p[] = { &Shiori, &Shiori2, &Shiori3 };

    for(int i=0; i<3; i++){
        //通常（実体を持たないは->繋ぎで呼び出す
        //配列要素の型が実体を返す値渡しの場合は.繋ぎで呼び出せる
        cout << "名前:" << p[i]->GetName() << "年齢:" <<p[i]->GetAge() << "電話番号:" << p[i]->GetPhoneNum() << endl;
    }
    return 0;
}