import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kimpro/stores/login/auth_provider.dart';
import 'package:kimpro/stores/login/user_provider.dart';
import 'package:kimpro/utils/routes/routes.dart';
import 'package:provider/provider.dart';

class AddProfileScreen extends StatefulWidget {
  const AddProfileScreen({Key? key}) : super(key: key);

  @override
  State<AddProfileScreen> createState() => _AddProfileScreenState();
}

class _AddProfileScreenState extends State<AddProfileScreen> {
  final _nicknameController = TextEditingController();
  late AuthProvider authProvider;
  late UserProvider userProvider;

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    authProvider = context.read<AuthProvider>();
    userProvider = context.read<UserProvider>();
  }
  
  Future<void> _save(firebaseUser) async {
    await authProvider.updateProfile(_nicknameController.text.trim());
    await userProvider.saveUserDB(firebaseUser!.uid, _nicknameController.text.trim());
    Navigator.pushNamedAndRemoveUntil(context, Routes.home, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('회원정보 입력'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              child: ListView(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _nicknameController,
                    decoration: const InputDecoration(labelText: '닉네임'),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        _save(firebaseUser);
                      },
                      child: const Text('입력'))
                ],
              ),
            ),
          )),
    );
  }
}
