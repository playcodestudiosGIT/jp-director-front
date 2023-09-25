import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:jp_director/ui/views/dashboard/start_here_view.dart';
import '../ui/shared/widgets/progress_ind.dart';
import '../ui/views/static/asesoria_thx_view.dart';
import '../ui/views/system/soporte_view.dart';
import 'router.dart';

import 'package:jp_director/ui/views/ui_views.dart';
import '../providers/export_all_providers.dart';

class VisitorHandlers {
  static Handler asesoria = Handler(
    handlerFunc: (context, params) {
      return const AsesoriaPage();
    },
  );
  static Handler agendar = Handler(
    handlerFunc: (context, params) {
      return const AsesoriaAgendarPage();
    },
  );
  static Handler mentoria = Handler(
    handlerFunc: (context, params) {
      return const MentoriaPage();
    },
  );
  static Handler mentoriaForm = Handler(
    handlerFunc: (context, params) {
      return const FormulariosPage(
        rootForm: 'mentoria',
        index: 1,
      );
    },
  );
  static Handler encargado = Handler(
    handlerFunc: (context, params) {
      return const EncargadoPage();
    },
  );
  static Handler encargadoForm = Handler(
    handlerFunc: (context, params) {
      return const FormulariosPage(
        rootForm: 'encargado',
        index: 2,
      );
    },
  );
  static Handler conferencias = Handler(
    handlerFunc: (context, params) {
      return const ConferenciasPage();
    },
  );
  static Handler conferenciasForm = Handler(
    handlerFunc: (context, params) {
      return const FormulariosPage(
        rootForm: 'conferencias',
        index: 3,
      );
    },
  );
  static Handler cursoLanding = Handler(
    handlerFunc: (context, params) {
      final id = params['cursoId']?.first ?? '';
      return FutureBuilder(
        future: Provider.of<AllCursosProvider>(context!, listen: false)
            .getCursosById(id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const ProgressInd();
          }

          return LandingCurso(
            cursoID: id,
          );
        },
      );
    },
  );

  static Handler payNewUser = Handler(
    handlerFunc: (context, params) {
      final cursoId = params['cursoId']?.first ?? '';
      String? state = params['state']?.first ?? 'register';
      final authProvider = Provider.of<AuthProvider>(context!, listen: false);

      if (cursoId.isEmpty) return const LoginPage();

      if (authProvider.authStatus == AuthStatus.notAuthenticated) {
        Provider.of<AllCursosProvider>(context, listen: false)
            .getCursosById(cursoId);

        return CreateUserCheckout(cursoId: cursoId, state: state);
      } else {
        // return const NewCursoCheckout();
        return const Placeholder();
      }
    },
  );

  static Handler successUrl = Handler(
    handlerFunc: (context, params) {
      final name = params['invitee_full_name']?.first;
      final fecha = params['event_start_time']?.first;
      print(name);
      print(fecha);
      return AsesoriaThxView(nombre: name.toString(), fecha: fecha.toString(),);
    },
  );

//   // static nav

  static Handler home = Handler(handlerFunc: (context, params) {
    final page = params['page']!.first;

    Provider.of<SideBarProvider>(context!, listen: false)
        .setCurrentPageUrl(Flurorouter.rootRoute);
    if (page.isEmpty) {
      return const HomeBody(index: 0);
    }

    if (page == '/') {
      return const HomeBody(index: 0);
    }
    if (page == 'support') {
      Provider.of<SideBarProvider>(context, listen: false)
          .setCurrentPageUrl(Flurorouter.supportRoute);
      return const SoporteView();
    }
    if (page == 'home') {
      return const HomeBody(index: 0);
    }
    if (page == 'cursos') {
      return const HomeBody(index: 1);
    }
    if (page == 'servicios') {
      return const HomeBody(index: 2);
    }
    if (page == 'resultados') {
      return const HomeBody(index: 3);
    }
    if (page == 'contacto') {
      return const HomeBody(index: 4);
    }
    if (page == 'checkout') {
      return const DashMisCursosView();
    }
    if (page != '/') {
      return const NoPageFound();
    }
    return null;
  });
}

