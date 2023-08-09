import 'dart:js_interop';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/extension.dart';
import 'package:jpdirector_frontend/providers/all_cursos_provider.dart';
import 'package:jpdirector_frontend/providers/baners_provider.dart';
import 'package:jpdirector_frontend/providers/leads_provider.dart';
import 'package:jpdirector_frontend/ui/shared/widgets/asesoria_slider/tdc_pay.dart';
import 'package:jpdirector_frontend/ui/views/admin_dash/baners_admin_view.dart';
import 'package:jpdirector_frontend/ui/views/admin_dash/cursos_admin_view.dart';
import 'package:jpdirector_frontend/ui/views/admin_dash/forms_admin_view.dart';
import 'package:jpdirector_frontend/ui/views/admin_dash/leads_admin_view.dart';
import 'package:jpdirector_frontend/ui/views/admin_dash/users_admin_view.dart';
import 'package:jpdirector_frontend/ui/views/home_views/home_body.dart';
import 'package:jpdirector_frontend/ui/views/landing/landing_curso.dart';
import 'package:jpdirector_frontend/ui/views/static/checkout_thx_view.dart';
import 'package:jpdirector_frontend/ui/views/static/new_password.dart';
import 'package:jpdirector_frontend/ui/views/static/reset_password.dart';
import 'package:jpdirector_frontend/ui/views/static/verify_user_page.dart';
import 'package:provider/provider.dart';

import '../models/baner.dart';
import '../providers/auth_provider.dart';
import '../providers/sidebar_provider.dart';
import '../ui/pdp_view.dart';
import '../ui/tyc_view.dart';
import '../ui/views/dashboard/course_view.dart';
import '../ui/views/dashboard/dash_mi_cuenta_view.dart';
import '../ui/views/dashboard/dash_mis_cursos_view.dart';
import '../ui/views/home_views/checkout_ads/create_user_checkout.dart';
import '../ui/views/login/login_page.dart';
import '../ui/views/login/resgister_page.dart';
import '../ui/views/no_page_found.dart';
import '../ui/views/static/agenda_thx_view.dart';
import '../ui/views/static/asesoria_agendar_page.dart';
import '../ui/views/static/asesoria_page.dart';
import '../ui/views/static/conferencias_page.dart';
import '../ui/views/static/encargado_page.dart';
import '../ui/views/static/formularios_page.dart';
import '../ui/views/static/mentoria_page.dart';
import 'router.dart';

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
        future: Provider.of<AllCursosProvider>(context!, listen: false).getCursosById(id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: SizedBox(width: 35, height: 35, child: CircularProgressIndicator()));
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
      final cursoId = params['cursoId']!.first;
      String? state = params['state']?.first ?? 'register';

      if (cursoId.isNull) return const LoginPage();

      final authProvider = Provider.of<AuthProvider>(context!, listen: false);
      if (authProvider.authStatus == AuthStatus.notAuthenticated) {
        Provider.of<AllCursosProvider>(context, listen: false).getCursosById(cursoId);
        Provider.of<BanersProvider>(context, listen: false).getBaners();
        final Baner? baner = Provider.of<BanersProvider>(context, listen: false)
            .baners
            .where(
              (element) => element.cursoId == cursoId,
            )
            .firstOrNull;

        return CreateUserCheckout(cursoId: cursoId, priceId: baner?.priceId ?? '', state: state);
      } else {
        // return const NewCursoCheckout();
        return const Placeholder();
      }
    },
  );

