import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
  static const int wantTimer = 10;
  int _count = wantTimer;
  bool _timerRun = false;

  void _onPressed() {
    setState(() {
      _timerRun = !_timerRun;
    });
    if (_timerRun) {
      // duration 이라고 정해진 시간마다 한번씩 밑의 함수를 실행해
      // 함수 : count 값을 -- 해
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          setState(() => _count--);
          if (_count < 1) {
            _count = wantTimer;
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
