//변수 선언하면서 non-null 타입으로 선언하면 초기값 지정해야..
int data1 = 10;
//nullable 로 선언하면 초기값을 주지 않아도 된다.. null 값으로 초기화 된다..
int? data2;
//late 예약어로 선언하면.. 초기화 시점을 미루겠다는 의미.. non-null 선언 가능..
late int data3;

main() {
  // data1 = null;//error..
  //nullable 로 선언하면 정상적인 데이터 및 null 대입 가능..
  //! - null 이면 에러 발생..
  data2 = 10;
  data2!;
  data2 = null;
  // data2!;//error

  bool result1 = data1.isEven;
  bool? result2 = data2?.isEven;
  bool result3 = data2?.isEven ?? false;

  //casting..
  int? data4 = data1;//non-null -> nullable
  // int data5 = data2;//error, nullable -> non-null
  int data5 = data2 as int;//명시적 캐스팅..
}