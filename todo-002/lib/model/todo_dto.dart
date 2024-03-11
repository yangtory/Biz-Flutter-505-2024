// Data class
// Java 의 DTO(VO) 클래스와 비슷한 역할을 수행하는 클래스

class TodoDto {
  // 데이터 클래스에 선언된 변수들
  // 속성, 필드, 멤버 변수
  String id;
  String sdate;
  String edate;
  String content;
  // ? : 클래스를 객체로 생성할 때 complete 변수 값은 필수로 할당 하지 않겠다.
  // ? 가 있으면 생성자에서 required 가 없어도 된다.
  bool? complete;

//생성자를 만들 때 이 값들을 모두 받겠다.
// required : 필수
// Todo 클래스를 사용하여 객체(인스턴스) 를 만들 때
// 모든 필드 변수의 값을 필수로 지정해야 한다. (null이 될 수 없다.)
  TodoDto({
    required this.id,
    required this.sdate,
    required this.edate,
    required this.content,
    this.complete,
  });

// Todo 객체의 각 필드에 저장된 값들을 json 으로
// Map type 의 변수로 변환하는 함수
// Object : 모든 타입의 변수,
//    필드에 저장된 값을 Map 으로 변환하여 return 하는데
//    필드의 데이터 타입이 String, bool 등 이 섞여 있기 때문에
//    Object 타입으로 변환한다.
// String 만 있으면 <String, String>
  Map<String, Object?> toMap() {
    return {
      "id": id,
      "sdate": sdate,
      "edate": edate,
      "content": content,
      "complete": complete
    };
  }
}
