import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:kimpro/stores/login/user_provider.dart';
import 'package:kimpro/stores/post/post_store.dart';
import 'package:kimpro/utils/locale/app_localization.dart';
import 'package:kimpro/utils/routes/routes.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //stores:---------------------------------------------------------------------
  // late PostStore _postStore;

  int _selectedIndex = 0;

  late UserProvider userProvider;
  late Map<String, Object?> user;

  @override
  void initState() {
    super.initState();
    userProvider = context.read<UserProvider>();
    user = userProvider.getPrefUser();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    // _postStore = Provider.of<PostStore>(context);
    //
    // // check to see if already called api
    // if (!_postStore.loading) {
    //   _postStore.getPosts();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('홈'),
        actions: [
          IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(context, Routes.debug);
              }),
        ],
      ),
      body: _buildBody(),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _getUserField(user),
          ),
        ),
        // _handleErrorMessage(),
      ],
    );
  }

  List<Widget> _getUserField(user)  {
    List <Widget> result = [
      Text('id: ${user['id']}'),
      Text('닉네임: ${user['nickName']}'),
      Text('사업자여부: ${user['isBusiness']}'),
      Text('등록일시: ${user['regDateTime']}')
    ];
    if(user['isBusiness'] as bool){
      result.addAll([
        Text('사업자명: ${user['busiName']}'),
        Text('대표자명: ${user['repName']}'),
        Text('사업자번호: ${user['busiNo']}'),
        Text('전화번호: ${user['telNo']}'),
        Text('사업자주소: ${user['busiAddr']}'),
        Text('사업자등록증: ${user['busiFile']}'),
      ]);
    }
    return result;
  }

  // Widget _handleErrorMessage() {
  //   return Observer(
  //     builder: (context) {
  //       if (_postStore.errorStore.errorMessage.isNotEmpty) {
  //         return _showErrorMessage(_postStore.errorStore.errorMessage);
  //       }
  //
  //       return SizedBox.shrink();
  //     },
  //   );
  // }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: AppLocalizations.of(context).translate('home_tv_error'),
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }

  _showDialog<T>({required BuildContext context, required Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T? value) {
      // The value passed to Navigator.pop() or null.
    });
  }
}
