import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //오른쪽 상단 debug 없애기
      debugShowMaterialGrid: false, //grid 만들기
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

//s 입력하고 stateful 자동완성 하기
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// State<> 클래스에 선언된 변수 중 final, const 가 부착되지 않으면
  /// 이 변수는 자동으로 state변수 가 된다.
  /// setState() 함수를 통하여 값을 변경하고,
  /// 변경된 변수는 필요한 곳에서 변화되어 표시된다.
  int _num = 0;
  void clickHandler() {
    setState(() => _num++);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "안녕하세요",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // class 변수
          children: [
            Text(
              "$_num", // 이거출력해 (state변수임)
              style: const TextStyle(fontSize: 30),
            ),
            const Text("대한민국"),
            const Text("우리나라"),
            const Text("Republic of Korea"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: clickHandler, // clickHandler
        child: const Icon(Icons.add),
      ),
    );
  }
}
