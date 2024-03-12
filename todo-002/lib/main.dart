import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/service/todo_service.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TodoHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TodoHome extends StatefulWidget {
  const TodoHome({super.key});

  @override
  State<TodoHome> createState() => _TodoApHomeState();
}

// State<> 화면에 변화되는 변수를 사용하거나, 여러가지 interactive 한
// 화면을 구현하는 Widget class
class _TodoApHomeState extends State<TodoHome> {
  // Textfield 에 ID(refs) 를 부착하기 위한 state
  final todoInputController = TextEditingController();
  String todo = "";

  getTodo(String todo) {
    return Todo(
      id: const Uuid().v4(),
      // 현재 디바이스의 날짜를 가져와서 (Datetime.now())
      // 문자열 형식으로 변환하라
      sdate: DateFormat("yyyy-MM-dd").format(DateTime.now()),
      stime: DateFormat("HH:ss:mm").format(DateTime.now()),
      edate: "",
      etime: "",
      content: todo,
      complete: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("TODO List"),
        ),
        bottomSheet: bottomSheet(context),
        // FutureBuilder
        // 데이터베이스 에서 가져온 List<Todo> 데이터를 화면에 표현하기 위한
        // 빌더(생성자, 만들기 함수)
        body: todoListBody(context));
  }

//todoListBody
  Widget todoListBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        // width 최대값으로 늘리기
        mainAxisSize: MainAxisSize.max,
        children: [
          FutureBuilder(
            // selectAll() 한데이터를 future 속성에 주입
            future: TodoService().selectAll(),
            // snpashot : 데이터의 복사본
            // 내부에서 가공되어 builder 의 snapshot 에 데이터 전달하고
            builder: (context, snapshot) {
              // snpashot.data 의 데이터를 List<Todo> 타입으로 변환하여 할당
              var todoList = snapshot.data as List<Todo>;
              // ListView.builder
              // todoList snapshot data를 가지고 실제 List 를 화면에 그리기
              return ListView.builder(
                shrinkWrap: true,
                // 이 개수 만큼 화면을 그려
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  return Text(todoList[index].content);
                },
              );
            },
          ),
        ],
      ),
    );
  }

//bottomSheet
  Widget bottomSheet(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          width: double.infinity,
          color: Colors.white,
          // textfield 에서 padding으로 감싸기
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: todoInputController,
              onChanged: (value) => {
                setState(() {
                  todo = value;
                })
              },
              decoration: InputDecoration(
                hintText: "할일을 입력하세요",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                //SizeBox : widget 사이에 간격을 줄 때 박스 넣기
                // textfiled 안에 줬기 때문에 커서 위치 조절할 수 잇슴
                prefix: const SizedBox(width: 20),
                suffix: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => {todoInputController.clear()},
                      icon: const Icon(Icons.clear),
                    ),
                    IconButton(
                      onPressed: () async {
                        var snackBar = SnackBar(content: Text(todo));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        var todoDto = getTodo(todo);

                        // send 후 키보드 감추기
                        FocusScope.of(context).unfocus();
                        await TodoService().insert(todoDto);
                        // send 한 다음 input box에 있는거 지워
                        todoInputController.clear();
                      },
                      icon: const Icon(Icons.send_outlined),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
