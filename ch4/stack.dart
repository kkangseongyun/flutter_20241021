import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

//각 카드의 데이터..
class DataVO {
  String image;
  String title;
  String date;
  String content;
  String location;

  DataVO(this.image, this.title, this.date, this.content, this.location);
}

List<DataVO> datas = [
  DataVO('images/lab_lotte_1.jpg', '롯데웨딩위크', '각 지점 본 매장', '2.14(금) ~ 2.23(일)',
      '백화점 전점'),
  DataVO('images/lab_lotte_2.jpg', 'LG TROMM 스타일러', '각 지점 본 매장',
      '2.14(금) ~ 2.29(토)', '백화점 전점'),
  DataVO(
      'images/lab_lotte_3.jpg', '금양와인 페스티발', '본매장', '2.15(토) ~ 2.20(목)', '잠실점'),
  DataVO('images/lab_lotte_4.jpg', '써스데이 아일랜드', '본 매장', '2.17(월) ~ 2.23(일)',
      '잠실점'),
  DataVO('images/lab_lotte_5.jpg', '듀풍클래식', '본 매장', '2.21(금) ~ 3.8(일)', '잠실점'),
];

//하나의 이벤트 화면 위젯..
class CardADWidget extends StatelessWidget {
  DataVO vo;
  CardADWidget(this.vo);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.pink,
        ),
        Align(
          alignment: Alignment(0.0, 0.0),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(vo.image, width: 350,),
                  Container(
                    width: 350,
                    height: 100,
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(vo.title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                        Spacer(),
                        Text(vo.content),
                        Text(vo.date)
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                left: 30,
                bottom: 90,
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.black,
                  child: Text(vo.location, style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

//ViewPage - 손가락 따라가면서 순서대로 화면 전환..
class MyWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyWidgetState();
  }
}

class MyWidgetState extends State<MyWidget> {
  //데이터 갯수 만큼.. CardADWidget 생성하는 함수..
  List<CardADWidget> makePagerWidgets() {
    return datas.map((vo){
      return CardADWidget(vo);
    }).toList();
  }

  //ViewPage 에 지정할 controller.. 이 설정대로 ViewPage 가 나오게 되고..
  //ViewPage 에서 유저가 조정한 화면 정보가 controller 에 들어오게 된다..
  PageController controller = PageController(
    initialPage: 0,
    viewportFraction: 0.9,//현재 뜨는 화면에 이전, 이후 화면을 어느정보 같이 뿌릴 것인가?
    //1,0 으로 설정하면 현재 화면만 보인다.. 숫자가 작을 수록 이전, 이후 화면이 크게 보인다..
  );

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(//손가락 따라 화면 순서대로 전환하는 위젯..
            controller: controller,//controller 설정대로 화면이 나오고.. viewpage 조정 값을 controller 에 지정
            //이 controller 를 indicator 에 설정하면.. indicator 가 조정되낟..
            children: makePagerWidgets(),
          ),
        ),
        SmoothPageIndicator(
            controller: controller,
            count: 5,
            effect: WormEffect(
              dotColor: Colors.white,
              activeDotColor: Colors.indigo,
            ),

        ),
        SizedBox(height: 32.0,)
      ],
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Layout Test'),
        ),
        body: SafeArea(//디바이스의 특징에(노치, 라운드) 의해 앱의 화면이 정상적으로 나오기 힘들때.. 사용.. 최대한 디바이스
          //에서 앱의 화면이 정상적으로 나오게 처리해 준다..
            child: Container(
              color: Colors.pink,
              child: MyWidget(),
            )
        ),
      ),
    );
  }
}

