import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jp_director/generated/l10n.dart';

import 'package:jp_director/providers/export_all_providers.dart';
import 'package:jp_director/services/local_storage.dart';

import 'constant.dart';

import 'api/jp_api.dart';

import 'providers/meta_event_provider.dart';
import 'router/router.dart';

import 'services/navigator_service.dart';
import 'services/notificacion_service.dart';

import 'ui/layouts/client_page_layout.dart';
import 'ui/layouts/user_page_layout.dart';
import 'ui/shared/widgets/progress_ind.dart';

void main() async {
  await LocalStorage.configurePrefs();
  JpApi.configureDio();
  Flurorouter.configureRoutes();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AllCursosProvider()),
        ChangeNotifierProvider(create: (_) => CursoModalProvider()),
        ChangeNotifierProvider(create: (_) => AllRespuestasProvider()),
        ChangeNotifierProvider(create: (_) => FormProvider()),
        ChangeNotifierProvider(create: (_) => PayProvider()),
        ChangeNotifierProvider(create: (_) => LeadsProvider()),
        ChangeNotifierProvider(create: (_) => LoginFormProvider()),
        ChangeNotifierProvider(create: (_) => RegisterFormProvider()),
        ChangeNotifierProvider(create: (_) => MetaEventProvider()),
        ChangeNotifierProvider(create: (_) => PageProvider()),
        ChangeNotifierProvider(create: (_) => UsersProvider()),
        ChangeNotifierProvider(lazy: false, create: (_) => SideBarProvider()),
        ChangeNotifierProvider(lazy: false, create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: bgColor, // <-- SEE HERE
      statusBarIconBrightness: Brightness.dark, //<-- For Android SEE HERE (dark icons)
      statusBarBrightness: Brightness.dark, //<-- For iOS SEE HERE (dark icons)
    ));
    return MaterialApp(
        scrollBehavior: MyCustomScrollBehavior(),
        debugShowCheckedModeBanner: false,
        title: 'JP Director',
        onGenerateRoute: Flurorouter.router.generator,
        navigatorKey: NavigatorService.navigatorKey,
        scaffoldMessengerKey: NotifServ.msgKey,
        builder: ((_, child) {
          if (authProvider.authStatus == AuthStatus.checking) return const ProgressInd();

          if (authProvider.authStatus == AuthStatus.authenticated) {
            // return const ProgressInd();
            return ClientPageLayout(
              child: child!,
            );
          } else {
            return UserPageLayout(
              child: child!,
            );
          }
        }),
        theme: ThemeData(
          scrollbarTheme: ScrollbarThemeData(
            thumbColor: MaterialStateProperty.all(azulText.withOpacity(0.1)),
          ),
          colorScheme: const ColorScheme.dark().copyWith(primary: azulText),
          splashColor: azulText.withOpacity(0.1),
          scaffoldBackgroundColor: bgColor,
        ),
        locale: authProvider.locale,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          AppLocalizations.delegate
        ],
        supportedLocales: AppLocalizations.delegate.supportedLocales);
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
