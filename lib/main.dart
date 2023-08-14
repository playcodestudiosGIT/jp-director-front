import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:jpdirector_frontend/providers/export_all_providers.dart';
import 'package:jpdirector_frontend/services/local_storage.dart';

import 'constant.dart';

import 'api/jp_api.dart';

import 'router/router.dart';

import 'services/navigator_service.dart';
import 'services/notificacion_service.dart';

import 'ui/layouts/splash_layout.dart';
import 'ui/layouts/client_page_layout.dart';
import 'ui/layouts/user_page_layout.dart';

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
        ChangeNotifierProvider(create: (_) => BanersProvider()),
        ChangeNotifierProvider(create: (_) => PayProvider()),
        ChangeNotifierProvider(create: (_) => LeadsProvider()),
        ChangeNotifierProvider(create: (_) => LoginFormProvider()),
        ChangeNotifierProvider(create: (_) => RegisterFormProvider()),
        ChangeNotifierProvider(create: (_) => PageProvider()),
        ChangeNotifierProvider(create: (_) => UsersProvider()),
        ChangeNotifierProvider(create: (_) => TargetaCreditoProvider()),
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
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'JP Director',
      onGenerateRoute: Flurorouter.router.generator,
      navigatorKey: NavigatorService.navigatorKey,
      scaffoldMessengerKey: NotifServ.msgKey,
      builder: ((_, child) {
        final authProvider = Provider.of<AuthProvider>(context);

        if (authProvider.authStatus == AuthStatus.checking) return const SplashLayout();

        if (authProvider.authStatus == AuthStatus.authenticated) {
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
        scaffoldBackgroundColor: bgColor,
      ),
    );
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
