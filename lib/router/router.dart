import 'package:fluro/fluro.dart';
import 'package:jpdirector_frontend/router/no_page_handler.dart';

import 'router_handlers.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

//root
  static String rootRoute = '/:page';
//home
  static String homeRoute = '/home';
  // rutas asesorias
  static String asesoriaRoute = '/v/asesoria';
  static String agendarRoute = '/form/agendar';
//rutas mentorias
  static String mentoriaRoute = '/v/mentoria';
  static String mentoriaFormRoute = '/form/mentoriaform';
// rutas encargado
  static String encargadoRoute = '/v/encargado';
  static String encargadoFormRoute = '/form/encargadoform';
// ruta conferencias
  static String conferenciasRoute = '/v/conferencias';
  static String conferenciasFormRoute = '/form/conferenciasform';
// ruta User
  static String loginRoute = '/user/login';
  static String registerRoute = '/user/register';

  //ruta pagos
  static String payRoute = '/pay';
  static String payNewUserRouteAlt = '/pay/new/';
  static String payNewUserRoute = '/pay/new/:cursoId';

  //verify route
  static String verifyRoute = '/auth/verify/:confirmCode';
  static String verifyRouteAlt = '/auth/verify';
  static String recoveryPassRoute = '/auth/resetPass/:token';
  static String resetPassRoute = '/auth/resetpass';
  static String newPassRoute = '/auth/newpass/:token';




