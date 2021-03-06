import 'package:another_flushbar/flushbar_helper.dart';
import 'package:kimpro/stores/user/user_store.dart';
import 'package:kimpro/stores/post/post_store.dart';
import 'package:kimpro/utils/locale/app_localization.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as developer;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class EstimateInputScreen extends StatefulWidget {
  @override
  _EstimateInputScreenState createState() => _EstimateInputScreenState();
}

class _EstimateInputScreenState extends State<EstimateInputScreen> {
  //stores:---------------------------------------------------------------------
  late PostStore _postStore;
  late UserStore _userStore;
  final _formKey = GlobalKey<FormState>();
  String place = 'place';
  String target = 'target';
  String situation = 'situation';
  String detail = 'detail';

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  File? _image;
  final picker = ImagePicker();

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

    // check to see if already called api
    if (!_postStore.loading) {
      _postStore.getPosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    final maxLines = 5;
    return Scaffold(
      appBar: _buildAppBar(),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal)),
                      labelText: '?????? ??????',
                    ),
                  )
                ],
              ),
              _image != null
                  ? Container(child: Image.file(_image!, width: 100, height: 100, fit: BoxFit.fitHeight))
                  : Container(decoration: BoxDecoration(color: Colors.grey[200]), width: 100, height: 100,
                child: Icon(Icons.camera_alt, color: Colors.grey[800]),
              ),
              renderValues(),
              imagePickButton(),
            ],
          ),
        ),
      ),
      bottomSheet: renderButton(),
    );
  }

  // app bar methods:-----------------------------------------------------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text('????????????'),
    );
  }

  Widget renderTextFormField({
    required String label,
    required FormFieldSetter onSaved,
    // required FormFieldValidator validator,
  }) {
    // assert(validator != null);

    return Column(
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        TextFormField(
          onSaved: onSaved,
          // validator: validator,
        ),
      ],
    );
  }

  Widget imagePickButton() {
    return ElevatedButton(
      onPressed: () async {
        _getImage();
      },
      child: Text(
        '??????',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget renderButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
          minimumSize: const Size.fromHeight(80), // NEW
        ),
        onPressed: () {
          if(_formKey.currentState!.validate()){
            this._formKey.currentState?.save();
            _uploadFile(context);
          }
        },
        child: Text(
          '?????? ?????? ????????????',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget renderValues() {
    return Column(
      children: [
        Text("place: $place"),
        Text("target: $target")
      ],
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

  // ??????????????? ?????? ????????????
  Future _getImage() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery, maxWidth: 650, maxHeight: 100);
    // ????????? ????????? ?????? 650*100 ??????: firebase??? ????????????.
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future _uploadFile(BuildContext context) async {
    try {
      // ??????????????? ???????????? ?????? ??????
      final firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('post')   //'post'?????? folder??? ?????????
          .child('${DateTime.now().millisecondsSinceEpoch}.png');

      // ?????? ?????????
      final uploadTask = firebaseStorageRef.putFile(
          _image!, SettableMetadata(contentType: 'image/png'));

      // ???????????? ?????????
      await uploadTask.whenComplete(() => null);

      // ????????? ?????? ??? url
      final downloadUrl = await firebaseStorageRef.getDownloadURL();

      developer.log(downloadUrl.toString(), name: 'my.app.category');


      var now = new DateTime.now();

      // ?????? ??????
      // await FirebaseFirestore.instance.collection('Estimate').add({
      //   'id': 0,
      //   'place': this.place,
      //   'situation': this.situation,
      //   'detail': this.detail,
      //   'target': this.target,
      //   'imageUrl': downloadUrl,
      //   'create_at': now,
      //   'update_at': now,
      // });

      final snackBar = SnackBar(
        content: const Text('????????????'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      print(e);
    }

    // ?????? ??? ??? ???????????? ??????
    // Navigator.pop(context);
  }
}
