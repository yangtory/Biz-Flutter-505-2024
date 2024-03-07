import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

// 함수는 stateful 이 받는다
class SettingPage extends StatefulWidget {
  //main 한테 onChange 를 전달 받겟음
  const SettingPage({super.key, required this.onChange});
  // state 에게 전달하기 위해 한번 더 셋팅해준거임
  final Function(String) onChange;

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
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
                  // 전달받은 함수는 widget. 으로 받는다.1
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
