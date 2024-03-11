# todo

- `Android`, `iphone`, `기타 table` 에는 기본적으로 `SQLite` 라고 하는 작은 `RDBMS` 가 내장되어 있다.
- `Todo` 리스트를 `SQLite` 에 저장하고, 리스트를 화면에 출력하는 프로젝트

## SQLite 를 사용하기 위하여 Dependency 설치하기

- SQLite : `flutter pub add sqflite`
- 날짜 시간 : `flutter pub add intl` international location
- 저장 경로 관리 : `flutter pub path`

## Flutter(Dart) 의 변수

- Flutter 의 3가지 변수 선언 키워드가 있다
- Flutter 에서도 정적 type 변수를 선언할 수 있다

```dart
String name = "홍길동"
int num = 12345
```

- Flutter 에서는 동적 type 변수를 선언할 수 있다
- 동적 type 변수를 선언할 때는 `const`, `final`, `var` 키워드를 사용할 수 있다.

### const

- `const` 키워드는 일반적인 변수와 성질이 매우 다르다.
- 완전한 상수값을 저장하는 저장소를 선언하는 키워드이다.
- 코드에서 `magin string` 코드를 사용하지 않도록 하기 위한 것이기도 하다.
- `Widget` 을 사용할 때 const 를 부착할 때가 있다.
- `const` type 의 변수는 함수의 `return` 값을 저장할 수 없다.
- `const` 키워드가 부착된 변수는 코드가 컴파일되는 과정에서 값이 확정된다.
- 함수의 return 값은 코드가 실행되는 과정에서 확정되기 떄문에 const type 의 변수에 저장할 수 없다.

```dart
const korea = "Republic of Korea"
const NAVER_ID = "dslfsdlfldsj"
```

### final

- `final` 키워드가 부착된 변수는 한 번만 값을 할당 할 수 있다.
- `final` 키워드가 부착된 변수는 함수의 return 값을 저장할 수 있다.
- `final` 키워드가 부착된 변수는 코드가 실행되는 동안 확정된다.
- 코드가 실행되는 과정에서 변수의 변형(값의 할당, 삭제 등) 을 방지하기 위한 고정값으로 설정할 때 사용된다.

```dart
final inputController = TextEditingController();
final sum = num1 + num2;
```

### var

- `var` 키워드는 일반적인 변수의 성질을 모두 갖는다.
- 값을 자유롭게 할당, 제거할 수 있다.
- 함수의 return type 이나 변수의 type 을 확인하기 어려울 때 일반적으로 사용한다.
- `var` 키워드가 부착된 변수는 코드가 실행되는 과정에서 변수의 type 이 결정된다 : 동적(Dynamic) 타이핑(Typing)
