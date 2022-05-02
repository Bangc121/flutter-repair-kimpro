import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kimpro/constants/app_theme.dart';
import 'package:kimpro/constants/strings.dart';
import 'package:kimpro/data/repository.dart';
import 'package:kimpro/di/components/service_locator.dart';
import 'package:kimpro/screens/login/splash.dart';
import 'package:kimpro/stores/login/auth_provider.dart';
import 'package:kimpro/stores/login/user_provider.dart';
import 'package:kimpro/utils/routes/routes.dart';
import 'package:kimpro/stores/language/language_store.dart';
import 'package:kimpro/stores/post/post_store.dart';
import 'package:kimpro/stores/user/user_store.dart';
import 'package:kimpro/screens/login/login.dart';
import 'package:kimpro/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class MyApp extends StatelessWidget {
  final PostStore _postStore = PostStore(getIt<Repository>());
  final LanguageStore _languageStore = LanguageStore(getIt<Repository>());
  // final UserStore _userStore = UserStore(getIt<Repository>());

  final SharedPreferences prefs;

  MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return MultiProvider(
      providers: [
        Provider<PostStore>(create: (_) => _postStore),
        Provider<LanguageStore>(create: (_) => _languageStore),
        // Provider<UserStore>(create: (_) => _userStore),
        Provider<AuthProvider>(create: (_) => AuthProvider(FirebaseAuth.instance, GoogleSignIn(), prefs)),
        ChangeNotifierProvider<UserProvider>(create: (context) => UserProvider(prefs, FirebaseStorage.instance)),
        StreamProvider<firebase_auth.User?>(
          create: (context) => context.read<AuthProvider>().authState,
          initialData: null,
        ),
      ],
      child: Observer(
        name: 'global-observer',
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: Strings.appName,
            theme: themeData,
            routes: Routes.routes,
            locale: Locale(_languageStore.locale),
            supportedLocales: _languageStore.supportedLanguages
                .map((language) => Locale(language.locale!, language.code))
                .toList(),
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}