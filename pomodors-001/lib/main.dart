import 'package:flutter/material.dart';
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
  int wantTimer = 20;

//textfiled 안의 값은 문자열이기때문에 매개변수 String
  void onChangeSetting(String value) {
    if (value.length > 3) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(value)));
    }
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
            const HomePage(),
            const DashPage(),
            SettingPage(
              //함수 전달하기 onChange 라는 이름으로 보낸다
              onChange: onChangeSetting,
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
