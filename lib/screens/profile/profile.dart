import 'package:another_flushbar/flushbar_helper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kimpro/models/profile/icon_menu.dart';
import 'package:kimpro/stores/user/user_store.dart';
import 'package:kimpro/stores/post/post_store.dart';
import 'package:kimpro/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../notice/notice_page.dart';
import '../tutorial/tutorial_page.dart';
import 'card_icon_menu.dart';
import 'dart:developer' as developer;

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //stores:---------------------------------------------------------------------
  late PostStore _postStore;
  late UserStore _userStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    _postStore = Provider.of<PostStore>(context);
    _userStore = Provider.of<UserStore>(context);

    // developer.log(_userStore.toString(), name: 'my.app.category');
    // check to see if already called api
    if (!_postStore.loading) {
      _postStore.getPosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _builProfileAppBar(),
      body: Column(
        children: [
          SizedBox(height: 20),
          //사진, 사용자명
          ProfileHeader(),
          SizedBox(height: 20),
          //버튼
          ProfileButtons(),
          ProfileDiviBar(),
          //서비스 안내
          ProfileServiceInfo(),
          //
          // CardIconMenu(
          //   iconMenuList: iconMenu1,
          // ),
          _buildRowIconItemTutorial('튜토리얼', FontAwesomeIcons.mapMarkerAlt, context), //IconMenu(title: '튜토리얼', iconData: FontAwesomeIcons.mapMarkerAlt)
          _buildRowIconItemNotice('공지사항', FontAwesomeIcons.mapMarkerAlt, context), //IconMenu(title: '튜토리얼', iconData: FontAwesomeIcons.mapMarkerAlt)// ,
        ],
      ),
    );
  }

  //아이콘
  Widget _buildRowIconItemTutorial(String title, IconData iconData, BuildContext context) {
    return Container(
      height: 50,
      child: InkWell(
          onTap: () {
            //페이지 이동
            print('aaa : 해당 페이지로 이동.');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TutorialScreen()),
            );
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => SecondRoute()),
            // );
          }, // Handle your callback
          child: Column(
            // padding: EdgeInsets.all(12.0),
            children: [
              Icon(iconData, size: 17),
              const SizedBox(width: 20),
              Text(
                title,
              )
              // Text(title, style: textTheme().subtitle1)
            ],
          )
        // child: Ink(height: 100, width: 100, color: Colors.blue),
        // children: [
        //   Icon(iconData, size: 17),
        //   const SizedBox(width: 20),
        //   Text(
        //     title,
        //   )
        //   // Text(title, style: textTheme().subtitle1)
        // ],
      ),
    );
  }

  //아이콘
  Widget _buildRowIconItemNotice(String title, IconData iconData, BuildContext context) {
    return Container(
      height: 50,
      child: InkWell(
          onTap: () {
            //페이지 이동
            print('aaa : 해당 페이지로 이동.');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NoticeScreen()),
            );
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => SecondRoute()),
            // );
          }, // Handle your callback
          child: Column(
            // padding: EdgeInsets.all(12.0),
            children: [
              Icon(iconData, size: 17),
              const SizedBox(width: 20),
              Text(
                title,
              )
              // Text(title, style: textTheme().subtitle1)
            ],
          )
        // child: Ink(height: 100, width: 100, color: Colors.blue),
        // children: [
        //   Icon(iconData, size: 17),
        //   const SizedBox(width: 20),
        //   Text(
        //     title,
        //   )
        //   // Text(title, style: textTheme().subtitle1)
        // ],
      ),
    );
  }

  Widget _buildRowIconItem(String title, IconData iconData, BuildContext context) {
    return Container(
      height: 50,
      child: InkWell(
          onTap: () {
            //페이지 이동
            print('aaa : 해당 페이지로 이동.');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NoticeScreen()),
            );
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => SecondRoute()),
            // );
          }, // Handle your callback
          child: Column(
            // padding: EdgeInsets.all(12.0),
            children: [
              Icon(iconData, size: 17),
              const SizedBox(width: 20),
              Text(
                title,
              )
              // Text(title, style: textTheme().subtitle1)
            ],
          )
        // child: Ink(height: 100, width: 100, color: Colors.blue),
        // children: [
        //   Icon(iconData, size: 17),
        //   const SizedBox(width: 20),
        //   Text(
        //     title,
        //   )
        //   // Text(title, style: textTheme().subtitle1)
        // ],
      ),
    );
  }

  AppBar _builProfileAppBar() {
    return AppBar(
      leading: Icon(Icons.arrow_back_ios),
      title: Text("마이페이지"),
      centerTitle: true,
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        _handleErrorMessage(),
      ],
    );
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (_postStore.errorStore.errorMessage.isNotEmpty) {
          return _showErrorMessage(_postStore.errorStore.errorMessage);
        }

        return SizedBox.shrink();
      },
    );
  }

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
}

class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 20),
        _buildHeaderAvatar(),
        SizedBox(width: 20),
        _buildHeaderProfile(),
        // _buildLine(),
      ],
    );
  }

  Widget _buildHeaderAvatar() {
    return SizedBox(
      width: 100,
      height: 100,
      child: CircleAvatar(
        backgroundImage: AssetImage("assets/images/avatar.png"),
      ),
    );
  }

  Widget _buildHeaderProfile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "사용자명",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          "test@test.com",
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        // Text(
        //   "데어 프로그래밍",
        //   style: TextStyle(
        //     fontSize: 15,
        //   ),
        // ),
      ],
    );
  }
}

class ProfileButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildFollowButton(context),
        // _buildMessageButton(),
      ],
    );
  }

  Widget _buildFollowButton(BuildContext context) {
    return InkWell(
      onTap: () {
        print("프로필 수정");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TutorialScreen()),
        );
      },
      child: Container(
        alignment: Alignment.center,
        width: 350,
        height: 45,
        child: Text(
          "프로필 수정",
          style: TextStyle(color: Colors.black),
        ),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}

class ProfileDiviBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // _buildInfo('10', 'test'),
        _buildColumnHeight(10),
        _buildLine(),
      ],
    );
  }

  Widget _buildColumnHeight(double height) {
    return Column(
      children: [
        SizedBox(height: height),
      ],
    );
  }

  Widget _buildLine() {
    return Container(width: 350, height: 2, color: Colors.black);
  }
}

//서비스 안내
class ProfileServiceInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Text(
        "서비스 안내",
        style: TextStyle(fontSize: 30),
      ),
    );
  }
}
