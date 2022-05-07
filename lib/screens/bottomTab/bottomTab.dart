import 'package:kimpro/screens/home/home.dart';
import 'package:kimpro/screens/notice/notice_page.dart';
import 'package:kimpro/screens/profile/profile.dart';
import 'package:kimpro/screens/totalService/totalService.dart';
import 'package:kimpro/stores/post/post_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/sharedpref/constants/preferences.dart';
import '../../utils/routes/routes.dart';
import '../list/list.dart';

class BottomTabScreen extends StatefulWidget {
  @override
  _BottomTabScreenState createState() => _BottomTabScreenState();
}

class _BottomTabScreenState extends State<BottomTabScreen> {
  //stores:---------------------------------------------------------------------
  late PostStore _postStore;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    _postStore = Provider.of<PostStore>(context);

    // check to see if already called api
    if (!_postStore.loading) {
      _postStore.getPosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildTabBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: _selectedIndex == 0 ? Icon(Icons.home, color: Colors.black,) : Icon(Icons.home_outlined, color: Colors.black,),
              label: 'home'
          ),
          BottomNavigationBarItem(
              icon: _selectedIndex == 1 ? Icon(Icons.add_box, color: Colors.black,) : Icon(Icons.add_box_outlined, color: Colors.black,),
              label: 'list'
          ),
          BottomNavigationBarItem(
              icon: _selectedIndex == 2 ? Icon(Icons.list, color: Colors.black,) : Icon(Icons.list_outlined, color: Colors.black,),
              label: 'list'
          ),
          BottomNavigationBarItem(
              icon: _selectedIndex == 3 ? Icon(Icons.person, color: Colors.black,) : Icon(Icons.person_outline, color: Colors.black,),
              label: 'profile'
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  // app bar methods:-----------------------------------------------------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text('수리천재'),
      actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return <Widget>[
      _buildMenuButton()
    ];
  }

  Widget _buildMenuButton() {
    return IconButton(
      onPressed: () {
        SharedPreferences.getInstance().then((preference) {
          preference.setBool(Preferences.is_logged_in, false);
          Navigator.of(context).pushReplacementNamed(Routes.login);
        });
      },
      icon: Icon(
        Icons.menu,
      ),
    );
  }

  List<Widget> _widgetOptions = [
    HomeScreen(),
    TotalServiceScreen(),
    ListScreen(),
    ProfileScreen(),
    // NoticeScreen(),
  ];

  Widget _buildTabBody() {
    return Center(
      child: _widgetOptions.elementAt(_selectedIndex),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
