import 'package:flutter/material.dart';

/// 사용자, 사업자 선택 화면
class AddProfileSelectScreen extends StatelessWidget {
  const AddProfileSelectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              child: const Text('일반사용자'),
              onPressed: () {
                Navigator.pushNamed(context, '/add-profile');
              },
            ),
            ElevatedButton(
              child: const Text('전문가'),
              onPressed: () {
                Navigator.pushNamed(context, '/add-profile-pro');
              },
            ),
          ],
        ),
      ),
    );
  }
}
