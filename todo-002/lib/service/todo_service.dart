// ignore_for_file: constant_identifier_names, unused_field, unused_local_variable

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/model/todo.dart';

const TBL_TODO = "tbl_todolist";
// """ : 연속된 문자열
const createTodoTable = """
CREATE TABLE $TBL_TODO (
  id TEXT,
  sdate TEXT,
  stime TEXT,
  edate TEXT,
  etime TEXT,
  content TEXT,
  complete INTEGER
)
""";

class TodoService {
  late Database _database;
  // Future<Database> get database() async {
  //   _database = await
  // }

  onCreateTable(db, version) async {
    return db.execute(createTodoTable);
  }

// 스키마 변경 시 기존 테이블 제거 후 새로 테이블 만들기
// initData / openDatabase 가 실행될 때
// version 번호를 비교하여 새로운 version 번호가 있으면
// Table 의 구조를 변경한다.
  onUpgradeTable(db, oldVersion, newVersion) async {
    if (newVersion > oldVersion) {
      debugPrint("$oldVersion, $newVersion");
      // batch : 트랜젝션 발생할 때 이렇게 해줘
      final batch = await db.batch();
      await batch.execute("DROP TABLE $TBL_TODO");
      await batch.execute(createTodoTable);
      await batch.commit();
    }
  }

  Future<Database> initDatabase() async {
    // getDatabasePath : 스마트 기기의 DB 저장소 폴더 위치를 가져오는 함수
    String dbPath = await getDatabasesPath();

    // 저장소에 저 이름의 폴더를 만들어 쓰겠다
    // join 폴더1/폴더2/폴더3/todo.dbf 라는 경로를 설정할 때
    // 운영체제마다 dir seperator 문자가 다르다.
    // "폴더1" + "/" + "폴더2" + "/" + "폴더3" 어떤 운영체제는 /,
    // "폴더1" + "\" + "폴더2" + "\" + "폴더3" 어떤 운영체제는 \ 사용하는데
    // path.join() 은 운영체제에 맞춰서 구분자(dir seperator)를 만들어준다.
    String dbFile = join(dbPath, "todo.dbf");

    // 테이블 없으며면 create, upgrade 해야하면 그거해
    return await openDatabase(
      dbFile,
      onCreate: onCreateTable,
      onUpgrade: onUpgradeTable,
      version: 2,
    );
  }

  // DB 를 사용할 수 있도록 open 하고 연결정보가 담긴 _database 변수를 초기화 한다
  // flutter 에서 사용하는 특이한 getter method
  // 이 함수는 () 가 없고, 함수 이름 앞에 get 키워드가 있다
  // 이 함수 이름과 연관된 로컬변수(_함수) 와 같은 형식의 변수가 있어야 한다.
  Future<Database> get database async {
    _database = await initDatabase();
    return _database;
  }

// todo를 매개변수로 받아서 tbl_todo에다 todo데이터 insert
// getter method와 연결돼 있어서 ()가 없다
  insert(Todo todo) async {
    final db = await database;
    debugPrint("INSERT TO : ${todo.toString()}"); // 확인하기
    var result = await db.insert(TBL_TODO, todo.toMap());
  }

  // Future : 동적 데이터에 대한 약속(promise)
  // selectAll() 함수를 호출하면 반드시 List<Todo> 데이터 타입을 return 하겠다.
  Future<List<Todo>> selectAll() async {
    final db = await database; //db연결
    //final todoList = await db.query((TBL_TODO));
    ////데이터가져오기, db.query가 어떤 데이터를  return하는지 모를경우 final만 쓸수있다
    final List<Map<String, dynamic>> todoList =
        await db.query(TBL_TODO); // 위 코드와 같다
    final result = List.generate(todoList.length,
        (index) => Todo.fromMap(todoList[index])); //foreach와 비슷
    return result;
  }
}