class UsersAuthHandlers {
  static Handler login = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    if (authProvider.authStatus == AuthStatus.notAuthenticated) {
      return const LoginPage();
    } else {
      Provider.of<AllCursosProvider>(context, listen: false)
          .obtenerMisCursos(authProvider.user!);
      Provider.of<SideBarProvider>(context, listen: false)
          .setCurrentPageUrl(Flurorouter.clienteMisCursosDash);
      return const DashMisCursosView();
    }
  });

  static Handler verify = Handler(handlerFunc: (context, params) {
    final confirmCode = params['confirmCode']?.first ?? '';

    return VerifyUserPage(
      confirmCode: confirmCode,
    );
  });

  static Handler resetPass = Handler(handlerFunc: (context, params) {
    return const ResetPass();
  });

  static Handler newPass = Handler(handlerFunc: (context, params) {
    final token = params['token']!.first;
    return NewPassword(token: token);
  });

  static Handler register = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    if (authProvider.authStatus == AuthStatus.notAuthenticated) {
      return const RegisterPage();
    } else {
      Provider.of<SideBarProvider>(context, listen: false)
          .setCurrentPageUrl(Flurorouter.clienteMisCursosDash);
      return const DashMisCursosView();
    }
  });

  static Handler checksession = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    if (authProvider.user == null) return const LoginPage();
    final cursoId = params['cursoId']?.first ?? '';

    //create agenda
    return CheckoutThxView(
      cursoId: cursoId,
    );
  });

  static Handler cursoID = Handler(handlerFunc: (context, params) {
    final cursoID = params['cursoID']!.first;
    final videoIndex = params['videoIndex']?.first ?? '0';

    if (cursoID.isEmpty) {
      Provider.of<SideBarProvider>(context!, listen: false)
          .setCurrentPageUrl(Flurorouter.clienteMisCursosDash);
      return const DashMisCursosView();
    }

    final authProvider = Provider.of<AuthProvider>(context!, listen: false);

    if (authProvider.authStatus == AuthStatus.notAuthenticated) {
      return const LoginPage();
    }

    if (!authProvider.user!.cursos.contains(cursoID)) {
      return LandingCurso(
        cursoID: cursoID,
      );
    }

    return FutureBuilder(
      future: Provider.of<AllCursosProvider>(context, listen: false)
          .getCursosById(cursoID),
      builder: (context, snapshot) {
        final curso = snapshot.data;
        Provider.of<SideBarProvider>(context, listen: false)
            .setCurrentPageUrl('');
        return (curso == null || curso.nombre == 'nombre')
            ? const ProgressInd()
            : CourseView(
                videoIndex: int.parse(videoIndex),
                cursoTmp: curso,
              );
      },
    );
  });

  static Handler tyc = Handler(handlerFunc: (context, params) {
    Provider.of<SideBarProvider>(context!, listen: false).setCurrentPageUrl('');
    return const TycView();
  });
  static Handler start = Handler(handlerFunc: (context, params) {
    Provider.of<SideBarProvider>(context!, listen: false)
        .setCurrentPageUrl(Flurorouter.start);
    return const StartHereView();
  });

  static Handler doc = Handler(handlerFunc: (context, params) {
    Provider.of<SideBarProvider>(context!, listen: false).setCurrentPageUrl('');
    return const HomeBody();
  });

  static Handler pdp = Handler(handlerFunc: (context, params) {
    Provider.of<SideBarProvider>(context!, listen: false).setCurrentPageUrl('');
    return const PdpView();
  });

  // DASHBOARD

  static Handler clientDashboard = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);

    if (authProvider.authStatus == AuthStatus.notAuthenticated) {
      return const LoginPage();
    }
    Provider.of<SideBarProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.clienteDash);
    return const DashMiCuenta();
  });

  static Handler clienteMisCursosDash = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    if (authProvider.authStatus == AuthStatus.notAuthenticated) {
      return const LoginPage();
    } else {
      Provider.of<SideBarProvider>(context, listen: false)
          .setCurrentPageUrl(Flurorouter.clienteMisCursosDash);
      return const DashMisCursosView();
    }
  });
}

class AdminHandlers {
  static Handler usersAdminDash = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    if (authProvider.authStatus == AuthStatus.notAuthenticated ||
        authProvider.user!.rol != 'ADMIN_ROLE') {
      return const HomeBody();
    } else {
      Provider.of<SideBarProvider>(context, listen: false)
          .setCurrentPageUrl(Flurorouter.usersAdminDash);
      return const UsersAdminView();
    }
  });

  static Handler leadsAdminDash = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    if (authProvider.authStatus == AuthStatus.notAuthenticated ||
        authProvider.user!.rol != 'ADMIN_ROLE') {
      return const HomeBody();
    } else {
      Provider.of<SideBarProvider>(context, listen: false)
          .setCurrentPageUrl(Flurorouter.leadsAdminDash);
      Provider.of<LeadsProvider>(context, listen: false).getLeads();
      return const LeadsAdminView();
    }
  });
  static Handler cursosAdminDash = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    if (authProvider.authStatus == AuthStatus.notAuthenticated ||
        authProvider.user!.rol != 'ADMIN_ROLE') {
      return const HomeBody();
    } else {
      Provider.of<SideBarProvider>(context, listen: false)
          .setCurrentPageUrl(Flurorouter.cursosAdminDash);
      return const CursosAdminView();
    }
  });
  static Handler formsAdminDash = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    if (authProvider.authStatus == AuthStatus.notAuthenticated ||
        authProvider.user!.rol != 'ADMIN_ROLE') {
      return const HomeBody();
    } else {
      Provider.of<SideBarProvider>(context, listen: false)
          .setCurrentPageUrl(Flurorouter.formsAdminDash);
      return const FormAdminView();
    }
  });
}
