import 'package:flutter/material.dart';

void main() {
  runApp(const App()); // class 호출이아님 밑의 생성자 호출중
}

/// App 화면의 전체적인 Layout 을 구성하는 class
/// 변화가 없는 text, image 등을 표현하거나
/// StatefulWidget 을 포함하는 Layout class 이다.
class App extends StatelessWidget {
  const App({super.key});

  @override //build 는 StatelessWidget으로부터 만들어짐
  Widget build(BuildContext context) {
    // throw UnimplementedError(); // 강제로 exception 발생시킴
    return const MaterialApp(
      title: "안녕하세요",
      home: Scaffold(
          body: Column(
        children: [
          Text(
            "우리나라만세",
            style: TextStyle(fontSize: 30),
          ),
          Text(
            "대한민국만세",
            style: TextStyle(fontSize: 30),
          ),
          Text(
            "Republic of Korea",
            style: TextStyle(fontSize: 30),
          ),
        ],
      )), //homepage build
    ); //함수앞에 const = 읽기전용
  }
}

/// 화면의 구체적인 기능을 수행할 Widget 을 포함하는 class
/// State 클래스를 생성하는 일을 수행
/// State 클래스들을 관리하는 역할 수행
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  // _Homepage create
  // State<StatefulWidget> createState() {
  //   return _Homepage();
  // } 아래와 같다.
  State<StatefulWidget> createState() => _Homepage();
}

/// 화면을 구현하는 구체적인 역할 수행
/// 변화하는 Text,이미지 등을 표현한다.
/// 언더바(_) 가 부착된 함수, 변수, 클래스 등은 private 특성을 가진다.
class _Homepage extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    // Scaffold() 위젯의 틀을 만드는 칭구
    // Text() 문자열 표시하는 위젯
    return const Scaffold(
      body: Center(
        // json 코드와 비슷, {} 없음
        child: Text(
          "반갑습니다",
          style: TextStyle(fontSize: 50, color: Colors.blue),
        ),
      ),
    );
  }
}
