import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/modules/todo.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  // todolist 배열 선언하고 crtl+space 로 import 하기

  Todo getTodo(String content) {
    return Todo(
      // 날짜 가져오기
      sdate: DateFormat("yyyy-MM-dd").format(
        DateTime.now(),
      ),
      // 시간 가져오기
      stime: DateFormat("HH:mm:ss").format(
        DateTime.now(),
      ),
      content: content,
      complete: false,
    );
  }

  List<Todo> todoList = [];

  @override
  void initState() {
    super.initState();
    // todoList.add(getTodo("Start"));
    // todoList.add(getTodo("Second"));
    // todoList.add(getTodo("Third"));
  }

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
      // ListView.builder() : 리스트에 담겨있는 값을 화면에 보여주는 box 친구
      body: ListView.builder(
        // 리스트 개수 몇개인지
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          // Dismissible : 좌, 우로 드래그 하기
          return Dismissible(
            key: UniqueKey(),
            background: Container(
              // all: 사각형 전체, symmetric : 수평, 수직 부분
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: Colors.green,
              // 왼쪽으로 넘겼을 때 보이게하기
              alignment: Alignment.centerLeft,
              child: const Icon(
                Icons.save_alt_sharp,
                size: 36,
                color: Colors.white,
              ),
            ),
            // 오른쪽으로 넘겼을 때
            secondaryBackground: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: const Icon(
                Icons.delete_outline,
                size: 36,
                color: Colors.white,
              ),
            ),
            child: Material(
              // InkWell : 리스트 꾸미기
              child: InkWell(
                onTap: () => {},
                // 길게터치, 살짝터치
                highlightColor: Colors.red.withOpacity(0.3),
                splashColor: Colors.blueAccent.withOpacity(0.3),
                // ListTile : List 를 하나씩 보여주는 친구
                child: ListTile(
                  title: Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            todoList[index].sdate,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                          Text(
                            todoList[index].stime,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              todoList[index].content,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.blue,
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),

            // 사라지기 전에 실행할 event
            confirmDismiss: (direction) {
              // 넘겼을때 return 값에 따라 없애기
              if (direction == DismissDirection.endToStart) {
                // showDialog 를 return 해서 밑의 코드 실행
                return showDialog(
                    context: context,
                    builder: (content) {
                      return AlertDialog(
                        title: const Text("삭제할까요?"),
                        actions: [
                          ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text("예")),
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text("취소"),
                          ),
                        ],
                      );
                    });
              } else {
                return Future.value(false);
              }
            },
            // 사라진 후 event, confirmDismiss 가 실행이 끝나면
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                setState(() {
                  // index 번째 삭제하기
                  todoList.removeAt(index);
                });
              }
            },
          );
        },
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
                  // go button 을 클릭하면
                  textInputAction: TextInputAction.go,
                  // hintText: placeholder
                  decoration: const InputDecoration(hintText: "할 일을 입력해 주세요"),
                  // onsubmit이 실행되면 value 를 추가
                  onSubmitted: (value) {
                    setState(() {
                      todoList.add(getTodo(value));
                    });
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
