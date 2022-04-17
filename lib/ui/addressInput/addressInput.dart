import 'package:another_flushbar/flushbar_helper.dart';
import 'package:kimpro/stores/user/user_store.dart';
import 'package:kimpro/stores/post/post_store.dart';
import 'package:kimpro/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:kimpro/constants/dimens.dart';

import '../../utils/routes/routes.dart';

class AddressInputScreen extends StatefulWidget {
  @override
  _AddressInputScreenState createState() => _AddressInputScreenState();
}

class _AddressInputScreenState extends State<AddressInputScreen> {
  //stores:---------------------------------------------------------------------
  late PostStore _postStore;
  late UserStore _userStore;
  String place = '';

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
  BsSelectBoxController _select1 = BsSelectBoxController(
      options: [
        BsSelectBoxOption(value: 1, text: Text('등록된 주소 선택')),
        BsSelectBoxOption(value: 2, text: Text('새로운 주소 입력')),
      ]
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        padding: const EdgeInsets.all(Dimens.horizontal_padding),
        child: Column(
          children: <Widget>[
            Row(
                children: <Widget>[
                  Text(AppLocalizations.of(context).translate('service_address_input_title'), style: TextStyle(color: Colors.grey, fontSize: 17, fontWeight: FontWeight.bold)),
                ]
            ),
            SizedBox(height: 30.0),
            BsSelectBox(
              hintText: '주소를 선택해주세요',
              controller: _select1,
            ),
          ],
        ),
      ),
      bottomSheet: renderButton(),
    );
  }

  // app bar methods:-----------------------------------------------------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text('견적요청'),
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

  Widget renderButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.black,
          minimumSize: const Size.fromHeight(90), // NEW
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0)),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.scheduleInput);
        },
        child: Text(
          '다음 단계',
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

}
