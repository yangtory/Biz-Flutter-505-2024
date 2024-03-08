import 'dart:async';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.workTimer});
  final int workTimer;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// 변수의 late 초기화하기
  /// flutter(dart)에서는 변수를 반드시 초기화를 해야하는 원칙이 있음
  /// 즉 변수를 선언만 해서는 오류 발생함
  /// 이 코드에서 _timer 는 이후 if() 에서
  /// 조건에 따라 초기화를 늦게 시킬 예정임
  /// 처음 변수를 선언할때 초기값을 지정하지 않는다.
  /// 이 코드는 flutter(Dart)의 변수 초기화 원칙에 위배된다.
  /// 이럴때 late 키워드를 부착하여 초금있다가 아래 코드에서
  /// 변수를 꼭! 초기화 할테니 일단 보류 해줘 라는 말 임
  late Timer _timer;
  // main 으로 부터 전달받은 workTimer
  // workTimer 는 setting_page 에서 일할시간을 변경하면 그 값을 전달해주는
  // 전달자 state 이다.
  // 즉, setting_page 에서 일 할 시간을 변경하면 timer 의 전체시간이 변경되어야 한다.

  // 일반적인 코드 형식이라면
  // int _count = workTimer 이라고 사용한다.

  // 하지만 Flutter 에 State<> 에서는
  // int _count = widget.workTimer 라고 사용해야 한다.
  // 문제는 State<> class 영역에서는 widget 을 사용할 수 없다.
  // 따라서 _count 변수에 workTimer 값을 할당하기 위해서는 다른 방법을 사용해야 됨

  // Flutter 의 State<> class 에는 initState() 라는 함수를 사용할 수 있다.
  // 이 함수에서는 _count 변수에 widget.workTimer 값을 할당하는 코드를 사용해야 함
  int _count = 5;
  bool _timerRun = false;

  /// State class 가 mount(화면이 모두 그려졌을때)될 때 자동으로 실행되는 함수
  @override
  void initState() {
    super.initState();
    _count = widget.workTimer;
  }

  void _onPressed() {
    setState(() {
      _timerRun = !_timerRun;
    });
    if (_timerRun) {
      // duration 이라고 정해진 시간마다 한번씩 밑의 함수를 실행해
      // 함수 : count 값을 -- 해
      // periodic : 특정 작업을 반복적으로 수행하도록 예약하는 함수
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          setState(() => _count--);
          if (_count < 1) {
            _count = widget.workTimer;
            _timerRun = false;
            timer.cancel();
          }
        },
      );
    } else {
      _timer.cancel(); //타이머 멈추기
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: TextButton(
        onPressed: _onPressed,
        child: Center(
          // center로 감싸면 가운데로 감
          child: Text(
            // 위 count 값 표시하기
            "$_count",
            style: TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.w900,
              // Paint() 에있는 style,color 등 속성을 밖으로 꺼내기, foreground??
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
