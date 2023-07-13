import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jpdirector_frontend/providers/all_cursos_provider.dart';
import 'package:jpdirector_frontend/providers/all_respuestas_provider.dart';
import 'package:jpdirector_frontend/providers/auth_provider.dart';
import 'package:jpdirector_frontend/providers/forms/login_form_provider.dart';
import 'package:jpdirector_frontend/providers/forms/register_form_provider.dart';
import 'package:jpdirector_frontend/providers/pay_provider.dart';
import 'package:jpdirector_frontend/providers/tarjeta_credito_provider.dart';
import 'package:jpdirector_frontend/ui/layouts/splash_layout.dart';

import 'package:provider/provider.dart';

import 'api/backend_google.dart';
import 'api/jp_api.dart';

import 'constant.dart';
import 'providers/baners_provider.dart';
import 'providers/forms/agendar_provider.dart';
import 'providers/form_provider.dart';
import 'providers/forms/curso_modal_provider.dart';
import 'providers/leads_provider.dart';
import 'providers/page_provider.dart';
import 'providers/sidebar_provider.dart';
import 'providers/users_provider.dart';
import 'router/router.dart';
import 'services/local_storage.dart';
import 'services/navigator_service.dart';
import 'services/notificacion_service.dart';
import 'ui/layouts/client_page_layout.dart';
import 'ui/layouts/user_page_layout.dart';

void main() async {
  await LocalStorage.configurePrefs();
  JpApi.configureDio();
  BackendGoogle.configureDio();
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
        ChangeNotifierProvider(create: (_) => AgendarProvider()),
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
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'JP-Director',
      onGenerateRoute: Flurorouter.router.generator,
      navigatorKey: NavigatorService.navigatorKey,
      scaffoldMessengerKey: NotificationServices.msgKey,
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
