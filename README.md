# 사용자 정보 가져오기
사업자 관련정보는 사업자여부가 false 이면 값이 없습니다. 

```dart
UserProvider userProvider = context.read<UserProvider>(); // user 프로바이더 선언
Map<String, Object?> user = userProvider.getPrefUser();   // SharedPreferences 에 저장된 사용자 정보를 불러옴

user['id']; // id
user['nickName']; // 닉네임
user['isBusiness']; // 사업자여부
user['regDateTime']; // 등록일시
user['busiName'] // 사업자명
user['repName'] // 대표자명
user['busiNo'] // 사업자번호
user['telNo'] // 전화번호
user['busiAddr'] // 사업자주소
user['busiFile'] // 사업자등록증

```
# 로그인 여부 체크
isLoggedIn 를 사용하여 로그인 여부 체크합니다.

```dart
AuthProvider authProvider = context.read<AuthProvider>();
bool isLoggedIn = await authProvider.isLoggedIn();
```

