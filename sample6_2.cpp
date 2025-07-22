#include <iostream>

using namespace std;

//基底（親）クラスFigure
class Figure{
public:
    //面積（純粋仮想関数）
    virtual void area() = 0;
    //外周
    virtual void around() = 0;

    void GetMeasure(){
        area();
        around();
    }
};

//派生（子）クラスSquare
class Square : public Figure{
public:
    Square(double s);
    Square(double s, double h);
    void area(){
        cout << "四角形の面積: " << side * side << endl;
    }
    void around(){
        cout << "四角形の外周: " << 2 * (side + height) << endl;
    }

private:
    double side;
    double height;
};

//Squareクラスのコンストラクタ
Square::Square(double s){
    side = heigth = s;
}

Square::Square(double s, double h){
    side = s;
    height = h;
}

//派生（子）クラスCircle
class Circle : public Figure{
public:
    Circle(double r);
    void area(){
        cout << "円の面積: " << radius * radius * pi << endl;
    }
    void around(){
        cout << "円の外周: " << 2 * (radius * pi) << endl;
    }
private:
    const double pi;
    double radius;;
};

//Circleクラスのコンストラクタ
Circle::Circle(double r):pi(3.14){
    radius = r;
}

int main(){
    Figure *pFig1;
    Figure *pFig2;
    Figure *pFig3;

    Square mySquare1(2.5);
    Square mySquare2(2.3, 3.7);
    Circle myCircle3(3.6);

    pFig1 = &mySquare1;
    pFig2 = &mySquare2;
    pFig3 = &myCircle;

    pFig1->GetMeasure();
    pFig2->GetMeasure();
    pFig3->GetMeasure();

    return 0;
}
