import 'package:flutter/material.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        // text 앞에 이미지 붙히기
        leading: Image.asset(
          "assets/user.png",
          fit: BoxFit.fill,
        ),
        title: const Text("TODO"),
        // 버튼 붙히기
        actions: [
          IconButton(
            onPressed: _showTodoInputDialog,
            icon: const Icon(
              Icons.add_alarm,
              color: Colors.white,
            ),
          ),
          IconButton(
            // 이 방법은 값을 넘겨줘야 할 때
            onPressed: () => {_showTodoInputDialog()},
            icon: const Icon(
              Icons.add_alarm,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showTodoInputDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("할일 등록"),
          actions: [
            // TextField input box 나타남
            _todoInputBox(context)
          ],
        );
      },
    );
  }

  Widget _todoInputBox(BuildContext context) {
    return Padding(
      // 테두리를 8.0만큼
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              /// Expanded Widget
              /// coolumn, row 등으로 widget 을 감싸면 content 가 없는경우
              /// widget 이 화면에서 사라져 버리는 경우가 있다
              /// 이 때는 그 widget 을 Expanded Widget으로 감싸주면 해결
              Expanded(
                child: TextField(
                  textInputAction: TextInputAction.go,
                  // hintText: placeholder
                  decoration: const InputDecoration(hintText: "할 일을 입력해 주세요"),
                  onSubmitted: (value) {
                    // SnackBar 를 띄우기 위해 snackBar 객체(변수) 선언
                    SnackBar snackBar = const SnackBar(
                      content: Text("할일이 등록됨"),
                    );
                    // ScaffoldMessenger 에게 snackBar 를 표시해줘 라고 요청
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    // alert dialog 를 닫아라
                    Navigator.of(context).pop();
                  },
                ),
              ),
              IconButton(
                onPressed: () => {},
                icon: const Icon(
                  Icons.send_outlined,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
} // todo state end
