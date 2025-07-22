#include <iostream>
#include <string.h>

using namespace std;

class DrinkBox{
public:
    //コンストラクタ
    DrinkBox(){}
    DrinkBox{const char *str, int n1, int n2){
        name = new char[strlen(str) + 1];
        strcpy(name, str);
        price = n1;
        count = n2;
    }
    //デストラクタ
    ~DrinkBox(){
        delete [] name;
    }

    //合計金額の計算
    int GetTotalPrice(){
        return count * price;
    }
    //タイトルの表示
    void PrintTitle(){
        //¥tはタブを表す
        cout << "商品名 ¥t¥t 単価¥t 数量¥t 金額" << endl;
    }
    //商品データの表示
    void PrintData(){
        cout << name << "¥t" << price << "¥t" << count <<"¥t" << GetTotalPrice() << endl;
    }

    char *name;
    int price;
    int count;
};

class AlcholBox : public DrinkBox{
public:
    //コンストラクタ
    AlcholBox(const char *str, int n1, int n2, float f){
        name = new char[strlen(str) + 1];
        strcpy(name, str);
        price = n1;
        count = n2;
        alc = f;
    }
    void PrintTitle(){
        cout << "商品名（度数[%]）¥t 単価¥t数量¥t 金額" << endl;
    }
    void PrintData(){
        cout << name << "(" << alcper << ")¥t" << price << "¥t" << count << "¥t" << GetTotalPrice() << endl;
    }

private:
    float alcper;
};

int main()
{
      DrinkBox coffee("コーヒー", 200, 3);
      DrinkBox oolongtea("ウーロン茶", 150, 2);
      AlcholBox wine("ワイン", 300, 2, 15.0);

      cofee.PrintTitle();
      cofee.PrintData();
      oolongtea.PrintData();
      wine.PrintTitle();
      wine.PrintData();

      int sum = cofee.GetTotalPrice() + oolongtea.GetTotalPrice() + wine.GetTotalPrice();
      cout << "¥n*** 合計金額: " << sum << "円***" << endl;
      return 0;
}