//   // static nav

  static Handler home = Handler(handlerFunc: (context, params) {
    final page = params['page']!.first;

    Provider.of<SideBarProvider>(context!, listen: false).setCurrentPageUrl(Flurorouter.rootRoute);
    if (page.isNullOrEmpty) {
      return const HomeBody(index: 0);
    }

    if (page == '/') {
      return const HomeBody(index: 0);
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
    if (page == 'pay') {
      return const TdcPay();
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
      Provider.of<SideBarProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.clienteMisCursosDash);
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
      Provider.of<SideBarProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.clienteMisCursosDash);
      return const DashMisCursosView();
    }
  });

  static Handler successUrl = Handler(handlerFunc: (context, params) {
    final date = params['date']!.first;
    final email = params['email']!.first;

    //create agenda
    return AgendaThxView(
      date: date,
      email: email,
    );
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

  static Handler payTdc = Handler(handlerFunc: (context, params) {
    //create agenda
    return Builder(
      builder: (context) {
        return const TdcPay();
      },
    );
  });

  static Handler cursoID = Handler(handlerFunc: (context, params) {
    final cursoID = params['cursoID']!.first;
    final videoIndex = params['videoIndex']!.first;

    if (cursoID.isEmpty) return const DashMisCursosView();

    final authProvider = Provider.of<AuthProvider>(context!, listen: false);

    if (authProvider.authStatus == AuthStatus.notAuthenticated) return const LoginPage();

    if (!authProvider.user!.cursos.contains(cursoID)) {
      return FutureBuilder(
        // future: Provider.of<AllCursosProvider>(context, listen: false).getCursosById(cursoID),
        builder: (context, snapshot) {
          return LandingCurso(
            cursoID: cursoID,
          );
        },
      );
    }

    return FutureBuilder(
      future: Provider.of<AllCursosProvider>(context, listen: false).getCursosById(cursoID),
      builder: (context, snapshot) {
        final curso = Provider.of<AllCursosProvider>(context, listen: false).cursoView;
        Provider.of<SideBarProvider>(context, listen: false).setCurrentPageUrl('');
        return (curso.nombre == 'nombre')
            ? const Center(child: SizedBox(width: 35, height: 35, child: CircularProgressIndicator()))
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

    if (authProvider.authStatus == AuthStatus.notAuthenticated) return const LoginPage();
    Provider.of<SideBarProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.clienteDash);
    return DashMiCuenta();
  });

  static Handler clienteMisCursosDash = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    if (authProvider.authStatus == AuthStatus.notAuthenticated) {
      return const LoginPage();
    } else {
      Provider.of<BanersProvider>(context, listen: false).getBaners();
      Provider.of<AllCursosProvider>(context, listen: false).obtenerMisCursos(authProvider.user!);
      Provider.of<SideBarProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.clienteMisCursosDash);
      return const DashMisCursosView();
    }
  });
}

class AdminHandlers {
  static Handler usersAdminDash = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    if (authProvider.authStatus == AuthStatus.notAuthenticated || authProvider.user!.rol != 'ADMIN_ROLE') {
      return const HomeBody();
    } else {
      Provider.of<SideBarProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.usersAdminDash);
      return const UsersAdminView();
    }
  });

  static Handler leadsAdminDash = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    if (authProvider.authStatus == AuthStatus.notAuthenticated || authProvider.user!.rol != 'ADMIN_ROLE') {
      return const HomeBody();
    } else {
      Provider.of<SideBarProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.leadsAdminDash);
      Provider.of<LeadsProvider>(context, listen: false).getLeads();
      return const LeadsAdminView();
    }
  });
  static Handler cursosAdminDash = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    if (authProvider.authStatus == AuthStatus.notAuthenticated || authProvider.user!.rol != 'ADMIN_ROLE') {
      return const HomeBody();
    } else {
      Provider.of<SideBarProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.cursosAdminDash);
      // Provider.of<LeadsProvider>(context, listen: false).getLeads();
      return const CursosAdminView();
    }
  });
  static Handler formsAdminDash = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    if (authProvider.authStatus == AuthStatus.notAuthenticated || authProvider.user!.rol != 'ADMIN_ROLE') {
      return const HomeBody();
    } else {
      Provider.of<SideBarProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.formsAdminDash);
      return const FormAdminView();
    }
  });
  static Handler banersAdminDash = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!, listen: false);
    if (authProvider.authStatus == AuthStatus.notAuthenticated || authProvider.user!.rol != 'ADMIN_ROLE') {
      return const HomeBody();
    } else {
      Provider.of<SideBarProvider>(context, listen: false).setCurrentPageUrl(Flurorouter.banersAdminDash);
      return const BanersAdminView();
    }
  });
}
