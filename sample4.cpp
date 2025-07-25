#include <iostream>
#include <string.h>

using namespace std;

class Student{
//カプセル化
//SetとGetはデータ取得のためアクセスを可能にするためpublicにする
//データの保管はprivateとして保護する
public:
    void SetID(int num){id = num;}
    //文字列は代入不可能のため、ポインタでアドレスを受け取り、値へのアクセスを可能にする
    //char strは先頭文字のみを示す
    //char *strとchar* strは同じだが、後者の方が読みやすい。char *strだとstrの値の取得と迷う
    void SetName(char *str){
      //文字列はname=で代入できないのでstrcpyで代入
      //strcpy(コピー元、コピー先)
      strcpy(name, str);
    }
    int GetID(){return id;}
    char *GetName() const {
        //(char *)はC言語のキャスト演算子の書き方
        //nameをchar型にキャストして、nameの文字列全体を取得している（そもそもchar型なんだがなぜ...??）
        return (char *)name;
    }
private:
    int id;
    //char型の配列を30個分確保
    //C++は文字列をString型ではなくchar型の配列で扱う
    char name[30];
};

enum Subject{Math, English, Science};

class Exam{
public:
    void SetInfo(int id, const char *name, Subject s, int num);
    int GetPoint() const {return point:}
    void GetResult(char *buf) const;
    Student student;
private:
    Subject subject;
    int point;
};

void Exam::SetInfo(int id, const char *name, Subjects s, int num)
{
  student.SetID(id);
  student.SetName(name);
  subject = s;
  point = num;
}

void Exam::GetResult(char *buf) const
{
    const char *subname[] = {"数学", "英語", "理科"};
    //フォーマット指定子（%s: %d点）をbufに代入
    //sにはsubname[subject]の文字列を、dにはpointの整数を代入
    sprintf(buf, "%s: %d点", subname[subject], point);
}

//Exam型を参照で受け取り（コピーしない）効率よく大きなデータを扱う
void PrintRessult(const Exam &Exam)
{
    cout << Exam.student.GetName() << endl;
    char buf[30];
    Exam.GetResult(buf);
    cout << buf << endl;
}

//Examを配列として扱いたいため、Exam型のポインタを受け取る
//*Examにテスト結果の点数、intにテスト結果の数を受け取る
double GetAvg(const Exam *Exam, int num)
{
  double sum = 0;
  //テスト結果の数デフォルトを0として、i<num（テスト結果が0以上）のとき、iを1ずつ増やしながらsumにテスト結果の点数を加算

  for(int i = 0; i<num; i++){
    sum += Exam[i].GetPoint();
  }
  return sum / num;
}

int main()
{
  //Exam型の配列を3つ作成
  Exam exam[3];
  exam[0].SetInfo(1, "しおり", Math, 60);
  exam[1].SetInfo(1, "しおり", Math, 75);
  exam[2].SetInfo(1, "しおり", Math, 88);

  printResult(exam[0]);
  printResult(exam[1]);
  printResult(exam[2]);
  cout << endl;
  //初めに決めた配列のサイズ以上は指定できない
  cout << "平均:" << GetAvg(Exam, 3) << "点" << endl;
  return 0;
}
