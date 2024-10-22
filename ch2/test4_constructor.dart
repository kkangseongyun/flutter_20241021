class User {
  String? name;
  int? age;

  //매개변수로 멤버 초기화..
  // User(String name, int age){
  //   this.name = name;
  //   this.age = age;
  // }

  // User(this.name, this.age);

  User(String name, int age): this.name = name.toUpperCase(), this.age = age * 10;

  //생성자를 여러개 선언한다면 이름을 추가해서 named constructor 로..
  User.one(){
    name = 'kim';
    age = 20;
  }
  User.two(String name, int age): this.one();
}

//singleton....
class Singleton {
  int? data;
  //생성자는 있어야 객체가 생성된다. 단지 외부에서 생성할 수 없게 한다..
  Singleton._privateConstructor();
  static final Singleton _instance = Singleton._privateConstructor();
  factory Singleton() => _instance;
}

main(){
  User user1 = new User('kim', 10);
  User user2 = User.one();
  User user3 = User.two('lee', 20);

  Singleton obj1 = Singleton();
  Singleton obj2 = Singleton();
  obj1.data = 10;
  obj2.data = 20;
  print('${obj1.data}, ${obj2.data}');//20, 20
}