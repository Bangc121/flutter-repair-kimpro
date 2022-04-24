import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kimpro/stores/login/auth_provider.dart';
import 'package:kimpro/stores/login/user_provider.dart';
import 'package:kimpro/utils/logger/logger.dart';
import 'package:kimpro/utils/routes/routes.dart';
import 'package:kpostal/kpostal.dart';
import 'package:provider/provider.dart';


class AddProfileProScreen extends StatefulWidget {
  const AddProfileProScreen({Key? key}) : super(key: key);

  @override
  State<AddProfileProScreen> createState() => _AddProfileProScreenState();
}

class _AddProfileProScreenState extends State<AddProfileProScreen> {
  final _nickNameController = TextEditingController();
  final _busiNameController = TextEditingController();
  final _repNameController = TextEditingController();
  final _busiNoController = TextEditingController();
  final _telNoController = TextEditingController();
  final _busiAddrDtController = TextEditingController();

  late AuthProvider authProvider;
  late UserProvider userProvider;

  String address = '';

  File? _image;
  String imageUrl = '';
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    authProvider = context.read<AuthProvider>();
    userProvider = context.read<UserProvider>();
  }

  @override
  void dispose() {
    _nickNameController.dispose();
    _busiNameController.dispose();
    _repNameController.dispose();
    _busiNoController.dispose();
    _telNoController.dispose();
    _busiAddrDtController.dispose();
    super.dispose();
  }

  // 전문자 저장 후 homescreen 으로 이동.
  void _save(firebaseUser) async {
    await authProvider.updateProfile(_nickNameController.text.trim());
    await userProvider.saveUserProDB(
      firebaseUser!.uid,
      _nickNameController.text.trim(),
      _busiNameController.text.trim(),
      _repNameController.text.trim(),
      _busiNoController.text.trim(),
      _telNoController.text.trim(),
      address,
      _busiAddrDtController.text.trim(),
      imageUrl,
    );
    Navigator.pushNamedAndRemoveUntil(context, Routes.home, (_) => false);
  }

  /// 주소찾기
  void _findAddress() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => KpostalView(
          callback: (Kpostal result) {
            setState(() {
              address = result.address;
              log.d(result);
            });
          },
        ),
      ),
    );
  }

  // 갤러리에서 사진 가져오기
  Future _getImage(firebaseUser) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, maxWidth: 650, maxHeight: 100);
    // 사진의 크기를 지정 650*100 이유: firebase는 유료이다.
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      String fileName = firebaseUser!.uid;
      UploadTask uploadTask = userProvider.uploadFile(_image!, 'busiFile', fileName);
      try {
        TaskSnapshot snapshot = await uploadTask;
        imageUrl = await snapshot.ref.getDownloadURL();
      } on FirebaseException catch (e) {
        log.e(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('전문가 정보 입력'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              child: ListView(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _nickNameController,
                    decoration: const InputDecoration(labelText: '닉네임'),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _busiNameController,
                    decoration: const InputDecoration(labelText: '상호명'),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: _repNameController,
                    decoration: const InputDecoration(labelText: '대표자명'),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _busiNoController,
                    decoration: const InputDecoration(labelText: '사업자번호'),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: _telNoController,
                    decoration: const InputDecoration(labelText: '전화번호'),
                  ),
                  Row(
                    children: [
                      Text(address),
                      TextButton(
                        onPressed: () => _findAddress(),
                        child: const Text('주소찾기'),
                      )
                    ],
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _busiAddrDtController,
                    decoration: const InputDecoration(labelText: '상세주소'),
                  ),
                  TextButton(
                    onPressed: () => _getImage(firebaseUser),
                    child: const Text('사업자등록증 파일'),
                  ),
                  Container(
                    child: imageUrl.isEmpty ? const SizedBox.shrink() : Image.network(imageUrl),
                  ),
                  /// 사업장 주소, 사업자 등록증
                  ElevatedButton(onPressed: () => _save(firebaseUser), child: const Text('저장'))
                ],
              ),
            ),
          )),
    );
  }
}
