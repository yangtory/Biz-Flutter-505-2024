import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
          // 스크롤 방향 가로로 설정하기
          scrollDirection: Axis.horizontal,
          onPageChanged: (value) => setState(() => _pageIndex = value),
          children: const [HomePage(), SettingPage()], //HomePage 띄우기
        ),
      ),
    );
  }
}
