import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timer/dash_page.dart';
import 'package:timer/home_page.dart';
import 'package:timer/setting_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key}); //App 클래스 생성자

  // 기본적인 틀
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //오른쪽 상단 debug 없애기
      // primarySwatch : 기본색상, 지정할수 없는 색상도있다, 근데 이거 안먹음
      theme: ThemeData(primarySwatch: Colors.amber),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _pageIndex = 1;
  int workTimer = 20;

  /// Future
  /// promise(약속) 이 함수를 실행하면 어떤 결과를 반드시 얻을 수 있다
  /// 이 함수를 실행하면 String 문자열의 무언가를 반드시 얻을 수 있다
  Future<String> getWorkTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // dart 에서는 변수에 null 을 원칙적으로 허용하지 않는다
    // 하지만 불가항력적으로 어쩔수 없이 null 이 발생할수 있다
    // 이럴때는 변수를 String?(null safe 방식)으로 선언해야 한다
    String? workTime = prefs.getString("workTime");

    /// 이 함수의 return type Future<String> 으로 NonNullable 이다
    /// 이럴때는 만약 return 하는 workTime 의 값이 null 일경우
    /// 대체 문자열을 return 하도록 한다
    // 만약 workTime 값이 null 이면 문자열 "20" 을 return 하라
    return workTime ?? "25";
  }

  @override
  void initState() {
    super.initState();
    try {
      // async 가 설정된 함수는 반드시 await 로 호출 사용을 해야한다
      // 함수를 실행할 때 await 를 사용하려면 함수 본체(initState()) 에
      // async 키워드가 부착되어야 한다.
      // 그런데 @override 함수는 원형을 변경하지 않는 것이 좋다.
      // initState() 함수도 상속받은 클래스의 함수를 재정의(@override)한 것으로
      // 함수의 원형을 변경하지 않을것이다.
      // 그러면 async 함수인 getWorkTime 을 어떻게 사용해야 할까?
      // 이 때 함수 chainning 을 이용한 .then() 함수를 사용하여 결과를
      // 처리한다.

      // getWorkTime 이 완전히 실행되고 value 를 then한테 전달
      // .then() 함수는 getWorkTime() 함수가 완료되어 return 값이 발생하면
      // value 매개변수에 값을 받아 내부의 함수를 실행한다.
      getWorkTime().then((value) {
        setState(() {
          workTimer = int.parse(value);
        });

        // final result = getWorkTime();
        // setState(() {
        //   workTimer = result
        // });
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future setWorkTime(value) async {
    /// 싱글톤 방식 : 필요한 자원을 한 번만 만들어서 공유하자
    /// 제한된 resource(장치, 저장소, 네트워크 등)를
    /// 한 번만 생성하여 사용할 때는 공유하는 개념
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("workTime", value); // workTime 이라는 이름으로 value 값을 저장해
  }

//textfiled 안의 값은 문자열이기때문에 매개변수 String
  void onChangeSetting(String value) async {
    if (value.length > 3) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(value)));
    }

    // 정규식을 이용하여 입력된 값에 숫자 (0~9) 이외의 문자열이 있으면
    // ''으로 만들어 삭제하라
    value = value.replaceAll(RegExp(r'[^0-9]'), '');
    await setWorkTime(value);

    // setting_page 의 일할시간 TextField 의 onChange 핸들러로 부터
    // 전달된 문자열을 정수형으로 변환하여 workTimer state 에 할당
    // value 를 숫자로 변환

    // state 변수에 값을 할당하는 일반적인 방법
    setState(() => workTimer = int.parse(value));
    // state 변수에 값을 할당하기 전에 여러 연산을 실행해야 하는 경우
    // 연산 절차 코드를 실행하여 state 변수에 값을 할당하고,
    // setState() 함수는 Blank 함수를 실행하는 방법으로 구현한다.
    workTimer = int.parse(value);
    setState(() => {});
  }

  /// flutter dart에서 변수를 선언할 때 final, const 키워드가 있으면
  /// 변수의 타입을 명시하지 않아도 된다.
  /// 단, 이 때 반드시 값이 초기화 되어야 한다
  ///
  /// PageController 타입의 변수 선언
  /// HTML tag 에 id 를 적용하는 것처럼 flutter 에서 화면에 표시되는
  /// component 에 id 를 부착하기 위해 선언하는 변수
  final _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    // Scaffold : 어플 layout 고정시켜줌
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "images/tomato.jpg",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // PageView : 여러개 페이지를 볼수있도록 함
        body: PageView(
          // page 넘어가게하깅 - controller 먼저!!
          controller: _pageController,
          // 스크롤 방향 가로로 설정하기
          scrollDirection: Axis.horizontal,
          // 페이지가 바뀌면 pageindex에 value 값을 넣는다
          onPageChanged: (value) => setState(
            () => _pageIndex = value,
          ),
          children: [
            HomePage(
              workTimer: workTimer,
            ),
            const DashPage(),
            SettingPage(
              //함수 전달하기 onChange 라는 이름으로 보낸다,props 전달
              onChange: onChangeSetting,
              workTimer: workTimer,
            ),
          ], //HomePage 띄우기
        ),

        bottomNavigationBar: BottomNavigationBar(
          // 화면을 스크롤햇을때 bottom네비 색이 바뀜
          currentIndex: _pageIndex,
          // onTap : bottonnavigation에 통째로 event 설정
          onTap: (value) {
            // state 를 변화시키는 코드 만들기
            // 바텀네비 value값을 주고 pageindex에 보관
            _pageIndex = value;
            _pageController.animateToPage(
              value,
              // transition 같은거
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
            setState(() => {}); // 아무것도 없어도 호출만해도 위 state로 변화시킨다
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard), label: "DashBoard"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "setting"),
          ],
        ),
      ),
    );
  }
}
