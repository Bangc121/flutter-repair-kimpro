
import 'package:flutter/material.dart';
import 'package:kimpro/stores/login/auth_provider.dart';
import 'package:kimpro/stores/login/user_provider.dart';
import 'package:provider/provider.dart';

class DebugScreen extends StatelessWidget {
  const DebugScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('디버그용 메뉴')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('sign out'),
            trailing: ElevatedButton(
              child: const Text('sign out'),
              onPressed: () {
                context.read<AuthProvider>().signOut();
                Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
              },
            ),
          ),
          ListTile(
            title: const Text('사용자 전환'),
            trailing: ElevatedButton(
              child: const Text('sign out'),
              onPressed: () {
                context.read<AuthProvider>().signOut();
                context.read<UserProvider>().changeUser(true);
                Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
              },
            ),
          ),
        ],
      ),
    );
  }
}