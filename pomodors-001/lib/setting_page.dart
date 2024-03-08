import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

// 함수는 stateful 이 받는다
class SettingPage extends StatefulWidget {
  //main 한테 onChange 를 전달 받겟음
  //require this.onChange :
  //  main 으로 부터 onChange 라는 props 를 반드시 받도록 선언하기

  const SettingPage(
      {super.key, required this.onChange, required this.workTimer});
  // state 에게 전달하기 위해 한번 더 셋팅해준거임
  // State 에서 onChange 를 사용할수 있도록 선언하기
  // onChange 라는 props 는 함수이다(Function)
  // 또한 문자열형 매개변수를 통하여 값을 전달할 수 있다.
  // onChange 함수를 사용하는 곳에서 문자열을 전달하면 그 문자열이
  // main 으로 전달된다.
  final Function(String) onChange;
  final int workTimer;

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final workTimeController = TextEditingController();
  @override
  void initState() {
    super.initState();
    workTimeController.text = widget.workTimer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //SettingsList,SettingsTile : settings_ui 에 있는 칭구
      body: SettingsList(
        sections: [
          // section "일하기" 에 tile들("타이머","알람")을 붙혀 그룹을 만듬
          SettingsSection(
            title: const Text("타이머설정"),
            tiles: [
              SettingsTile(
                // 앞쪽에 아이콘
                leading: const Icon(Icons.timer_outlined),
                title: TextField(
                  keyboardType: TextInputType.number,
                  // textfield 에 id(ref) 부착하기
                  controller: workTimeController,

                  /// StateFull 에서 선언한 props 를 사용할 때는
                  /// widget.[props] 형태로 사용한다
                  /// StateFull 에서 선언한 onChange 함수를
                  /// widget.onChange() 라는 형식으로 사용한다.
                  /// 만약 이 함수에 전달할 값이 필요없다면
                  /// onChaged: widget.onChange
                  /// 하지만 현재 widget.onChange 함수는 문자열형 매개변수를
                  /// 필요로 하도록 선언되어 있다 : final Function(String) onChange
                  ///
                  /// 필요한 값을 전달하기 위하여 함수 선언형으로 event 핸들러를 사용한다.
                  // 전달받은 함수는 widget. 으로 받는다.
                  onChanged: (value) => widget.onChange(value),
                  decoration: const InputDecoration(
                    labelText: "일할시간",
                    contentPadding: EdgeInsets.all(0),
                    hintText: "타이머 작동시간을 입력하세요",
                    hintStyle: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
              SettingsTile(
                leading: const Icon(Icons.timer_outlined),
                title: const TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "휴식시간"),
                ),
              ),
              SettingsTile(
                leading: const Icon(Icons.timer_outlined),
                title: const TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "반복횟수"),
                ),
              ),

              // SettingsTile.switchTile : toggle 만들기
              SettingsTile.switchTile(
                initialValue: true,
                onToggle: (value) => {},
                title: const Text("알람"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
