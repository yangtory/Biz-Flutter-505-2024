import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("TODO List"),
      ),
      body: const Center(
        child: Text(
          "안녕하세요",
          style: TextStyle(fontSize: 30),
        ),
      ),
      // 화면이 찌그러질때 유지할수 있게
      bottomSheet: SafeArea(
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
                        onPressed: () {
                          var snackBar = SnackBar(content: Text(todo));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
      ),
    );
  }
}
