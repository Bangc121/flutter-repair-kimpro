import 'package:another_flushbar/flushbar_helper.dart';
import 'package:kimpro/data/repository.dart';
import 'package:kimpro/data/sharedpref/constants/preferences.dart';
import 'package:kimpro/di/components/service_locator.dart';
import 'package:kimpro/stores/user/user_store.dart';
import 'package:kimpro/screens/profile/profile.dart';
import 'package:kimpro/utils/routes/routes.dart';
import 'package:kimpro/stores/language/language_store.dart';
import 'package:kimpro/stores/post/post_store.dart';
import 'package:kimpro/utils/locale/app_localization.dart';
import 'package:kimpro/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:kimpro/constants/dimens.dart';

class TotalServiceScreen extends StatefulWidget {
  @override
  _TotalServiceScreenState createState() => _TotalServiceScreenState();
}

class _TotalServiceScreenState extends State<TotalServiceScreen> {
  //stores:---------------------------------------------------------------------
  late PostStore _postStore;
  late LanguageStore _languageStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    _postStore = Provider.of<PostStore>(context);
    _languageStore = Provider.of<LanguageStore>(context);

    // check to see if already called api
    if (!_postStore.loading) {
      _postStore.getPosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        _handleErrorMessage(),
        Container(
          padding: const EdgeInsets.all(Dimens.horizontal_padding),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.addressInput);
                  },
                  child: Text(AppLocalizations.of(context).translate('service_button')),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.black),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          //side: BorderSide(color: Colors.red) // border line color
                        )),
                  ),
                ),
              ),

            ],
          ),
        ),
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

  _showDialog<T>({required BuildContext context, required Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T? value) {
      // The value passed to Navigator.pop() or null.
    });
  }
}
