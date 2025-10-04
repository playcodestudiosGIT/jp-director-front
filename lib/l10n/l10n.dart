import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_en.dart';
import 'l10n_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @educacionYEstrategia.
  ///
  /// In en, this message translates to:
  /// **'Education and\nADS Strategy'**
  String get educacionYEstrategia;

  /// No description provided for @llegasteAlMundo.
  ///
  /// In en, this message translates to:
  /// **'You arrived in the right place'**
  String get llegasteAlMundo;

  /// No description provided for @siu.
  ///
  /// In en, this message translates to:
  /// **'IF'**
  String get siu;

  /// No description provided for @buscasAcelerar.
  ///
  /// In en, this message translates to:
  /// **'Looking to accelerate your business with advertising'**
  String get buscasAcelerar;

  /// No description provided for @quieresConseguir.
  ///
  /// In en, this message translates to:
  /// **'Want to get more clients'**
  String get quieresConseguir;

  /// No description provided for @quieresTener.
  ///
  /// In en, this message translates to:
  /// **'Want to have a mentor who teaches you the right way'**
  String get quieresTener;

  /// No description provided for @deseasDejar.
  ///
  /// In en, this message translates to:
  /// **'Wish to stop feeling anguish over non-converting results'**
  String get deseasDejar;

  /// No description provided for @descubreComo.
  ///
  /// In en, this message translates to:
  /// **'Discover how to boost your business'**
  String get descubreComo;

  /// No description provided for @aprendeTodoAds.
  ///
  /// In en, this message translates to:
  /// **'LEARN EVERYTHING ABOUT ADS'**
  String get aprendeTodoAds;

  /// No description provided for @cursos.
  ///
  /// In en, this message translates to:
  /// **'Courses'**
  String get cursos;

  /// No description provided for @consigueClientesQueQuieran.
  ///
  /// In en, this message translates to:
  /// **'Get clients who want to buy your product or service\nusing the platform you arrived here with:\nInstagram - Facebook - TikTok'**
  String get consigueClientesQueQuieran;

  /// No description provided for @servicios.
  ///
  /// In en, this message translates to:
  /// **'SERVICES'**
  String get servicios;

  /// No description provided for @asesoria11.
  ///
  /// In en, this message translates to:
  /// **'1:1 CONSULTING'**
  String get asesoria11;

  /// No description provided for @mentoria.
  ///
  /// In en, this message translates to:
  /// **'MENTORING'**
  String get mentoria;

  /// No description provided for @serElEncargado.
  ///
  /// In en, this message translates to:
  /// **'BE THE ONE IN CHARGE'**
  String get serElEncargado;

  /// No description provided for @conferencias.
  ///
  /// In en, this message translates to:
  /// **'CONFERENCES'**
  String get conferencias;

  /// No description provided for @miraloOjos.
  ///
  /// In en, this message translates to:
  /// **'SEE IT WITH YOUR OWN EYES'**
  String get miraloOjos;

  /// No description provided for @contactoLargeText.
  ///
  /// In en, this message translates to:
  /// **'For the past 5 years, I have been committed to empowering and educating with effective advertising strategies that hit the mark.\nWith a track record of more than \$12,000,000 USD invested and a return of more than \$160,000,000 USD in advertising campaigns on Facebook, Instagram, and TikTok, I affirm that business success consists of:\n1. An excellent advertising strategy.\n2. Analyzing and optimizing data.\n3. Having an experienced professional by your side.\nMy mission is to be the one in charge or mentor, accompanying you to success throughout the advertising process.'**
  String get contactoLargeText;

  /// No description provided for @descargaRegaloBtn.
  ///
  /// In en, this message translates to:
  /// **'DOWNLOAD THIS GIFT'**
  String get descargaRegaloBtn;

  /// No description provided for @siTienesDudas.
  ///
  /// In en, this message translates to:
  /// **'If you have any questions, contact me via '**
  String get siTienesDudas;

  /// No description provided for @derechosReservados.
  ///
  /// In en, this message translates to:
  /// **'ALL RIGHTS RESERVED'**
  String get derechosReservados;

  /// No description provided for @politicasDeProivacidad.
  ///
  /// In en, this message translates to:
  /// **'PRIVACY POLICY'**
  String get politicasDeProivacidad;

  /// No description provided for @terminosYCondiciones.
  ///
  /// In en, this message translates to:
  /// **'TERMS AND CONDITIONS'**
  String get terminosYCondiciones;

  /// No description provided for @topBotonCursos.
  ///
  /// In en, this message translates to:
  /// **'COURSES'**
  String get topBotonCursos;

  /// No description provided for @topBotonServicios.
  ///
  /// In en, this message translates to:
  /// **'SERVICES'**
  String get topBotonServicios;

  /// No description provided for @topBotonResultados.
  ///
  /// In en, this message translates to:
  /// **'RESULTS'**
  String get topBotonResultados;

  /// No description provided for @topBotonBlog.
  ///
  /// In en, this message translates to:
  /// **'BLOG'**
  String get topBotonBlog;

  /// No description provided for @topBotonContacto.
  ///
  /// In en, this message translates to:
  /// **'CONTACT'**
  String get topBotonContacto;

  /// No description provided for @botonLogin.
  ///
  /// In en, this message translates to:
  /// **'LOGIN'**
  String get botonLogin;

  /// No description provided for @botonReg.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get botonReg;

  /// No description provided for @completPers.
  ///
  /// In en, this message translates to:
  /// **'COMPLETELY PERSONALIZED'**
  String get completPers;

  /// No description provided for @enUnaVideollamada.
  ///
  /// In en, this message translates to:
  /// **'In a 1-hour video call, we will discuss:\nCampaigns, Budgets, Strategies, Current Issues, Disabling Issues, and anything you want to clarify or learn.'**
  String get enUnaVideollamada;

  /// No description provided for @resolvamosEsto.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Resolve This'**
  String get resolvamosEsto;

  /// No description provided for @quieroMiAsesoriaBtn.
  ///
  /// In en, this message translates to:
  /// **'I Want My Consultation'**
  String get quieroMiAsesoriaBtn;

  /// No description provided for @mentoriaIntensiva.
  ///
  /// In en, this message translates to:
  /// **'INTENSIVE MENTORING'**
  String get mentoriaIntensiva;

  /// No description provided for @inteligenteInv.
  ///
  /// In en, this message translates to:
  /// **'SMART INVESTMENT'**
  String get inteligenteInv;

  /// No description provided for @tenerUnMentor.
  ///
  /// In en, this message translates to:
  /// **'Having a mentor drastically accelerates the success of your business. For 2 months, I will be with you, hands-on, creating your advertising plan and teaching you how to do it yourself.'**
  String get tenerUnMentor;

  /// No description provided for @masInformacionBtn.
  ///
  /// In en, this message translates to:
  /// **'More Information'**
  String get masInformacionBtn;

  /// No description provided for @soyElResp.
  ///
  /// In en, this message translates to:
  /// **'I AM RESPONSIBLE FOR YOUR SUCCESS'**
  String get soyElResp;

  /// No description provided for @estasEnElMomento.
  ///
  /// In en, this message translates to:
  /// **'Do you need to hire a specialist to increase your customer flow, business visits, and SALES?'**
  String get estasEnElMomento;

  /// No description provided for @cuentaConmigo.
  ///
  /// In en, this message translates to:
  /// **'Count on Me'**
  String get cuentaConmigo;

  /// No description provided for @agendarLlamadaBtn.
  ///
  /// In en, this message translates to:
  /// **'Schedule a Call'**
  String get agendarLlamadaBtn;

  /// No description provided for @contratamePara.
  ///
  /// In en, this message translates to:
  /// **'Hire me to showcase the importance of online advertising tailored to the industry you desire: Insurance, Lawyers, Real Estate, Doctors, Beauty Salons, Coaching, Restaurants, and all businesses or startups that need real-world examples for advertising.'**
  String get contratamePara;

  /// No description provided for @agendarBtn.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get agendarBtn;

  /// No description provided for @videollamada.
  ///
  /// In en, this message translates to:
  /// **'VIDEO CALL'**
  String get videollamada;

  /// No description provided for @conTuNeg.
  ///
  /// In en, this message translates to:
  /// **'with YOUR BUSINESS'**
  String get conTuNeg;

  /// No description provided for @unoAuno.
  ///
  /// In en, this message translates to:
  /// **'ONE-ON-ONE'**
  String get unoAuno;

  /// No description provided for @precio11.
  ///
  /// In en, this message translates to:
  /// **'\$280'**
  String get precio11;

  /// No description provided for @usd.
  ///
  /// In en, this message translates to:
  /// **'USD'**
  String get usd;

  /// No description provided for @xHora.
  ///
  /// In en, this message translates to:
  /// **'per hour'**
  String get xHora;

  /// No description provided for @xdondeComenzar.
  ///
  /// In en, this message translates to:
  /// **'Where to Begin?'**
  String get xdondeComenzar;

  /// No description provided for @xdondeComenzarResp.
  ///
  /// In en, this message translates to:
  /// **'Being alone in the process can be difficult, trying to understand the platform, how much daily budget to invest, making mistakes, getting disabled, not knowing if the strategy will work, and how to analyze the results can be a headache.\n\nThat\'s why this consultation will help you get a more accurate picture of what you need and accelerate the process your business should have.\n\nWith my experience in the world of digital advertising, I can provide you with a clearer vision of what you require to increase sales.\n\nIn 2021, I started offering these consultations and have perfected the methodology so you can use this time to clarify all your doubts, solve those common mistakes that hinder your progress, correct them, and hit the mark in positioning your business.\n\nUpon purchasing the service, you will receive an email with the information you need for that day, allowing us to make the most of the consultation.'**
  String get xdondeComenzarResp;

  /// No description provided for @queHablaremos.
  ///
  /// In en, this message translates to:
  /// **'What Will We Discuss in the Meeting?'**
  String get queHablaremos;

  /// No description provided for @queHablaremosResp.
  ///
  /// In en, this message translates to:
  /// **'Business Plan\nI will analyze whether your proposal will be profitable with the services or products you want to market online.\n\nCampaigns\nWhether created or not, I will review their structure and strategy strategically.\n\nWebsite\nI will examine the entire structure and provide you with the means to sell more through your website.\n\nSales Method\nDepending on the methodology, we will improve how you close deals with your customers.'**
  String get queHablaremosResp;

  /// No description provided for @preguntasfrecuentes.
  ///
  /// In en, this message translates to:
  /// **'Frequently Asked Questions'**
  String get preguntasfrecuentes;

  /// No description provided for @preguntasfrecuentesResp.
  ///
  /// In en, this message translates to:
  /// **'Does it matter if I know nothing about Facebook - Instagram or Tik Tok Ads?\nNo, think of it as private lessons just for you.\n\nIf I already know and run campaigns, is this for me?\nYes, I will give your business a general examination and show you how to improve in the areas where you are struggling with ads.\n\nCan I extend our call beyond 1 hour?\nCertainly, if you need more lessons, we can coordinate the time and day for additional sessions at the end of our meeting. Be prepared for this challenge; I will send you many tasks.\n\nWhere will the video call take place?\nIt will be conducted through the Zoom platform.\n\nWhat if I\'m not satisfied with my mentoring?\nIf it\'s not what you expected, I will refund your entire payment.\n\nI encountered an issue, can I reschedule our meeting?\nYou have 24 hours at the latest to schedule another day and time. You must notify us at the following email address: hola@jpdirector.net.\n\nIf you fail to do so within that time, you will lose your investment and need to pay for a new consultation.'**
  String get preguntasfrecuentesResp;

  /// No description provided for @duranteElPrimerMes.
  ///
  /// In en, this message translates to:
  /// **'During the first month, I will teach you everything I know, and together we will create and launch your advertising plan where you will learn the right way to grow your business.\n\nIn the following month, we will have several results analysis sessions with the plan we developed, progressively optimizing your advertising.'**
  String get duranteElPrimerMes;

  /// No description provided for @estoyListoBtn.
  ///
  /// In en, this message translates to:
  /// **'I\'m Ready, Let\'s Begin.'**
  String get estoyListoBtn;

  /// No description provided for @queVeremos3m.
  ///
  /// In en, this message translates to:
  /// **'What Will We Cover During These 2 Months?'**
  String get queVeremos3m;

  /// No description provided for @queVeremos3mResp.
  ///
  /// In en, this message translates to:
  /// **'-From zero to 100, all the factors and tools necessary for your advertising strategy.\n\n-Comprehensive education in Instagram - Facebook - Tik Tok for running profitable advertising campaigns.\n\n-Strategy and results analysis for optimization decisions.'**
  String get queVeremos3mResp;

  /// No description provided for @preguntasfrecuentes1Resp.
  ///
  /// In en, this message translates to:
  /// **'1. Do I need a high budget to invest in my campaigns?\nThis is very relative and depends on your product or service. What you do need to consider is having at least \$3000 USD to conduct numerous tests and perform a thorough results analysis during this time.\n\n2. I understand a lot, but I want more details.\nSince this service is specialized, we will have a 20-minute video call to determine if your business is prepared and committed. During the call, I will explain in more detail all your doubts.\n\n3. What is the cost of intensive mentoring?\nThe price starts at \$12,000 USD, depending on multiple factors that we will discuss in the video call.\n\n4. Not a question, I want you to be my mentor!\nCalm down, let\'s have a conversation first and see if you are prepared and meet the requirements. If you are reading this, you already have the first requirement: Willingness.'**
  String get preguntasfrecuentes1Resp;

  /// No description provided for @esteServicioEsta.
  ///
  /// In en, this message translates to:
  /// **'This service is designed for you, who are looking for someone to take care of the strategy and management of your brand\'s advertising. I will focus on growth, acquiring quality leads, and increasing sales.'**
  String get esteServicioEsta;

  /// No description provided for @como.
  ///
  /// In en, this message translates to:
  /// **'How?'**
  String get como;

  /// No description provided for @disenoEstrat.
  ///
  /// In en, this message translates to:
  /// **'Strategy Design'**
  String get disenoEstrat;

  /// No description provided for @disenoEstratResp.
  ///
  /// In en, this message translates to:
  /// **'I will develop clear and precise strategies with defined timelines, prioritizing your different ideal customers, supported by all the necessary research to persuasively impact them.'**
  String get disenoEstratResp;

  /// No description provided for @confCampanas.
  ///
  /// In en, this message translates to:
  /// **'Campaign Setup'**
  String get confCampanas;

  /// No description provided for @confCampanasResp.
  ///
  /// In en, this message translates to:
  /// **'I will handle all the technical aspects within the platform to ensure that campaigns run smoothly according to the established strategy.'**
  String get confCampanasResp;

  /// No description provided for @optimizacion.
  ///
  /// In en, this message translates to:
  /// **'Optimization'**
  String get optimizacion;

  /// No description provided for @optimizacionResp.
  ///
  /// In en, this message translates to:
  /// **'Effective optimization means analyzing the data and making decisions to improve results over time, ensuring continuous success.'**
  String get optimizacionResp;

  /// No description provided for @porQueYo.
  ///
  /// In en, this message translates to:
  /// **'Why Me?'**
  String get porQueYo;

  /// No description provided for @porQueYoResp.
  ///
  /// In en, this message translates to:
  /// **'SELECTIVE AND SINCERE\nBeing in charge of your brand requires commitment and responsibility. That\'s why I will thoroughly analyze your business before we start to determine if you meet all the requirements for me to support you.\n\nIf it\'s a YES, we will create an effective action plan.\n\nIf it\'s a NO, I will provide honest feedback and refer you to the specialist or plan your business needs.\n\nPRICE BASED ON YOUR BUSINESS MODEL\nOne of my distinguishing features is that I thoroughly review your business before starting, and even by evaluating it together with you, I can determine if you are ready to take this step.\n\nMy promise is that when you purchase my service, it will be a great relief, and you will see results.\n\nEXPERIENCE AND RESULTS\nFrom strategy creation, copywriting, creative ads, segmentation, web conversion funnels, budget management, to results analysis, these are all within my capabilities for taking on this role.'**
  String get porQueYoResp;

  /// No description provided for @preguntasfrecuentes2Resp.
  ///
  /// In en, this message translates to:
  /// **'What is the average cost for you to take charge of advertising for my business?\nThe price starts at \$6000 and goes up, depending on many factors and the goals you have as a business. That\'s why I take the time to analyze in advance and determine if I can take on the project.\n\nWill I see results immediately?\nThis is a common question, and it depends on how the strategy is implemented, your product, price, and perceived value to your audience.\n\nThe correct answer is that I will ensure you make a smart impact on your target audience.\n\nOnce I fill out the form, what will happen?\nWithin 2 to 3 days, I will contact you to provide all the details. We will have a 30-minute meeting to fully understand your needs and numbers.'**
  String get preguntasfrecuentes2Resp;

  /// No description provided for @recuerdaPrimero.
  ///
  /// In en, this message translates to:
  /// **'Remember: First, we will have a conversation to create a checklist for your business and analyze what you need most at this moment.'**
  String get recuerdaPrimero;

  /// No description provided for @empezamosBtn.
  ///
  /// In en, this message translates to:
  /// **'Shall We Begin?'**
  String get empezamosBtn;

  /// No description provided for @seamosSinceros.
  ///
  /// In en, this message translates to:
  /// **'Let\'s be honest, we\'re in the era of personalization.\n\nThat\'s why when you hire me for your conference, I will focus on the topics that DO interest them, educating and entertaining all event participants.'**
  String get seamosSinceros;

  /// No description provided for @queHablareEvento.
  ///
  /// In en, this message translates to:
  /// **'What will I talk about during your event?'**
  String get queHablareEvento;

  /// No description provided for @pubOnline.
  ///
  /// In en, this message translates to:
  /// **'Online Advertising'**
  String get pubOnline;

  /// No description provided for @pubOnlineResp.
  ///
  /// In en, this message translates to:
  /// **'The importance of being present and ways to achieve success with real-world cases.'**
  String get pubOnlineResp;

  /// No description provided for @actRapidez.
  ///
  /// In en, this message translates to:
  /// **'Technology Updates and Speed'**
  String get actRapidez;

  /// No description provided for @actRapidezResp.
  ///
  /// In en, this message translates to:
  /// **'I\'m sure an update of some tool or a new functionality came out while you were reading this. That\'s why on that day, we will discuss the latest trends of 2025.'**
  String get actRapidezResp;

  /// No description provided for @motivacion.
  ///
  /// In en, this message translates to:
  /// **'Motivation'**
  String get motivacion;

  /// No description provided for @motivacionResp.
  ///
  /// In en, this message translates to:
  /// **'It takes a lot of courage to run a business or meet daily goals. That\'s why I share my journey to inspire and set an example that it IS possible.'**
  String get motivacionResp;

  /// No description provided for @casosEsp.
  ///
  /// In en, this message translates to:
  /// **'Specialized Cases'**
  String get casosEsp;

  /// No description provided for @casosEspResp.
  ///
  /// In en, this message translates to:
  /// **'Imagine you\'re an insurance company and you want examples of how to advertise. Well then, let\'s get to work. I will present topics and cases that you can understand and apply in your daily operations.'**
  String get casosEspResp;

  /// No description provided for @preguntasfrecuentes3Resp.
  ///
  /// In en, this message translates to:
  /// **'How does the process work to schedule the date?\nWrite to me at hola@jpdirector.net to check if that date is available. If it is, you can make a two-part payment: 50% of the conference price upfront, and the remaining 50% must be paid five days before the event.\n\nCan you attend any state within the United States?\nOf course, we just need to coordinate flight tickets, accommodation, and expenses.'**
  String get preguntasfrecuentes3Resp;

  /// No description provided for @correoForm.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get correoForm;

  /// No description provided for @nombreyapellidoForm.
  ///
  /// In en, this message translates to:
  /// **'Name and Surname'**
  String get nombreyapellidoForm;

  /// No description provided for @telefonoForm.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get telefonoForm;

  /// No description provided for @dequesededicaForm.
  ///
  /// In en, this message translates to:
  /// **'What sector or city is your business in?'**
  String get dequesededicaForm;

  /// No description provided for @siguienteBtn.
  ///
  /// In en, this message translates to:
  /// **'NEXT'**
  String get siguienteBtn;

  /// No description provided for @cuantosAnosNegAct.
  ///
  /// In en, this message translates to:
  /// **'How many years has your business been operational?'**
  String get cuantosAnosNegAct;

  /// No description provided for @seleccioneOpcion.
  ///
  /// In en, this message translates to:
  /// **'Select an option'**
  String get seleccioneOpcion;

  /// No description provided for @hasHechoPubAntes.
  ///
  /// In en, this message translates to:
  /// **'Have you done advertising before?'**
  String get hasHechoPubAntes;

  /// No description provided for @si.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get si;

  /// No description provided for @menosde6meses.
  ///
  /// In en, this message translates to:
  /// **'Less than 6 months'**
  String get menosde6meses;

  /// No description provided for @uny.
  ///
  /// In en, this message translates to:
  /// **'1 Year'**
  String get uny;

  /// No description provided for @dosy.
  ///
  /// In en, this message translates to:
  /// **'2 Years'**
  String get dosy;

  /// No description provided for @tresy.
  ///
  /// In en, this message translates to:
  /// **'3 Years'**
  String get tresy;

  /// No description provided for @cuatroy.
  ///
  /// In en, this message translates to:
  /// **'+4 Years'**
  String get cuatroy;

  /// No description provided for @comoPuedoBuscarteRRSS.
  ///
  /// In en, this message translates to:
  /// **'How can I find you on social media?'**
  String get comoPuedoBuscarteRRSS;

  /// No description provided for @entiendesQueEsto.
  ///
  /// In en, this message translates to:
  /// **'Do you understand that this is a process in which you must be committed and have an established business model with different requirements?'**
  String get entiendesQueEsto;

  /// No description provided for @siEstoyPreparado.
  ///
  /// In en, this message translates to:
  /// **'Yes, I am prepared'**
  String get siEstoyPreparado;

  /// No description provided for @noEstoyPreparado.
  ///
  /// In en, this message translates to:
  /// **'No, I do not know what the requirements are'**
  String get noEstoyPreparado;

  /// No description provided for @enviarBtn.
  ///
  /// In en, this message translates to:
  /// **'SEND'**
  String get enviarBtn;

  /// No description provided for @enQueNivel.
  ///
  /// In en, this message translates to:
  /// **'At what level of knowledge is your team regarding digital advertising?'**
  String get enQueNivel;

  /// No description provided for @cero.
  ///
  /// In en, this message translates to:
  /// **'Zero'**
  String get cero;

  /// No description provided for @basico.
  ///
  /// In en, this message translates to:
  /// **'Basic'**
  String get basico;

  /// No description provided for @intermedio.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get intermedio;

  /// No description provided for @avanzado.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get avanzado;

  /// No description provided for @deseasQueLaConf.
  ///
  /// In en, this message translates to:
  /// **'Do you want the conference to be in-person or prefer online?'**
  String get deseasQueLaConf;

  /// No description provided for @confOnline.
  ///
  /// In en, this message translates to:
  /// **'Online Conference'**
  String get confOnline;

  /// No description provided for @confPresenc.
  ///
  /// In en, this message translates to:
  /// **'In-Person Conference'**
  String get confPresenc;

  /// No description provided for @escribeTodasTusEspectativas.
  ///
  /// In en, this message translates to:
  /// **'Write down all your expectations and topics\nyou want me to cover for your company.'**
  String get escribeTodasTusEspectativas;

  /// No description provided for @graciasInfo.
  ///
  /// In en, this message translates to:
  /// **'Thank you for providing us with your information!'**
  String get graciasInfo;

  /// No description provided for @estasAunPaso.
  ///
  /// In en, this message translates to:
  /// **'You\'re one step away from success and making a difference. Welcome to this mission!'**
  String get estasAunPaso;

  /// No description provided for @enElTranscurso.
  ///
  /// In en, this message translates to:
  /// **'Within 2 to 3 days, I will be contacting you to explain the next steps.'**
  String get enElTranscurso;

  /// No description provided for @siguemeEnTodas.
  ///
  /// In en, this message translates to:
  /// **'Follow me on all social media channels to get ADS tips and updates.'**
  String get siguemeEnTodas;

  /// No description provided for @finalizarBtn.
  ///
  /// In en, this message translates to:
  /// **'FINISH'**
  String get finalizarBtn;

  /// No description provided for @inicioMenuBtn.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get inicioMenuBtn;

  /// No description provided for @cursosMenuBtn.
  ///
  /// In en, this message translates to:
  /// **'Courses'**
  String get cursosMenuBtn;

  /// No description provided for @serviciosMenuBtn.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get serviciosMenuBtn;

  /// No description provided for @resultadosMenuBtn.
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get resultadosMenuBtn;

  /// No description provided for @contactoMenuBtn.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contactoMenuBtn;

  /// No description provided for @enviaremosUnEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your data and receive my new GUIDE\nat no cost to you ❤️'**
  String get enviaremosUnEmail;

  /// No description provided for @todoListoDescarga.
  ///
  /// In en, this message translates to:
  /// **'Everything\'s ready, you can now download your gift by clicking the link we\'ve sent to your email.'**
  String get todoListoDescarga;

  /// No description provided for @alHacerClickHeLeido.
  ///
  /// In en, this message translates to:
  /// **'By clicking SUBMIT, you confirm that you have read and accepted all the policies and conditions.'**
  String get alHacerClickHeLeido;

  /// No description provided for @cancelarBtn.
  ///
  /// In en, this message translates to:
  /// **'CANCEL'**
  String get cancelarBtn;

  /// No description provided for @crearCuenta.
  ///
  /// In en, this message translates to:
  /// **'CREATE ACCOUNT'**
  String get crearCuenta;

  /// No description provided for @correoTextFiel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get correoTextFiel;

  /// No description provided for @nombreTextField.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nombreTextField;

  /// No description provided for @ingreseNombreTextField.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get ingreseNombreTextField;

  /// No description provided for @apellidoTextFiel.
  ///
  /// In en, this message translates to:
  /// **'Surname'**
  String get apellidoTextFiel;

  /// No description provided for @ingreseApellidoTextFiel.
  ///
  /// In en, this message translates to:
  /// **'Enter your surname'**
  String get ingreseApellidoTextFiel;

  /// No description provided for @contrasenaTextFiel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get contrasenaTextFiel;

  /// No description provided for @repitaContrasenaTextFiel.
  ///
  /// In en, this message translates to:
  /// **'Repeat password'**
  String get repitaContrasenaTextFiel;

  /// No description provided for @yaTienesCuenta.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get yaTienesCuenta;

  /// No description provided for @iniciaAqui.
  ///
  /// In en, this message translates to:
  /// **'Log in here'**
  String get iniciaAqui;

  /// No description provided for @alIniciarSesion.
  ///
  /// In en, this message translates to:
  /// **'By logging in, you agree to our '**
  String get alIniciarSesion;

  /// No description provided for @terminoDeUso.
  ///
  /// In en, this message translates to:
  /// **'Terms of use '**
  String get terminoDeUso;

  /// No description provided for @yReconocesQue.
  ///
  /// In en, this message translates to:
  /// **'and acknowledge that you have read '**
  String get yReconocesQue;

  /// No description provided for @nuestra.
  ///
  /// In en, this message translates to:
  /// **'our '**
  String get nuestra;

  /// No description provided for @politicaDePrivacidad.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get politicaDePrivacidad;

  /// No description provided for @iniciaSesion.
  ///
  /// In en, this message translates to:
  /// **'LOG IN'**
  String get iniciaSesion;

  /// No description provided for @recuerdame.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get recuerdame;

  /// No description provided for @iniciarSesionBtn.
  ///
  /// In en, this message translates to:
  /// **'LOG IN'**
  String get iniciarSesionBtn;

  /// No description provided for @eresNuevo.
  ///
  /// In en, this message translates to:
  /// **'Are you new?'**
  String get eresNuevo;

  /// No description provided for @registrateAqui.
  ///
  /// In en, this message translates to:
  /// **'Sign up here'**
  String get registrateAqui;

  /// No description provided for @olvideMiPass.
  ///
  /// In en, this message translates to:
  /// **'I forgot my password'**
  String get olvideMiPass;

  /// No description provided for @ingreseSuCorreo.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get ingreseSuCorreo;

  /// No description provided for @ingreseUnaPassValida.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid password'**
  String get ingreseUnaPassValida;

  /// No description provided for @laContraDebe6Caracteres.
  ///
  /// In en, this message translates to:
  /// **'The password must have more than 6 characters'**
  String get laContraDebe6Caracteres;

  /// No description provided for @passNoCoinciden.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passNoCoinciden;

  /// No description provided for @registrarBtn.
  ///
  /// In en, this message translates to:
  /// **'REGISTER'**
  String get registrarBtn;

  /// No description provided for @recuperarPass.
  ///
  /// In en, this message translates to:
  /// **'RECOVER YOUR PASSWORD'**
  String get recuperarPass;

  /// No description provided for @ingresaTuDirEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address'**
  String get ingresaTuDirEmail;

  /// No description provided for @recibirasInstruccionesPass.
  ///
  /// In en, this message translates to:
  /// **'You will receive an email with instructions to reset your password.'**
  String get recibirasInstruccionesPass;

  /// No description provided for @elEmailNoExiste.
  ///
  /// In en, this message translates to:
  /// **'The email does not exist'**
  String get elEmailNoExiste;

  /// No description provided for @seHaEnviadoUnCorreo.
  ///
  /// In en, this message translates to:
  /// **'An email with instructions has been sent, please check your email'**
  String get seHaEnviadoUnCorreo;

  /// No description provided for @irAlLoginBtn.
  ///
  /// In en, this message translates to:
  /// **'Go to login'**
  String get irAlLoginBtn;

  /// No description provided for @comprarBtn.
  ///
  /// In en, this message translates to:
  /// **'BUY'**
  String get comprarBtn;

  /// No description provided for @actualizado2024.
  ///
  /// In en, this message translates to:
  /// **'Updated 2025'**
  String get actualizado2024;

  /// No description provided for @estaMision.
  ///
  /// In en, this message translates to:
  /// **'This mission is for you'**
  String get estaMision;

  /// No description provided for @emprendedorOFree.
  ///
  /// In en, this message translates to:
  /// **'Entrepreneur or Freelancer'**
  String get emprendedorOFree;

  /// No description provided for @emprendedorOFreeText.
  ///
  /// In en, this message translates to:
  /// **'If you are an entrepreneur, have a business or want training that truly trains your team to launch campaigns correctly'**
  String get emprendedorOFreeText;

  /// No description provided for @duenosNegocios.
  ///
  /// In en, this message translates to:
  /// **'Business Owners'**
  String get duenosNegocios;

  /// No description provided for @duenosNegociosText.
  ///
  /// In en, this message translates to:
  /// **'You see advertising on your phone all the time, and you know your business needs it to get noticed and sell more. This training will help you understand how to do it and its importance.'**
  String get duenosNegociosText;

  /// No description provided for @negocioLocFis.
  ///
  /// In en, this message translates to:
  /// **'Local or Physical Business'**
  String get negocioLocFis;

  /// No description provided for @negocioLocFisText.
  ///
  /// In en, this message translates to:
  /// **'Clothing store, restaurant, gym, bar, or any business that needs foot traffic to consume its product or service.'**
  String get negocioLocFisText;

  /// No description provided for @profesionalesEnMark.
  ///
  /// In en, this message translates to:
  /// **'Marketing and Communication Professionals'**
  String get profesionalesEnMark;

  /// No description provided for @profesionalesEnMarkText.
  ///
  /// In en, this message translates to:
  /// **'If you\'re studying or working in a company, this will be very valuable for developing it within the company or offering it as one of your services.'**
  String get profesionalesEnMarkText;

  /// No description provided for @consultEspec.
  ///
  /// In en, this message translates to:
  /// **'Consultants or Specialists'**
  String get consultEspec;

  /// No description provided for @consultEspecText.
  ///
  /// In en, this message translates to:
  /// **'You\'re a doctor, coach, realtor, lawyer, or nutritionist, and your services are highly sought after on social media. All that\'s left is to expose yourself in the right way through advertising.'**
  String get consultEspecText;

  /// No description provided for @inhabResagBloq.
  ///
  /// In en, this message translates to:
  /// **'Disabled, Backlogged, or Blocked'**
  String get inhabResagBloq;

  /// No description provided for @inhabResagBloqText.
  ///
  /// In en, this message translates to:
  /// **'If you\'re studying or working in a company, this will be very valuable for developing it within the company or offering it as one of your services.'**
  String get inhabResagBloqText;

  /// No description provided for @conoceloQue.
  ///
  /// In en, this message translates to:
  /// **'Get to Know What You\'ll Learn'**
  String get conoceloQue;

  /// No description provided for @ellosVivieronMision.
  ///
  /// In en, this message translates to:
  /// **'They Lived the Mission'**
  String get ellosVivieronMision;

  /// No description provided for @quieroAds.
  ///
  /// In en, this message translates to:
  /// **'I Want Ads'**
  String get quieroAds;

  /// No description provided for @estudiantes.
  ///
  /// In en, this message translates to:
  /// **'students'**
  String get estudiantes;

  /// No description provided for @testimonioSaylin.
  ///
  /// In en, this message translates to:
  /// **'\"I loved it, it\'s very comprehensive and a world of knowledge. For my business, this course marked a before and after.\"'**
  String get testimonioSaylin;

  /// No description provided for @testimonioAnier.
  ///
  /// In en, this message translates to:
  /// **'\"I studied computer science and a lot of education. After taking the course, I not only recovered my investment but can also run my own advertising. Thanks, JP.\"'**
  String get testimonioAnier;

  /// No description provided for @testimonioTania.
  ///
  /// In en, this message translates to:
  /// **'\"I have ideas and plans to implement for the next 6 months thanks to this course. Anyone who takes it will understand after learning from JP.\"'**
  String get testimonioTania;

  /// No description provided for @testimonioGerman.
  ///
  /// In en, this message translates to:
  /// **'\"In just 1 month, I managed to have more than 100 potential clients with my advertising campaigns. I recommend this course to anyone who wants to learn.\"'**
  String get testimonioGerman;

  /// No description provided for @soyJpDir.
  ///
  /// In en, this message translates to:
  /// **'I\'m JP Director'**
  String get soyJpDir;

  /// No description provided for @desdeHace4.
  ///
  /// In en, this message translates to:
  /// **'For the past 5 years, I\'ve been dedicated to boosting brands and businesses with effective ad strategies that hit the mark. Throughout the process, I\'ve managed more than \$12,000,000 USD in advertising campaigns, achieving more than \$160,000,000 USD in online sales. After countless trials, analyses, and education, I decided to offer this group experience to teach entrepreneurs, business owners, or marketing teams to understand the engine that is running advertising campaigns.'**
  String get desdeHace4;

  /// No description provided for @quieroYaBtn.
  ///
  /// In en, this message translates to:
  /// **'I WANT THIS COURSE NOW'**
  String get quieroYaBtn;

  /// No description provided for @continuar.
  ///
  /// In en, this message translates to:
  /// **'CONTINUE'**
  String get continuar;

  /// No description provided for @yaTienesEsteCurso.
  ///
  /// In en, this message translates to:
  /// **'You Already Have This Course'**
  String get yaTienesEsteCurso;

  /// No description provided for @noTienesCursos.
  ///
  /// In en, this message translates to:
  /// **'You Don\'t Have Any Courses'**
  String get noTienesCursos;

  /// No description provided for @misCursosMenuBtn.
  ///
  /// In en, this message translates to:
  /// **'MY COURSES'**
  String get misCursosMenuBtn;

  /// No description provided for @configuracionMenuBtn.
  ///
  /// In en, this message translates to:
  /// **'SETTINGS'**
  String get configuracionMenuBtn;

  /// No description provided for @miCuentaMenuBtn.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get miCuentaMenuBtn;

  /// No description provided for @usuariosMenuBtn.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get usuariosMenuBtn;

  /// No description provided for @formulariosMenuBtn.
  ///
  /// In en, this message translates to:
  /// **'Forms'**
  String get formulariosMenuBtn;

  /// No description provided for @leadsMenuBtn.
  ///
  /// In en, this message translates to:
  /// **'Leads'**
  String get leadsMenuBtn;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'LOG OUT'**
  String get logout;

  /// No description provided for @logoutLabel.
  ///
  /// In en, this message translates to:
  /// **'LOG OUT'**
  String get logoutLabel;

  /// No description provided for @yaTienesTodos.
  ///
  /// In en, this message translates to:
  /// **'You Already Have All the Courses'**
  String get yaTienesTodos;

  /// No description provided for @misCursosLabel.
  ///
  /// In en, this message translates to:
  /// **'My Courses'**
  String get misCursosLabel;

  /// No description provided for @cursosDisponibles.
  ///
  /// In en, this message translates to:
  /// **'Available Courses'**
  String get cursosDisponibles;

  /// No description provided for @sobreMi.
  ///
  /// In en, this message translates to:
  /// **'About Me'**
  String get sobreMi;

  /// No description provided for @actInfoBtn.
  ///
  /// In en, this message translates to:
  /// **'UPDATE INFORMATION'**
  String get actInfoBtn;

  /// No description provided for @actRrssBtn.
  ///
  /// In en, this message translates to:
  /// **'UPDATE SOCIAL MEDIA'**
  String get actRrssBtn;

  /// No description provided for @redesSociales.
  ///
  /// In en, this message translates to:
  /// **'Social Media'**
  String get redesSociales;

  /// No description provided for @actualizarBtn.
  ///
  /// In en, this message translates to:
  /// **'UPDATE'**
  String get actualizarBtn;

  /// No description provided for @extensionInvalida.
  ///
  /// In en, this message translates to:
  /// **'Invalid Extension'**
  String get extensionInvalida;

  /// No description provided for @laExtensionDebe.
  ///
  /// In en, this message translates to:
  /// **'The extension must be PNG, JPG, or JPEG'**
  String get laExtensionDebe;

  /// No description provided for @tamanoInvalido.
  ///
  /// In en, this message translates to:
  /// **'Invalid Size'**
  String get tamanoInvalido;

  /// No description provided for @debePesarMenos.
  ///
  /// In en, this message translates to:
  /// **'The image must weigh less than 3 MB'**
  String get debePesarMenos;

  /// No description provided for @imgCambiadaNtf.
  ///
  /// In en, this message translates to:
  /// **'Image changed successfully'**
  String get imgCambiadaNtf;

  /// No description provided for @verMas.
  ///
  /// In en, this message translates to:
  /// **'See More'**
  String get verMas;

  /// No description provided for @modulos2puntos.
  ///
  /// In en, this message translates to:
  /// **'Modules: '**
  String get modulos2puntos;

  /// No description provided for @duracion2puntos.
  ///
  /// In en, this message translates to:
  /// **'Duration: '**
  String get duracion2puntos;

  /// No description provided for @seguroBorrar.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to Delete'**
  String get seguroBorrar;

  /// No description provided for @seguroBorrarUsuario.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the user'**
  String get seguroBorrarUsuario;

  /// No description provided for @borrarDefinitivo.
  ///
  /// In en, this message translates to:
  /// **'Permanently delete the user'**
  String get borrarDefinitivo;

  /// No description provided for @eliminado.
  ///
  /// In en, this message translates to:
  /// **'Deleted'**
  String get eliminado;

  /// No description provided for @errorEliminadoCurso.
  ///
  /// In en, this message translates to:
  /// **'Error deleting course'**
  String get errorEliminadoCurso;

  /// No description provided for @errorEliminadoUsuario.
  ///
  /// In en, this message translates to:
  /// **'Error deleting user'**
  String get errorEliminadoUsuario;

  /// No description provided for @errorEliminadoLead.
  ///
  /// In en, this message translates to:
  /// **'Error deleting lead'**
  String get errorEliminadoLead;

  /// No description provided for @servicios2puntos.
  ///
  /// In en, this message translates to:
  /// **'Services: '**
  String get servicios2puntos;

  /// No description provided for @negocio2puntos.
  ///
  /// In en, this message translates to:
  /// **'Business :'**
  String get negocio2puntos;

  /// No description provided for @advisoryLvl.
  ///
  /// In en, this message translates to:
  /// **'Advertising Level'**
  String get advisoryLvl;

  /// No description provided for @advisoryBefore.
  ///
  /// In en, this message translates to:
  /// **'Advertising Before?'**
  String get advisoryBefore;

  /// No description provided for @acepto2puntos.
  ///
  /// In en, this message translates to:
  /// **'Agree:'**
  String get acepto2puntos;

  /// No description provided for @borrarForm.
  ///
  /// In en, this message translates to:
  /// **'Delete form'**
  String get borrarForm;

  /// No description provided for @borrarFormDef.
  ///
  /// In en, this message translates to:
  /// **'Permanently delete the form'**
  String get borrarFormDef;

  /// No description provided for @siBorrar.
  ///
  /// In en, this message translates to:
  /// **'Yes, Delete'**
  String get siBorrar;

  /// No description provided for @activo.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE'**
  String get activo;

  /// No description provided for @pendiente.
  ///
  /// In en, this message translates to:
  /// **'PENDING'**
  String get pendiente;

  /// No description provided for @usuario.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get usuario;

  /// No description provided for @adminLeads.
  ///
  /// In en, this message translates to:
  /// **'Lead Management'**
  String get adminLeads;

  /// No description provided for @datosDescarga.
  ///
  /// In en, this message translates to:
  /// **'Download Data'**
  String get datosDescarga;

  /// No description provided for @listaDescarga.
  ///
  /// In en, this message translates to:
  /// **'Download List'**
  String get listaDescarga;

  /// No description provided for @acciones.
  ///
  /// In en, this message translates to:
  /// **'ACTIONS'**
  String get acciones;

  /// No description provided for @adminForms.
  ///
  /// In en, this message translates to:
  /// **'Form Management'**
  String get adminForms;

  /// No description provided for @listaForm.
  ///
  /// In en, this message translates to:
  /// **'Form List'**
  String get listaForm;

  /// No description provided for @informacionMayus.
  ///
  /// In en, this message translates to:
  /// **'INFORMATION'**
  String get informacionMayus;

  /// No description provided for @adminCursos.
  ///
  /// In en, this message translates to:
  /// **'Course Management'**
  String get adminCursos;

  /// No description provided for @listaDeCursos.
  ///
  /// In en, this message translates to:
  /// **'Course List'**
  String get listaDeCursos;

  /// No description provided for @imgDeCurso.
  ///
  /// In en, this message translates to:
  /// **'COURSE IMAGE'**
  String get imgDeCurso;

  /// No description provided for @infoDeCurso.
  ///
  /// In en, this message translates to:
  /// **'COURSE INFORMATION'**
  String get infoDeCurso;

  /// No description provided for @adminUsuarios.
  ///
  /// In en, this message translates to:
  /// **'User Management'**
  String get adminUsuarios;

  /// No description provided for @listaUsuarios.
  ///
  /// In en, this message translates to:
  /// **'User List'**
  String get listaUsuarios;

  /// No description provided for @imagen.
  ///
  /// In en, this message translates to:
  /// **'IMAGE'**
  String get imagen;

  /// No description provided for @cursoMayus.
  ///
  /// In en, this message translates to:
  /// **'COURSES'**
  String get cursoMayus;

  /// No description provided for @verCertificadoBtn.
  ///
  /// In en, this message translates to:
  /// **'VIEW CERTIFICATE'**
  String get verCertificadoBtn;

  /// No description provided for @ver.
  ///
  /// In en, this message translates to:
  /// **'VIEW'**
  String get ver;

  /// No description provided for @comentariosBtn.
  ///
  /// In en, this message translates to:
  /// **'COMMENTS'**
  String get comentariosBtn;

  /// No description provided for @verMaterialBtn.
  ///
  /// In en, this message translates to:
  /// **'VIEW MATERIAL'**
  String get verMaterialBtn;

  /// No description provided for @listaDeComentarios.
  ///
  /// In en, this message translates to:
  /// **'Comment List'**
  String get listaDeComentarios;

  /// No description provided for @finDeLosComentarios.
  ///
  /// In en, this message translates to:
  /// **'End of Comments'**
  String get finDeLosComentarios;

  /// No description provided for @agregarUnComentario.
  ///
  /// In en, this message translates to:
  /// **'Add a Comment'**
  String get agregarUnComentario;

  /// No description provided for @comentar.
  ///
  /// In en, this message translates to:
  /// **'COMMENT'**
  String get comentar;

  /// No description provided for @unAdmRespondera.
  ///
  /// In en, this message translates to:
  /// **'An Administrator will answer your question'**
  String get unAdmRespondera;

  /// No description provided for @generandoCert.
  ///
  /// In en, this message translates to:
  /// **'Generating Certificate'**
  String get generandoCert;

  /// No description provided for @felicidadesCert.
  ///
  /// In en, this message translates to:
  /// **'Congratulations, your certificate is ready!'**
  String get felicidadesCert;

  /// No description provided for @certificadoBtn.
  ///
  /// In en, this message translates to:
  /// **'CERTIFICATE'**
  String get certificadoBtn;

  /// No description provided for @seguroBorrarComent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the comment?'**
  String get seguroBorrarComent;

  /// No description provided for @comentarioInvalido.
  ///
  /// In en, this message translates to:
  /// **'Invalid Comment'**
  String get comentarioInvalido;

  /// No description provided for @progreso2puntos.
  ///
  /// In en, this message translates to:
  /// **'Progress: '**
  String get progreso2puntos;

  /// No description provided for @irAlLogin.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get irAlLogin;

  /// No description provided for @telfSinCaracteres.
  ///
  /// In en, this message translates to:
  /// **'Phone without special characters (12223334455)'**
  String get telfSinCaracteres;

  /// No description provided for @telfDebeCodArea.
  ///
  /// In en, this message translates to:
  /// **'It must include international code + area code'**
  String get telfDebeCodArea;

  /// No description provided for @telfSoloNumeros.
  ///
  /// In en, this message translates to:
  /// **'It must only contain numbers. (12223334455)'**
  String get telfSoloNumeros;

  /// No description provided for @ingreseCorreoValido.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get ingreseCorreoValido;

  /// No description provided for @deQueSector.
  ///
  /// In en, this message translates to:
  /// **'What sector or city is your business from?'**
  String get deQueSector;

  /// No description provided for @requerido.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get requerido;

  /// No description provided for @nuevoUsuario.
  ///
  /// In en, this message translates to:
  /// **'New User'**
  String get nuevoUsuario;

  /// No description provided for @nombreDeUsuario.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get nombreDeUsuario;

  /// No description provided for @apellidoDeUsuario.
  ///
  /// In en, this message translates to:
  /// **'User\'s Last Name'**
  String get apellidoDeUsuario;

  /// No description provided for @correoDeUsuario.
  ///
  /// In en, this message translates to:
  /// **'User\'s Email'**
  String get correoDeUsuario;

  /// No description provided for @passDeUsuario.
  ///
  /// In en, this message translates to:
  /// **'User\'s Password'**
  String get passDeUsuario;

  /// No description provided for @telefonoDeUsuario.
  ///
  /// In en, this message translates to:
  /// **'User\'s Phone'**
  String get telefonoDeUsuario;

  /// No description provided for @estado.
  ///
  /// In en, this message translates to:
  /// **'STATUS'**
  String get estado;

  /// No description provided for @crearBtn.
  ///
  /// In en, this message translates to:
  /// **'CREATE'**
  String get crearBtn;

  /// No description provided for @anadirCurso.
  ///
  /// In en, this message translates to:
  /// **'Add a course to the user'**
  String get anadirCurso;

  /// No description provided for @seleccioneCurso.
  ///
  /// In en, this message translates to:
  /// **'Select a course'**
  String get seleccioneCurso;

  /// No description provided for @agregarBtn.
  ///
  /// In en, this message translates to:
  /// **'ADD'**
  String get agregarBtn;

  /// No description provided for @usuarioCreado.
  ///
  /// In en, this message translates to:
  /// **'User created successfully'**
  String get usuarioCreado;

  /// No description provided for @usuarioActualizado.
  ///
  /// In en, this message translates to:
  /// **'User updated successfully'**
  String get usuarioActualizado;

  /// No description provided for @cursoRepetido.
  ///
  /// In en, this message translates to:
  /// **'Course already exists'**
  String get cursoRepetido;

  /// No description provided for @eliminarCurso.
  ///
  /// In en, this message translates to:
  /// **'Delete Course'**
  String get eliminarCurso;

  /// No description provided for @seguroEliminarCurso.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the course'**
  String get seguroEliminarCurso;

  /// No description provided for @editar2puntos.
  ///
  /// In en, this message translates to:
  /// **'Edit:'**
  String get editar2puntos;

  /// No description provided for @nuevoCurso.
  ///
  /// In en, this message translates to:
  /// **'New Course'**
  String get nuevoCurso;

  /// No description provided for @nombreDelCurso.
  ///
  /// In en, this message translates to:
  /// **'Course Name'**
  String get nombreDelCurso;

  /// No description provided for @precioDelCurso.
  ///
  /// In en, this message translates to:
  /// **'Course Price'**
  String get precioDelCurso;

  /// No description provided for @imagenDelCurso.
  ///
  /// In en, this message translates to:
  /// **'Course Image'**
  String get imagenDelCurso;

  /// No description provided for @banerDelCurso.
  ///
  /// In en, this message translates to:
  /// **'Course Banner'**
  String get banerDelCurso;

  /// No description provided for @duracionDelCurso.
  ///
  /// In en, this message translates to:
  /// **'Course Duration'**
  String get duracionDelCurso;

  /// No description provided for @descripcionDelCurso.
  ///
  /// In en, this message translates to:
  /// **'Course Description'**
  String get descripcionDelCurso;

  /// No description provided for @modulosDelCurso.
  ///
  /// In en, this message translates to:
  /// **'Course Modules'**
  String get modulosDelCurso;

  /// No description provided for @agregarUnModulo.
  ///
  /// In en, this message translates to:
  /// **'Add Module'**
  String get agregarUnModulo;

  /// No description provided for @nombreDelModulo.
  ///
  /// In en, this message translates to:
  /// **'Module Name'**
  String get nombreDelModulo;

  /// No description provided for @descripcionDelModulo.
  ///
  /// In en, this message translates to:
  /// **'Module Description'**
  String get descripcionDelModulo;

  /// No description provided for @urlVideoModulo.
  ///
  /// In en, this message translates to:
  /// **'Module Video URL'**
  String get urlVideoModulo;

  /// No description provided for @idCarpertaModulo.
  ///
  /// In en, this message translates to:
  /// **'Module Folder ID'**
  String get idCarpertaModulo;

  /// No description provided for @idZipModulo.
  ///
  /// In en, this message translates to:
  /// **'Module Zip ID'**
  String get idZipModulo;

  /// No description provided for @imgCursoCertificado.
  ///
  /// In en, this message translates to:
  /// **'Certificate Image'**
  String get imgCursoCertificado;

  /// No description provided for @duracionObligatoria.
  ///
  /// In en, this message translates to:
  /// **'Course duration is required'**
  String get duracionObligatoria;

  /// No description provided for @sinModulos.
  ///
  /// In en, this message translates to:
  /// **'No modules, add a new module'**
  String get sinModulos;

  /// No description provided for @eliminarModulo.
  ///
  /// In en, this message translates to:
  /// **'Delete module'**
  String get eliminarModulo;

  /// No description provided for @seguroEliminarModulo.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the module'**
  String get seguroEliminarModulo;

  /// No description provided for @editarModulo.
  ///
  /// In en, this message translates to:
  /// **'Edit module'**
  String get editarModulo;

  /// No description provided for @nuevoModulo.
  ///
  /// In en, this message translates to:
  /// **'New module'**
  String get nuevoModulo;

  /// No description provided for @publicado2puntos.
  ///
  /// In en, this message translates to:
  /// **'Published: '**
  String get publicado2puntos;

  /// No description provided for @avisoLegalYTerminos.
  ///
  /// In en, this message translates to:
  /// **'Legal Notice and Terms of Use of the Site'**
  String get avisoLegalYTerminos;

  /// No description provided for @actualizacionTyC.
  ///
  /// In en, this message translates to:
  /// **'Last updated March 7, 2023'**
  String get actualizacionTyC;

  /// No description provided for @avisoLegal1.
  ///
  /// In en, this message translates to:
  /// **'1. LEGAL NOTICE AND TERMS OF USE'**
  String get avisoLegal1;

  /// No description provided for @puedoGatantizarte.
  ///
  /// In en, this message translates to:
  /// **'I can guarantee that you are in a 100% secure space, for this you should know:\n\n1.1. IDENTIFICATION DATA OF THE RESPONSIBLE PARTY\nAs required by current regulations, I inform you that:'**
  String get puedoGatantizarte;

  /// No description provided for @miDenominacion.
  ///
  /// In en, this message translates to:
  /// **'-My company name is: ON POINT PRODUCTIONS AGENCY LLC\n-My registered office is located at 4020 N MacArthur Blvd Suite 122, Irving, Texas 75038, United States of America.\n-Email: hola@jpdirector.net\n-My business activity is: Advertising'**
  String get miDenominacion;

  /// No description provided for @finalidadWeb1_2.
  ///
  /// In en, this message translates to:
  /// **'1.2. PURPOSE OF THE WEBSITE\nThe services provided by the responsible party of the website are as follows:'**
  String get finalidadWeb1_2;

  /// No description provided for @laVentanaDeFormacion.
  ///
  /// In en, this message translates to:
  /// **'-Sale of training and services on online businesses.\n-Managing the list of subscribers and users subscribed to the website.\n-Managing its network of affiliates and merchants, as well as processing their payments.'**
  String get laVentanaDeFormacion;

  /// No description provided for @usuarios1_3.
  ///
  /// In en, this message translates to:
  /// **'1.3. USERS:'**
  String get usuarios1_3;

  /// No description provided for @elAccesoyo.
  ///
  /// In en, this message translates to:
  /// **'Access and/or use of this website grants the USER the status of USER, who accepts, from said access and/or use, these terms of use; however, by the mere use of the website, this does not imply the commencement of any labor/commercial relationship.'**
  String get elAccesoyo;

  /// No description provided for @usoDelSitioWeb1_4.
  ///
  /// In en, this message translates to:
  /// **'1.4. USE OF THE WEBSITE AND INFORMATION CAPTURE:'**
  String get usoDelSitioWeb1_4;

  /// No description provided for @usoDelSitioWeb1_4_1.
  ///
  /// In en, this message translates to:
  /// **'1.4.1 USE OF THE WEBSITE'**
  String get usoDelSitioWeb1_4_1;

  /// No description provided for @laPaginaWebText.
  ///
  /// In en, this message translates to:
  /// **'The website https://quieroads.com/ hereinafter (THE WEBSITE) provides access to articles, information, services, and data (hereinafter, “the content”) owned by ON POINT PRODUCTIONS AGENCY LLC. The USER assumes responsibility for the use of the website.\nThe USER agrees to make appropriate use of the content offered through the website and, by way of example but not limited to, not to use them for:\n(a) engage in illegal, unlawful, or contrary to good faith and public order activities;\n(b) disseminate content or propaganda of a racist, xenophobic, illegal-pornographic nature, terrorism apology, or that violates human rights;\n(c) cause damage to the physical and logical systems of the website, its suppliers, or third parties, introduce or spread computer viruses or any other physical or logical systems that are capable of causing the aforementioned damage;\n(d) try to access and, where appropriate, use the email accounts of other users and modify or manipulate their messages.\nON POINT PRODUCTIONS AGENCY LLC reserves the right to withdraw all comments and contributions that violate respect for the dignity of the person, that are discriminatory, xenophobic, racist, pornographic, that attack youth or childhood, public order, or security, or that, in its opinion, would not be suitable for publication.\nIn any case, ON POINT PRODUCTIONS AGENCY LLC will not be responsible for the opinions expressed by users through any participation tools that may be created, as provided in the applicable regulations.'**
  String get laPaginaWebText;

  /// No description provided for @capturaDeInf1_4_2.
  ///
  /// In en, this message translates to:
  /// **'1.4.2 INFORMATION CAPTURE'**
  String get capturaDeInf1_4_2;

  /// No description provided for @capturaDeInf1_4_2Text.
  ///
  /// In en, this message translates to:
  /// **'-Contact form, where the USER must fill in the email, subject, and name fields.\n-Subscription form, with the USER filling in the necessary fields for subscription to the website with the fields of name, email, and phone number.\n-Sales form, with the USER filling in the necessary fields for the sale with the fields of name, email, address, phone number, and ID\n-Tracking cookies, according to the following rules\n-Navigation and IP Address: By browsing this website, the user automatically provides the web server with information regarding their IP address, date and time of access, the hyperlink that has referred them to these pages, their operating system, and the browser used.'**
  String get capturaDeInf1_4_2Text;

  /// No description provided for @aPesarDeLoAnterior.
  ///
  /// In en, this message translates to:
  /// **'Despite the above, users may unsubscribe at any time from the services provided by ON POINT PRODUCTIONS AGENCY LLC or data provided by the USER in compliance with current Data Protection regulations. Likewise, both when subscribing to this website and when making a comment or making a purchase on any of its pages and/or entries, the user consents:'**
  String get aPesarDeLoAnterior;

  /// No description provided for @elTratamientoDeSusDatos.
  ///
  /// In en, this message translates to:
  /// **'1. The processing of their personal data within the framework of Wix in accordance with their privacy policies.\n2. ON POINT PRODUCTIONS AGENCY LLC\'s access to the data that, according to Wix\'s infrastructure, the user needs to provide for either subscribing to the website or any queries via the contact form.'**
  String get elTratamientoDeSusDatos;

  /// No description provided for @asiMismoInformamos.
  ///
  /// In en, this message translates to:
  /// **'Likewise, we inform you that our user\'s information is protected in accordance with our PRIVACY POLICY.\nBy activating a subscription, contact form, or comment, the user understands and accepts that:\nFrom the moment you subscribe or access a paid service, ON POINT PRODUCTIONS AGENCY LLC has access.\nIn any case, ON POINT PRODUCTIONS AGENCY LLC reserves the right to modify, at any time and without prior notice, the presentation and configuration of the website https://quieroads.com/, as well as this legal notice.'**
  String get asiMismoInformamos;

  /// No description provided for @propiedadIntelectual.
  ///
  /// In en, this message translates to:
  /// **'2. INTELLECTUAL AND INDUSTRIAL PROPERTY:'**
  String get propiedadIntelectual;

  /// No description provided for @propiedadIntelectualText.
  ///
  /// In en, this message translates to:
  /// **'ON POINT PRODUCTIONS AGENCY LLC itself or as a licensee, is the owner of all intellectual and industrial property rights on its website, as well as the elements contained therein (by way of example, images, sound, audio, video, software or texts; trademarks or logos, combinations of colors, structure and design, selection of materials used, computer programs necessary for its operation, access, and use, etc.), owned by ON POINT PRODUCTIONS AGENCY LLC or its licensors. All rights reserved.\nAny use not previously authorized by ON POINT PRODUCTIONS AGENCY LLC will be considered a serious breach of the author\'s intellectual or industrial property rights.\nReproduction, distribution, and public communication, including its method of making available, of all or part of the contents of this website, for commercial purposes, in any medium and by any technical means, without the authorization of ON POINT PRODUCTIONS AGENCY LLC, are expressly prohibited.\nThe USER undertakes to respect the intellectual and industrial property rights owned by ON POINT PRODUCTIONS AGENCY LLC. They may only view the elements of the website without the possibility of printing, copying, or storing them on the hard drive of their computer or on any other physical medium. The USER shall refrain from deleting, altering, evading, or manipulating any protection device or security system installed on the pages of ON POINT PRODUCTIONS AGENCY LLC.\nSharing the license for use with more people is strictly prohibited, each license is personal and non-transferable, reserving as many civil and criminal actions as may assist us in order to safeguard our rights, all under threat of incurring a crime against intellectual property.'**
  String get propiedadIntelectualText;

  /// No description provided for @exclusionDeGarant.
  ///
  /// In en, this message translates to:
  /// **'3. DISCLAIMER OF WARRANTIES AND LIABILITY'**
  String get exclusionDeGarant;

  /// No description provided for @exclusionDeGarantText.
  ///
  /// In en, this message translates to:
  /// **'ON POINT PRODUCTIONS AGENCY LLC is not responsible, in any case, for damages of any kind that may cause, by way of example: errors or omissions in the content, lack of availability of the website, - which will make periodic stops for technical maintenance - as well as the transmission of viruses or malicious or harmful programs in the content, despite having taken all necessary technological measures to avoid it.'**
  String get exclusionDeGarantText;

  /// No description provided for @modificaciones.
  ///
  /// In en, this message translates to:
  /// **'4. MODIFICATIONS'**
  String get modificaciones;

  /// No description provided for @modificacionesText.
  ///
  /// In en, this message translates to:
  /// **'ON POINT PRODUCTIONS AGENCY LLC reserves the right to make changes it deems appropriate to its website, being able to change, delete, or add both the content and services provided through it, as well as the way in which they are presented or located on its website.'**
  String get modificacionesText;

  /// No description provided for @politicaDeEnlaces.
  ///
  /// In en, this message translates to:
  /// **'5. LINKING POLICY'**
  String get politicaDeEnlaces;

  /// No description provided for @politicaDeEnlacesText.
  ///
  /// In en, this message translates to:
  /// **'Individuals or entities wishing to create or have created a hyperlink from a web page of another Internet portal to ON POINT PRODUCTIONS AGENCY LLC\'s website must comply with the following conditions:'**
  String get politicaDeEnlacesText;

  /// No description provided for @noSePermiteRepr.
  ///
  /// In en, this message translates to:
  /// **'-Total or partial reproduction of any of the services or contents of the website without the prior express authorization of ON POINT PRODUCTIONS AGENCY LLC is not allowed.\n-Deep links or image links, or frames with the ON POINT PRODUCTIONS AGENCY LLC website, shall not be established without its prior express authorization.\n-No false, inaccurate, or incorrect representation shall be made regarding the ON POINT PRODUCTIONS AGENCY LLC website or its services or contents. Except for signs forming part of the hyperlink, the web page on which it is established shall not contain any trademarks, trade names, establishment signs, names, logos, slogans, or other distinctive signs belonging to ON POINT PRODUCTIONS AGENCY LLC without its express authorization.\n-The establishment of the hyperlink shall not imply the existence of relationships between ON POINT PRODUCTIONS AGENCY LLC and the owner of the web page or portal from which it is created, nor the knowledge and acceptance by ON POINT PRODUCTIONS AGENCY LLC of the services and contents offered on that web page or portal.\n-ON POINT PRODUCTIONS AGENCY LLC shall not be responsible for the contents or services made available to the public on the web page or portal from which the hyperlink is created, nor for the information and statements included in them.\n-The ON POINT PRODUCTIONS AGENCY LLC website may provide connections and links to other websites managed and controlled by third parties. These links are provided solely to facilitate user searches for information, content, and services on the Internet, and at no time shall they be considered a suggestion, recommendation, or invitation to visit them.\n-ON POINT PRODUCTIONS AGENCY LLC does not commercialize, manage, or control in advance the contents, services, information, and statements available on these websites.\n-ON POINT PRODUCTIONS AGENCY LLC assumes no responsibility, not even indirectly or subsidiarily, for any damages or losses of any kind that may arise from access, maintenance, use, quality, legality, reliability, and usefulness of the contents, information, communications, opinions, statements, products, and services on websites not managed by ON POINT PRODUCTIONS AGENCY LLC and accessible through ON POINT PRODUCTIONS AGENCY LLC.'**
  String get noSePermiteRepr;

  /// No description provided for @derechoExcl.
  ///
  /// In en, this message translates to:
  /// **'6. RIGHT OF EXCLUSION'**
  String get derechoExcl;

  /// No description provided for @derechoExclText.
  ///
  /// In en, this message translates to:
  /// **'ON POINT PRODUCTIONS AGENCY LLC reserves the right to deny or withdraw access to the portal and/or the services offered without prior notice, at its own request or that of a third party, to users who violate these General Terms of Use.'**
  String get derechoExclText;

  /// No description provided for @generalidades.
  ///
  /// In en, this message translates to:
  /// **'7. GENERALITIES'**
  String get generalidades;

  /// No description provided for @generalidadesText.
  ///
  /// In en, this message translates to:
  /// **'ON POINT PRODUCTIONS AGENCY LLC will pursue non-compliance with these conditions as well as any misuse of its website, exercising all civil and criminal actions that may correspond in law.'**
  String get generalidadesText;

  /// No description provided for @modificacionCond.
  ///
  /// In en, this message translates to:
  /// **'8. MODIFICATION OF THESE TERMS AND DURATION'**
  String get modificacionCond;

  /// No description provided for @modificacionCondText.
  ///
  /// In en, this message translates to:
  /// **'ON POINT PRODUCTIONS AGENCY LLC may modify the conditions determined here at any time, and they will be duly published as they appear here. The validity of these conditions will depend on their exposure and will be in force until they are modified by others that are duly published.'**
  String get modificacionCondText;

  /// No description provided for @reclamacionesDudas.
  ///
  /// In en, this message translates to:
  /// **'9. COMPLAINTS AND QUESTIONS'**
  String get reclamacionesDudas;

  /// No description provided for @reclamacionesDudasText.
  ///
  /// In en, this message translates to:
  /// **'ON POINT PRODUCTIONS AGENCY LLC informs that complaint forms are available to users and customers and can be sent by email to hola@jpdirector.net, indicating their name and surname, the service or product purchased, and stating the reasons for their complaint.\nYou can also send your complaint by postal mail to: ON POINT PRODUCTIONS AGENCY LLC, 4020 N MacArthur Blvd Suite 122, Irving, Texas 75038, United States of America.'**
  String get reclamacionesDudasText;

  /// No description provided for @condicionesDeVenta.
  ///
  /// In en, this message translates to:
  /// **'10. SALES CONDITIONS'**
  String get condicionesDeVenta;

  /// No description provided for @condicionesDeVentaText.
  ///
  /// In en, this message translates to:
  /// **'These general conditions expressly regulate the conditions applicable to the contracting processes carried out by \"Customer\" users of online courses and services offered by ON POINT PRODUCTIONS AGENCY LLC through its website.\nThese conditions will remain in force and will be valid for as long as they are accessible through the website, without prejudice to ON POINT PRODUCTIONS AGENCY LLC reserving the right to modify, without prior notice, the general conditions as well as any of the legal texts found on the website. In any case, access to the Website after its modification, inclusion, and/or replacement implies the user\'s acceptance of them.\nThe customer is subject to the general conditions in force at the time of the corresponding contracting, and it is not possible to contract any service without prior acceptance of these general contracting conditions.\nOn this website, you can purchase products or services listed on each sales page.\nTo proceed with payment, the customer has the following payment methods available:\nVisa/Mastercard/American Express; the user must provide the cardholder\'s name, card number, expiration date, and CVV.\nAll information will be processed through a payment gateway external to ON POINT PRODUCTIONS AGENCY LLC located at Stripe.com, and more information can be obtained by visiting their website at https://stripe.com/privacy - https://www.paypal.com/us/home.\nTo proceed with payment, you will normally be redirected to a shopping cart where you will be asked for the necessary information through third-party platforms such as Stripe or Paypal.'**
  String get condicionesDeVentaText;

  /// No description provided for @leyAplicable.
  ///
  /// In en, this message translates to:
  /// **'11. APPLICABLE LAW AND JURISDICTION'**
  String get leyAplicable;

  /// No description provided for @leyAplicableText.
  ///
  /// In en, this message translates to:
  /// **'The relationship between ON POINT PRODUCTIONS AGENCY LLC and the CUSTOMER will be governed by the laws of the United States, and any dispute will be subject to the courts and tribunals of the State of Florida, unless applicable law provides otherwise.'**
  String get leyAplicableText;

  /// No description provided for @causasDeDisolucion.
  ///
  /// In en, this message translates to:
  /// **'12. CAUSES FOR CONTRACT DISSOLUTION'**
  String get causasDeDisolucion;

  /// No description provided for @causasDeDisolucionText.
  ///
  /// In en, this message translates to:
  /// **'The dissolution of the service contract can occur at any time by either party.\nYou are not obligated to remain under any conditions with ON POINT PRODUCTIONS AGENCY LLC.\nON POINT PRODUCTIONS AGENCY LLC can terminate or suspend any and all contracted Services immediately, without prior notice or liability, if you fail to comply with the conditions stated here.\nUpon dissolution of the contract, your right to use the Services will cease immediately.\nCauses for dissolution of the contract include:'**
  String get causasDeDisolucionText;

  /// No description provided for @laFalsedadText.
  ///
  /// In en, this message translates to:
  /// **'Falsehood, in whole or in part, of the data provided in the contracting process for any service.\nAltering, bypassing, reverse engineering, disassembling, or otherwise altering the security technology provided by ON POINT PRODUCTIONS AGENCY LLC.\nCases of abuse of support services by requiring more hours than those established in the contract.\nFalse and unfounded opinions with the intent to discredit the owner of the acquired products or services.\nAny non-compliance established throughout the conditions.'**
  String get laFalsedadText;

  /// No description provided for @laDisolucion.
  ///
  /// In en, this message translates to:
  /// **'Dissolution implies the loss of your rights to the contracted service.'**
  String get laDisolucion;

  /// No description provided for @todosLosDerechosRes.
  ///
  /// In en, this message translates to:
  /// **'ALL RIGHTS RESERVED © 2023'**
  String get todosLosDerechosRes;

  /// No description provided for @estaPolitica.
  ///
  /// In en, this message translates to:
  /// **'This privacy policy, along with the legal notice, cookie policy, sales policy, terms and conditions, and any other referenced policy, identifies how personal data received on this website is collected and processed.\nThe information on this website is not intended for children. A child will be defined as provided by the law of the jurisdiction where it is so defined; in the case of the United States of America, it is someone under the age of 13. If the user believes that a child has provided their personal data on this website without parental consent, they should write to hola@jpdirector.net.\nIf the user is under 13 years old, they must have the authorization of their parents or legal guardians to provide their personal data. JPDIRECTOR has no way of effectively verifying the age of users, so it is exempt from any responsibility if the user does not comply with what is indicated here. At JPDIRECTOR, we comply with the Children\'s Online Privacy Protection Act of 1998 (“COPPA”).\nData identifying the data controller\nAs required by current regulations, we inform you that:\n'**
  String get estaPolitica;

  /// No description provided for @laDenominacionSocial.
  ///
  /// In en, this message translates to:
  /// **'-The corporate name of the data controller for this website is: ON POINT PRODUCTIONS AGENCY LLC. For the purposes of this legal notice and terms of use, it will be referred to as JPDIRECTOR hereinafter.\n-Its registered office is located at: 4020 N MacArthur Blvd Suite 122, Irving, Texas 75038, United States of America.\n-You can contact them by Email: hola@jpdirector.net\n-Its social activity is: training, blogging, and advertising consultancy for online businesses.\n'**
  String get laDenominacionSocial;

  /// No description provided for @datosSolicitados.
  ///
  /// In en, this message translates to:
  /// **'Data requested on the website and purpose of processing.\n'**
  String get datosSolicitados;

  /// No description provided for @nombApllYCorr.
  ///
  /// In en, this message translates to:
  /// **'-Name, last name, and email in contact forms: for any direct contact with JPDIRECTOR, whether to ask questions, provide comments, suggestions, request a service or product, or any other information. Failure to provide the minimum necessary personal data will prevent JPDIRECTOR from responding to the request.\n-Name and email: to be able to leave comments on the website\'s blog.\n-Name, last name, address, phone number, email, tax identification number: this information will be requested at the time of payment for the service to process everything related to the customer.\n-Name, phone number, and email for newsletter: with the express and voluntary consent of the data subject, the minimum information necessary to send an automated commercial newsletter will be requested on the website, which will inform about advertising, promotions, and other information about the services and/or products offered by JPDIRECTOR.\n-Email: the email will be requested in order to access the client area, in accordance with the data provided when creating the account.\n'**
  String get nombApllYCorr;

  /// No description provided for @jpEnTodoMomento.
  ///
  /// In en, this message translates to:
  /// **'JPDIRECTOR will always ensure that the use of the website, its contents, and the processing of user\'s personal data are carried out correctly. For this purpose, the user can always exercise their rights of access, rectification, limitation, cancellation, portability, forgetfulness, or opposition, all in faithful compliance with the guidelines of the laws governing the matter, by writing to JPDIRECTOR. JPDIRECTOR does not sell or will sell users\' personal data to other companies or third parties.\n'**
  String get jpEnTodoMomento;

  /// No description provided for @jpCompartira.
  ///
  /// In en, this message translates to:
  /// **'JPDIRECTOR will share with third parties the data it possesses only to fulfill services contracted by a user, send the newsletter, comply with legal requirements, or administer the website. To this end, the necessary confidentiality agreements will be provided between the parties.\n'**
  String get jpCompartira;

  /// No description provided for @losEnlacesATerceros.
  ///
  /// In en, this message translates to:
  /// **'Third-party links that may be found on the website have privacy policies that are independent of JPDIRECTOR. Access to these sites shall be the responsibility of the user, and it is their responsibility to understand and decide whether to accept them or not.\n'**
  String get losEnlacesATerceros;

  /// No description provided for @formularios.
  ///
  /// In en, this message translates to:
  /// **'FORMS'**
  String get formularios;

  /// No description provided for @elSitioWebDispone.
  ///
  /// In en, this message translates to:
  /// **'The website has 4 types of forms:\nContact form: Users, clients, or participants can find forms that facilitate communication with JPDIRECTOR to ask questions, provide comments, request a quote, book any of the services offered on the website, or assert any rights they may have. Failure to provide the minimum necessary personal data will prevent JPDIRECTOR from responding to the request. This processing will be considered legitimate as part of a pre-contractual diligence. The website server and JPDIRECTOR\'s email will be responsible for processing.\nAdvertising form: Users, buyers, or participants will be asked for their express and voluntary consent to provide JPDIRECTOR with the minimum necessary data to send advertising and commercial information related to the services and/or products offered by JPDIRECTOR, to be added to an automated email marketing file managed by the data processor indicated below. The processing of personal data in this section has been carried out with the consent of the data subject.\nComment forms on the blog: In order to prevent spam, inappropriate messages, and to provide proper tracking, users will be asked for their name, email, and website to identify them in the comments they wish to make on blog posts. This data will be visible to other website users. If you do not want your data to be visible to others, you should contact JPDIRECTOR at the email address hola@jpdirector.net. The website server will be responsible for processing, and this will be done with the consent of the data subject.\nService request form: Users, clients, or participants will be asked for their data so that JPDIRECTOR can process the services requested by the client. Legitimate processing of personal data due to the contractual relationship with the client or participant. The data will be stored on the website server.\n'**
  String get elSitioWebDispone;

  /// No description provided for @derechos.
  ///
  /// In en, this message translates to:
  /// **'RIGHTS'**
  String get derechos;

  /// No description provided for @elUsuarioTiene.
  ///
  /// In en, this message translates to:
  /// **'The user has the following rights related to their personal data:\nAccess: The user can contact JPDIRECTOR to find out what data has been collected about them.\nRectification: The user can rectify the data they have provided to JPDIRECTOR at any time.\nObjection: As long as it does not interrupt the provision of a service or a legal obligation that JPDIRECTOR has, the user may request the cessation of the processing of their personal data.\nDeletion: As long as it does not interrupt the provision of a service or a legal obligation that JPDIRECTOR has, the user may request the deletion of their personal data.\nProcessing Limitation: As long as it does not interrupt the provision of a service or a legal obligation that JPDIRECTOR has, the user may request that their personal data be processed as they limit it, for example, requesting that it not be modified, deleted, or suppressed.\nPortability: Whenever the user requests it and it can be done, they may request a copy of their personal data in a structured, commonly used, machine-readable, and interoperable format or request that it be transmitted to another data controller, provided that the processing is based on consent or within the framework of the execution of a contract.\nNot to be the subject of automated individual decisions: JPDIRECTOR does not make automated profiles that can significantly or negatively affect the user. Any decision made based on an automated profile is solely for the purpose of sending the user information they have requested in accordance with their browsing habits and material downloads on the website.\nInformation: The user has the right to know how their personal data is processed.\nTo exercise any of these rights, the user can write to the email address hola@jpdirector.net\n'**
  String get elUsuarioTiene;

  /// No description provided for @encargadosDelTratamiento.
  ///
  /// In en, this message translates to:
  /// **'DATA PROCESSORS\n'**
  String get encargadosDelTratamiento;

  /// No description provided for @jpNecesitaElApoyo.
  ///
  /// In en, this message translates to:
  /// **'JPDIRECTOR needs the support of third parties to properly offer its services and products, with which it enters into appropriate confidentiality agreements and verifies compliance with personal data protection regulations.\nThe data provided to these third parties may not be used for purposes not authorized by the data subject.\nIn compliance with the principles of information and transparency, it is hereby made known that these third parties are:\nMailchimp: Used for email marketing and client management. You can find more information about their privacy policy at https://mailchimp.com/about/security/\nHostgator: Hosting provider (web hosting). You can view their privacy policy at https://es.wix.com/manage/privacy-security-hub\nFacebook: Tool used as a social network and for the purpose of connecting with the data subject. The service is provided by Facebook Ireland Ltd., and their servers are in the United States. They have adopted standard data processing clauses approved by the European Commission, which can be consulted at: https://www.facebook.com/legal/terms/dataprocessing. You can review their privacy policy at https://www.facebook.com/business/gdpr. This tool is also used for advertising on WhatsApp and/or Instagram, as well as data analysis and statistics for potential ad targeting.\nGoogle: Sponsored advertising system (ADS), web analytics service for viewing website usage statistics (Analytics), and tag management system (Tag Manager). These services are provided by Google LLC, located in Mountain View, California, United States of America. They have adopted standard data processing clauses approved by the European Commission, which can be consulted at: https://cloud.google.com/security/gdpr/resource-center. If you want more information about their privacy policy, you can visit: https://policies.google.com/privacy\nInstagram: Social network and app for sharing photos and videos owned by Facebook Inc., located at 1601 Willow Road Menlo Park, CA 94025, United States of America. If you are outside the United States or Canada, the data controller responsible for the information is Facebook Ireland Ltd., located at 4 Grand Canal Square Grand Canal Harbour, Dublin 2, Ireland. They have adopted standard data processing clauses approved by the European Commission, which can be consulted at: https://www.facebook.com/legal/terms/dataprocessing. For more information about the privacy policy, visit: https://help.instagram.com/155833707900388\nLinkedIn: Business-oriented social network. You can contact them at https://www.linkedin.com/help/linkedin?lang=es, and their privacy policy can be viewed at https://www.linkedin.com/legal/privacy-policy\nPayPal (Europe) S.à r.l. et Cie, S.C.A.: Used to manage payments by debit and credit card on the website. Located at 22-24 Boulevard Royal L-2449, Luxembourg. For more information, visit https://www.paypal.com/es/webapps/mpp/ua/privacy-full?locale.x=es_ES\nFacebook Pixel: Analytics tool for advertising, used to track actions of data subjects on this website. This service is provided by Facebook, Inc., located at 1601 Willow Road Menlo Park, CA 94025, United States of America. If you are outside the United States or Canada, the data controller responsible for the information is Facebook Ireland Ltd., located at 4 Grand Canal Square Grand Canal Harbour, Dublin 2, Ireland. They have adopted standard data processing clauses approved by the European Commission, which can be consulted at: https://www.facebook.com/legal/terms/dataprocessing. For more information about the privacy policy, visit https://www.facebook.com/privacy/explanation\nStripe: Tool used to manage payments by debit and credit card on the website. They have adopted standard data processing clauses approved by the European Commission, which can be consulted at: https://es.wix.com/manage/privacy-security-hub\nTikTok: Social network and app for sharing videos owned by TikTok Technology Limited, located at 10 Earlsfort Terrace, Dublin, D02 T380, Ireland. For users in the UK: TikTok Information Technologies UK Limited, WeWork, 125 Kingsway, London, WC2B 6NH, United Kingdom. For more information about the privacy policy, visit https://www.tiktok.com/legal/privacy-policy?lang=es\nTwitter: Social network based in San Francisco, California, with subsidiaries in San Antonio and Boston in the United States, provided by Twitter, Inc. They have adopted standard data processing clauses approved by the European Commission, which can be consulted at: https://gdpr.twitter.com/. You can contact them at https://help.twitter.com/en/contact-us, and their privacy policy can be viewed at https://twitter.com/es/privacy\nVimeo: Video platform. This service is provided by Vimeo, Inc., located in the United States, and they have adopted standard data processing clauses approved by the European Commission. For more information about their privacy policy, visit https://vimeo.com/privacy\nWhatsApp: Tool used for communication with users, buyers, clients, and participants through WhatsApp Ireland Limited (for those located in Europe). You can contact them through the link https://www.whatsapp.com/contact/?subject=messenger, and their privacy policy can be viewed at https://www.whatsapp.com/legal?eea=1#privacy-policy.\nZoom: Tool used for video conferencing. This service is provided by Zoom Video Communications, Inc., located in the United States of America, and they have adopted standard data processing clauses approved by the European Commission, which can be consulted at: https://zoom.us/gdpr. For more information about their privacy policy, visit: https://zoom.us/privacy\nIn specific cases, JPDIRECTOR may use applications or tools that have not been included or named in this list, as this may be a better option to help with a particular task. If this happens, JPDIRECTOR will notify its users, clients, or participants as appropriate.\n'**
  String get jpNecesitaElApoyo;

  /// No description provided for @politicasRelacionadasConNews.
  ///
  /// In en, this message translates to:
  /// **'POLICIES RELATED TO THE NEWSLETTER\n'**
  String get politicasRelacionadasConNews;

  /// No description provided for @estasPoliticasSeEntenderan.
  ///
  /// In en, this message translates to:
  /// **'These policies shall be understood at all times as a complementary part of the terms and conditions set forth on the website, both of which shall be equally applicable in the event of a dispute. The privacy and intellectual property policy applied shall be the same as that set forth in the terms and conditions of the website.\nThe term \'newsletter\' shall refer to the digital newsletter periodically produced by JPDIRECTOR and sent to its subscribers through an external email service provider, to which the user has voluntarily subscribed.\nJPDIRECTOR is not obligated to send the newsletter at defined time intervals, and is therefore completely free to do so at its discretion. The user may at any time exercise their rights of access, rectification, cancellation, or opposition by following the instructions found in the footer of the newsletter.\nThe user shall not share its content with third parties, as this would violate JPDIRECTOR\'s copyright. The only possible distribution channel is one administered and/or authorized by JPDIRECTOR.\nJPDIRECTOR shall not be responsible for the content of third parties presented in the newsletter; any disputes that arise shall be addressed directly with the person or company mentioned.\nAll material presented in the newsletter is protected by copyright in favor of JPDIRECTOR, and in the case of third parties, it shall be understood that JPDIRECTOR has obtained the necessary authorization to use it as agreed with the author.\n'**
  String get estasPoliticasSeEntenderan;

  /// No description provided for @interesLegitimo.
  ///
  /// In en, this message translates to:
  /// **'LEGITIMATE INTEREST\n'**
  String get interesLegitimo;

  /// No description provided for @cuandoSeRealice.
  ///
  /// In en, this message translates to:
  /// **'When launching new products or services, or special promotions for a specified period, the name and email address of website users will be collected through a form. This processing of personal data shall be based on JPDIRECTOR\'s legitimate interest in increasing its sales, promoting its products or services, and fulfilling the purpose of sending the promised information on the website.\nThis processing shall be carried out for as long as JPDIRECTOR\'s legitimate interest persists. To enhance privacy guarantees and respect for privacy, the option to opt out of this advertising is offered through an easy and immediate method located at the bottom of the emails received.\nTo determine whether this interest is provided and respectful of the rights of data subjects, a balancing test has been conducted, which can be requested at any time by writing to the email address hola@jpdirector.net\n'**
  String get cuandoSeRealice;

  /// No description provided for @duracionDeTratamiento.
  ///
  /// In en, this message translates to:
  /// **'DURATION OF PROCESSING\n'**
  String get duracionDeTratamiento;

  /// No description provided for @enElCasoDeLosDatos.
  ///
  /// In en, this message translates to:
  /// **'In the case of personal data provided for billing and the purchase of products or services, they shall be retained for the legally applicable period.\nIn the case of personal data provided for electronic commercial newsletters and blog comments, they shall be retained for as long as the data subject wishes to remain on the subscription list, and they may unsubscribe at any time, automatically as indicated in each newsletter, or by writing to support@quieroads.com\n'**
  String get enElCasoDeLosDatos;

  /// No description provided for @residentesCalifornia.
  ///
  /// In en, this message translates to:
  /// **'RESIDENTS OF CALIFORNIA, UNITED STATES\n'**
  String get residentesCalifornia;

  /// No description provided for @jpCumpleLaLey.
  ///
  /// In en, this message translates to:
  /// **'JPDIRECTOR complies with the California Consumer Privacy Act of 2018 (“CCPA”). Residents of California have the right to request that JPDIRECTOR disclose what personal information it has collected, used, disclosed, and sold during the 12 months prior to receiving such a request. To exercise this right, as well as the right to deletion or opposition to the processing of their data, the user should write to hola@jpdirector.net\n'**
  String get jpCumpleLaLey;

  /// No description provided for @laContrasenaSeHaReest.
  ///
  /// In en, this message translates to:
  /// **'Your password has been reset, and you can now log in with your new password.'**
  String get laContrasenaSeHaReest;

  /// No description provided for @ingresaNewPass.
  ///
  /// In en, this message translates to:
  /// **'Enter your new password'**
  String get ingresaNewPass;

  /// No description provided for @graciasPorConfirmar.
  ///
  /// In en, this message translates to:
  /// **'Thank you for confirming your account'**
  String get graciasPorConfirmar;

  /// No description provided for @enlaceInvalido.
  ///
  /// In en, this message translates to:
  /// **'INVALID LINK'**
  String get enlaceInvalido;

  /// No description provided for @pagina404.
  ///
  /// In en, this message translates to:
  /// **'Page not found 404'**
  String get pagina404;

  /// No description provided for @porFavorEspere.
  ///
  /// In en, this message translates to:
  /// **'Please wait'**
  String get porFavorEspere;

  /// No description provided for @leadCreadoConExito.
  ///
  /// In en, this message translates to:
  /// **'Lead created successfully'**
  String get leadCreadoConExito;

  /// No description provided for @leadActualizadoConExito.
  ///
  /// In en, this message translates to:
  /// **'Lead updated successfully'**
  String get leadActualizadoConExito;

  /// No description provided for @nuevoLead.
  ///
  /// In en, this message translates to:
  /// **'New Lead'**
  String get nuevoLead;

  /// No description provided for @responder.
  ///
  /// In en, this message translates to:
  /// **'Reply'**
  String get responder;

  /// No description provided for @respuesta.
  ///
  /// In en, this message translates to:
  /// **'Response'**
  String get respuesta;

  /// No description provided for @fecha.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get fecha;

  /// No description provided for @nuevoForm.
  ///
  /// In en, this message translates to:
  /// **'New Form'**
  String get nuevoForm;

  /// No description provided for @hola.
  ///
  /// In en, this message translates to:
  /// **'Hello,'**
  String get hola;

  /// No description provided for @bienvenidoAlosProg.
  ///
  /// In en, this message translates to:
  /// **'Welcome to the most comprehensive digital advertising programs. We thank you and send you a big hug for trusting our training; we are excited to see you grow on this new path to success.'**
  String get bienvenidoAlosProg;

  /// No description provided for @teExplicamos.
  ///
  /// In en, this message translates to:
  /// **'We\'ll explain everything you need to know 👇:'**
  String get teExplicamos;

  /// No description provided for @cadaCursoCuenta.
  ///
  /// In en, this message translates to:
  /// **'1. Each course has its comment section - you can leave us all your questions, and our team will answer them.'**
  String get cadaCursoCuenta;

  /// No description provided for @podrasDescargar.
  ///
  /// In en, this message translates to:
  /// **'2. You\'ll be able to download complementary materials for each module of the class you\'re learning.'**
  String get podrasDescargar;

  /// No description provided for @unaVezFinalices.
  ///
  /// In en, this message translates to:
  /// **'3. Once you finish the course, you can download your completion certificate from the button that will appear at the top right'**
  String get unaVezFinalices;

  /// No description provided for @siTienesAlgunaDuda.
  ///
  /// In en, this message translates to:
  /// **'4. If you have any more specific questions, we have a '**
  String get siTienesAlgunaDuda;

  /// No description provided for @centroSoporte.
  ///
  /// In en, this message translates to:
  /// **'Help and Support Center'**
  String get centroSoporte;

  /// No description provided for @dondeTeBrindaremos.
  ///
  /// In en, this message translates to:
  /// **'where we will provide you with a response within 48 hours.'**
  String get dondeTeBrindaremos;

  /// No description provided for @enviarEmaila.
  ///
  /// In en, this message translates to:
  /// **'Send an email to:'**
  String get enviarEmaila;

  /// No description provided for @escribeComentario.
  ///
  /// In en, this message translates to:
  /// **'Write your comment'**
  String get escribeComentario;

  /// No description provided for @continuaMensaje.
  ///
  /// In en, this message translates to:
  /// **'continue the message...'**
  String get continuaMensaje;

  /// No description provided for @mensajeEnviado.
  ///
  /// In en, this message translates to:
  /// **'Message sent successfully'**
  String get mensajeEnviado;

  /// No description provided for @envianosComentario.
  ///
  /// In en, this message translates to:
  /// **'Send us your comments; in less than 48 hours, we will provide you with a response.'**
  String get envianosComentario;

  /// No description provided for @enQueAyudarte.
  ///
  /// In en, this message translates to:
  /// **'How can we assist you'**
  String get enQueAyudarte;

  /// No description provided for @graciasPorComunicarte.
  ///
  /// In en, this message translates to:
  /// **'Thank you for getting in touch; in less than 48 hours, we will provide you with a response via email.'**
  String get graciasPorComunicarte;

  /// No description provided for @comienzaAqui.
  ///
  /// In en, this message translates to:
  /// **'Start Here'**
  String get comienzaAqui;

  /// No description provided for @borrar.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get borrar;

  /// No description provided for @modulos.
  ///
  /// In en, this message translates to:
  /// **'MODULES'**
  String get modulos;

  /// No description provided for @testimonios.
  ///
  /// In en, this message translates to:
  /// **'TESTIMONIALS'**
  String get testimonios;

  /// No description provided for @cursoCreado.
  ///
  /// In en, this message translates to:
  /// **'Course created successfully'**
  String get cursoCreado;

  /// No description provided for @errorCursoCreado.
  ///
  /// In en, this message translates to:
  /// **'Error creating course'**
  String get errorCursoCreado;

  /// No description provided for @cursoAgregado.
  ///
  /// In en, this message translates to:
  /// **'Course added'**
  String get cursoAgregado;

  /// No description provided for @cursoBorrado.
  ///
  /// In en, this message translates to:
  /// **'Course deleted'**
  String get cursoBorrado;

  /// No description provided for @cursoActualizado.
  ///
  /// In en, this message translates to:
  /// **'Course updated successfully'**
  String get cursoActualizado;

  /// No description provided for @errorCursoActualizado.
  ///
  /// In en, this message translates to:
  /// **'Error updating course'**
  String get errorCursoActualizado;

  /// No description provided for @moduloAgregado.
  ///
  /// In en, this message translates to:
  /// **'Module added successfully'**
  String get moduloAgregado;

  /// No description provided for @errorModuloAgregado.
  ///
  /// In en, this message translates to:
  /// **'Error adding module'**
  String get errorModuloAgregado;

  /// No description provided for @moduloActualizado.
  ///
  /// In en, this message translates to:
  /// **'Module updated successfully'**
  String get moduloActualizado;

  /// No description provided for @errorActualizandoModulo.
  ///
  /// In en, this message translates to:
  /// **'Error updating module'**
  String get errorActualizandoModulo;

  /// No description provided for @moduloBorrado.
  ///
  /// In en, this message translates to:
  /// **'Module deleted successfully'**
  String get moduloBorrado;

  /// No description provided for @errorBorrandoModulo.
  ///
  /// In en, this message translates to:
  /// **'Error deleting module'**
  String get errorBorrandoModulo;

  /// No description provided for @comentarioAgregado.
  ///
  /// In en, this message translates to:
  /// **'Comment added successfully'**
  String get comentarioAgregado;

  /// No description provided for @errorAgregandoComentario.
  ///
  /// In en, this message translates to:
  /// **'Error adding comment'**
  String get errorAgregandoComentario;

  /// No description provided for @testimonioAgregado.
  ///
  /// In en, this message translates to:
  /// **'Testimonial added successfully'**
  String get testimonioAgregado;

  /// No description provided for @errorTestimonioAgregado.
  ///
  /// In en, this message translates to:
  /// **'Error adding testimonial'**
  String get errorTestimonioAgregado;

  /// No description provided for @testimonioActualizado.
  ///
  /// In en, this message translates to:
  /// **'Testimonial updated successfully'**
  String get testimonioActualizado;

  /// No description provided for @errorTestimonioActualizado.
  ///
  /// In en, this message translates to:
  /// **'Error updating testimonial'**
  String get errorTestimonioActualizado;

  /// No description provided for @testimonioBorrado.
  ///
  /// In en, this message translates to:
  /// **'Testimonial deleted successfully'**
  String get testimonioBorrado;

  /// No description provided for @errorTestimonioBorrado.
  ///
  /// In en, this message translates to:
  /// **'Error deleting testimonial'**
  String get errorTestimonioBorrado;

  /// No description provided for @debeVerificar.
  ///
  /// In en, this message translates to:
  /// **'You must verify your account. Check your email.'**
  String get debeVerificar;

  /// No description provided for @credencialesInvalidas.
  ///
  /// In en, this message translates to:
  /// **'Invalid credentials'**
  String get credencialesInvalidas;

  /// No description provided for @errorAuth.
  ///
  /// In en, this message translates to:
  /// **'There was an issue with your authentication.'**
  String get errorAuth;

  /// No description provided for @graciasPorRegistrarte.
  ///
  /// In en, this message translates to:
  /// **'Thank you for registering; please check your email to verify your account.'**
  String get graciasPorRegistrarte;

  /// No description provided for @correoYaExiste.
  ///
  /// In en, this message translates to:
  /// **'Email already exists. Go to Log in.'**
  String get correoYaExiste;

  /// No description provided for @actInfo.
  ///
  /// In en, this message translates to:
  /// **'Update Information'**
  String get actInfo;

  /// No description provided for @soporte.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get soporte;

  /// No description provided for @tiempoSeAcumulaPreg.
  ///
  /// In en, this message translates to:
  /// **'¿If I watch less than the established time, does it accumulate?'**
  String get tiempoSeAcumulaPreg;

  /// No description provided for @tiempoSeAcumulaResp.
  ///
  /// In en, this message translates to:
  /// **'No, if you have scheduled your session and we have resolved your issue, the consultation will be considered finished.'**
  String get tiempoSeAcumulaResp;

  /// No description provided for @blog.
  ///
  /// In en, this message translates to:
  /// **'Blog'**
  String get blog;

  /// No description provided for @publishedBlogs.
  ///
  /// In en, this message translates to:
  /// **'Published Blogs'**
  String get publishedBlogs;

  /// No description provided for @loadingBlogs.
  ///
  /// In en, this message translates to:
  /// **'Loading blogs...'**
  String get loadingBlogs;

  /// No description provided for @blogError.
  ///
  /// In en, this message translates to:
  /// **'Error loading blogs'**
  String get blogError;

  /// No description provided for @readMore.
  ///
  /// In en, this message translates to:
  /// **'Read More'**
  String get readMore;

  /// No description provided for @noBlogsFound.
  ///
  /// In en, this message translates to:
  /// **'No blogs found'**
  String get noBlogsFound;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