// rutas cliente
  static String clienteDash = '/user/dashboard';
  static String clienteSeguridadDash = '/user/dashboard/seguridad';
  static String clienteMisCursosDash = '/user/dashboard/miscursos';
  static String clienteConfiguracionDash = '/user/dashboard/configuracion';
  static String cursoID = '/user/dashboard/:cursoID/:videoIndex';
  static String curso = '/user/dashboard/';
  // static String curso = '/curso';

  // rutas admin

  static String usersAdminDash = '/admin/users';
  static String usersIdAdminDash = '/admin/users/:id';

  static String cursosAdminDash = '/admin/cursos';
  static String cursosIdAdminDash = '/admin/cursos/:id';

  static String leadsAdminDash = '/admin/leads';
  static String formsAdminDash = '/admin/forms';
  static String banersAdminDash = '/admin/baners';

  // CONDICIONES Y TERMINOS
  static String tycRoute = '/doc/tyc';
  static String pdpRoute = '/doc/pdp';
  static String docRoute = '/doc';

  // rutas stripe
  static String successUrl = '/checkout/success/:email/:date';
  static String checksession = '/checkout/checksession';

  static void configureRoutes() {
// def de rutas
    router.define(rootRoute,
        handler: VisitorHandlers.home, transitionType: TransitionType.fadeIn, transitionDuration: const Duration(milliseconds: 100));

    router.define(homeRoute,
        handler: VisitorHandlers.home, transitionType: TransitionType.fadeIn, transitionDuration: const Duration(milliseconds: 100));

    router.define(payRoute,
        handler: VisitorHandlers.home, transitionType: TransitionType.fadeIn, transitionDuration: const Duration(milliseconds: 100));
    router.define(payNewUserRoute,
        handler: VisitorHandlers.payNewUser, transitionType: TransitionType.fadeIn, transitionDuration: const Duration(milliseconds: 100));
    router.define(payNewUserRouteAlt,
        handler: VisitorHandlers.payNewUser, transitionType: TransitionType.fadeIn, transitionDuration: const Duration(milliseconds: 100));

// Statics routes

    router.define(asesoriaRoute,
        handler: VisitorHandlers.asesoria, transitionType: TransitionType.fadeIn, transitionDuration: const Duration(milliseconds: 100));

    router.define(agendarRoute,
        handler: VisitorHandlers.agendar, transitionType: TransitionType.fadeIn, transitionDuration: const Duration(milliseconds: 100));

    router.define(mentoriaRoute,
        handler: VisitorHandlers.mentoria, transitionType: TransitionType.fadeIn, transitionDuration: const Duration(milliseconds: 100));

    router.define(mentoriaFormRoute,
        handler: VisitorHandlers.mentoriaForm, transitionType: TransitionType.fadeIn, transitionDuration: const Duration(milliseconds: 100));

    router.define(encargadoRoute,
        handler: VisitorHandlers.encargado, transitionType: TransitionType.fadeIn, transitionDuration: const Duration(milliseconds: 100));

    router.define(encargadoFormRoute,
        handler: VisitorHandlers.encargadoForm, transitionType: TransitionType.fadeIn, transitionDuration: const Duration(milliseconds: 100));

    router.define(conferenciasRoute,
        handler: VisitorHandlers.conferencias, transitionType: TransitionType.fadeIn, transitionDuration: const Duration(milliseconds: 100));

    router.define(conferenciasFormRoute,
        handler: VisitorHandlers.conferenciasForm, transitionType: TransitionType.fadeIn, transitionDuration: const Duration(milliseconds: 100));

// users route

    router.define(loginRoute,
        handler: UsersAuthHandlers.login, transitionType: TransitionType.fadeIn, transitionDuration: const Duration(milliseconds: 100));

    router.define(registerRoute,
        handler: UsersAuthHandlers.register, transitionType: TransitionType.fadeIn, transitionDuration: const Duration(milliseconds: 100));

//     router.define(recoveryPassRoute,
//         handler: UsersAuthHandlers.recovery, transitionType: TransitionType.inFromBottom, transitionDuration: Duration(milliseconds: 100));

    router.define(clienteDash,
        handler: UsersAuthHandlers.clientDashboard, transitionType: TransitionType.fadeIn, transitionDuration: const Duration(milliseconds: 100));

//     // router.define(clienteSeguridadDash,
//     //     handler: UsersAuthHandlers.clienteSeguridadDash,
//     //     transitionType: TransitionType.fadeIn,
//     //     transitionDuration: Duration(milliseconds: 100));

    router.define(clienteMisCursosDash,
        handler: UsersAuthHandlers.clienteMisCursosDash, transitionType: TransitionType.fadeIn, transitionDuration: const Duration(milliseconds: 100));

//     router.define(clienteConfiguracionDash,
//         handler: UsersAuthHandlers.clienteConfiguracionDash, transitionType: TransitionType.fadeIn, transitionDuration: Duration(milliseconds: 100));

    router.define(checksession,
        handler: UsersAuthHandlers.checksession, transitionType: TransitionType.fadeIn, transitionDuration: const Duration(milliseconds: 100));
    router.define(successUrl,
        handler: UsersAuthHandlers.successUrl, transitionType: TransitionType.fadeIn, transitionDuration: const Duration(milliseconds: 100));
    

    router.define(cursoID,
        handler: UsersAuthHandlers.cursoID, transitionType: TransitionType.fadeIn, transitionDuration: const Duration(milliseconds: 100));

    router.define(curso, handler: UsersAuthHandlers.cursoID, transitionType: TransitionType.fadeIn, transitionDuration: const Duration(milliseconds: 100));


    // Verify USER
    
    router.define(verifyRouteAlt, handler: UsersAuthHandlers.verify, transitionType: TransitionType.fadeIn, transitionDuration: const Duration(milliseconds: 100));
    router.define(verifyRoute, handler: UsersAuthHandlers.verify, transitionType: TransitionType.fadeIn, transitionDuration: const Duration(milliseconds: 100));
    router.define(resetPassRoute, handler: UsersAuthHandlers.resetPass, transitionType: TransitionType.fadeIn, transitionDuration: const Duration(milliseconds: 100));
    router.define(newPassRoute, handler: UsersAuthHandlers.newPass, transitionType: TransitionType.fadeIn, transitionDuration: const Duration(milliseconds: 100));

    // ADMIN ROUTES

    router.define(usersAdminDash, handler: AdminHandlers.usersAdminDash, transitionType: TransitionType.fadeIn, transitionDuration: const Duration(milliseconds: 100));
    router.define(leadsAdminDash, handler: AdminHandlers.leadsAdminDash, transitionType: TransitionType.fadeIn, transitionDuration: const Duration(milliseconds: 100));
    router.define(cursosAdminDash, handler: AdminHandlers.cursosAdminDash, transitionType: TransitionType.fadeIn, transitionDuration: const Duration(milliseconds: 100));
    router.define(formsAdminDash, handler: AdminHandlers.formsAdminDash, transitionType: TransitionType.fadeIn, transitionDuration: const Duration(milliseconds: 100));
    router.define(banersAdminDash, handler: AdminHandlers.banersAdminDash, transitionType: TransitionType.fadeIn, transitionDuration: const Duration(milliseconds: 100));
    



    // COPNDICIONES

    router.define(docRoute, handler: UsersAuthHandlers.doc, transitionType: TransitionType.fadeIn, transitionDuration: const Duration(milliseconds: 100));
    router.define(tycRoute, handler: UsersAuthHandlers.tyc, transitionType: TransitionType.fadeIn, transitionDuration: const Duration(milliseconds: 100));

    router.define(pdpRoute, handler: UsersAuthHandlers.pdp, transitionType: TransitionType.fadeIn, transitionDuration: const Duration(milliseconds: 100));

    // 404 System
    router.notFoundHandler = NoPageHandler.noPageFound;
  }
}
