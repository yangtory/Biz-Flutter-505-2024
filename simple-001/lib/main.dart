import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // home 속성으로 연결해줌
    return const MaterialApp(home: HomePage());
  }
}

// stateful 이랑 state 는 짝꿍
class HomePage extends StatefulWidget {
  const HomePage({super.key}); //생성자를 생성할떄 const 를 쓴다

  @override
  // 홈페이지스테이트를 생성해서 return해 준다 materialapp한테
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // 이 context가 showDialog context와 공유됨
    return Scaffold(
      // scaffold 는 body속성로 연결해줌
      // 나머지는 child 나 children 속성으로 연결해줌
      appBar: AppBar(
        title: const Text(
          "Simple",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        // elevation: 0.9, //appbar에 그림자
      ),
      body: const AppBody(),
      // 화면에 둥둥 떠잇음
      floatingActionButton: actionButton(),
      // 중앙에 둥둥 떠잇음
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

// future 를 이용한 alert 창 만들기
  /// 기본 Widget 이 아닌 Alert 등을 띄울때는 어떤 context 를 대상으로
  /// 실행할 것인지를 명시해 주어야 한다.
  /// flutter 에서는 context 라는 대상이 맣이 나온다.
  Future<void> _showDialog() async {
    // showDialog 띄우는데
    return showDialog(
      // context : 현재 보고있는 화면(App)
      context: context,
      // 그 위에 띄워
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("안녕"),
          content: const Text("반갑습니다"),
          actions: [
            TextButton(
              // 현재 alert popup 창 닫기
              // context 에게 확인을 보냄, 취소,확인 자리가 return 값이 됨
              onPressed: () => Navigator.pop(context, "취소"),
              child: const Text("취소"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, "확인"),
              child: const Text("확인"),
            )
          ],
        );
      },
    );
  }

  // method 로 분리햇음
  FloatingActionButton actionButton() {
    // .extended : 확장하기, customize 가능
    return FloatingActionButton.extended(
      onPressed: () => {_showDialog()},
      label: const Text("Click"),
      isExtended: true,
      icon: const Icon(
        Icons.android_rounded,
        size: 30,
      ),
      foregroundColor: Colors.white, // 글자색
      backgroundColor: Colors.red, // 바탕색
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // box radius
      ),
      elevation: 30, // 버튼 및 그림자
    );
  }
}

// widget 으로 분리햇음
class AppBody extends StatelessWidget {
  const AppBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // 화면중앙에정렬
        children: [
          Text(
            "대한민국",
            style: TextStyle(
              fontSize: 30,
              color: Colors.blue,
            ),
          ),
          Text("우리나라만세"),
          Text("Republic of Korea"),
        ],
      ),
    );
  }
}
