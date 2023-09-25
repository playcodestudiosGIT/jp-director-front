// import 'dart:html'L
import 'package:flutter/material.dart';
import 'package:jp_director/models/certificado.dart';

import 'models/curso.dart';
import 'models/modulo.dart';
import 'models/usuario_model.dart';

const String pkStripe =
    'pk_test_51NCcdnGhOVgj1hOFzlJboe8kgzH1VX1rvTVqG8PiC5jLTrGXs1bQzwFdXgCJO3y8Ba8dWzaq7VqwtP3O6ph2gISg001gyqcNha';
const String skStripe =
    'sk_test_51NCcdnGhOVgj1hOFz0oLPJyzTrmV6vHGVP6wLuZ5cz9rOqGKP9O8CqHBwTBPusa4mI5xz1BHKRORu1GiwVWM1CfV00F85lS9Jb';

const Color bgColor = Color(0xff00041C);
const Color blancoText = Color(0xFFffffff);
const Color azulText = Color(0xff15E0FB);
const Color verdeBorde = Color(0xff9BCB6C);
const NetworkImage pc = NetworkImage(
    'https://res.cloudinary.com/dqiwrcosz/image/upload/v1693706534/statics/pc_kksp4q.png');
const NetworkImage monitor = NetworkImage(
    'https://res.cloudinary.com/dqiwrcosz/image/upload/v1693706640/statics/monitor_wsusvi.png');
const NetworkImage tablet = NetworkImage(
    'https://res.cloudinary.com/dqiwrcosz/image/upload/v1693705764/statics/tablet_zjxxfi.png');
const NetworkImage telf = NetworkImage(
    'https://res.cloudinary.com/dqiwrcosz/image/upload/v1694401353/statics/telf_dmhygj.png');
const NetworkImage satelite = NetworkImage(
    'https://res.cloudinary.com/dqiwrcosz/image/upload/v1693708131/statics/satellite_vyiytt.png');
const NetworkImage logoIso = NetworkImage(
    'https://res.cloudinary.com/dqiwrcosz/image/upload/v1694014366/statics/logo_iso_rg1wm0.png');
const NetworkImage logoGrande = NetworkImage(
    'https://res.cloudinary.com/dqiwrcosz/image/upload/v1695156967/statics/logogrande_ukkhwr.png');
const NetworkImage logoJp = NetworkImage(
    'https://res.cloudinary.com/dqiwrcosz/image/upload/v1695152395/statics/logojp_usskxb.png');
const NetworkImage planetaI = NetworkImage(
    'https://res.cloudinary.com/dqiwrcosz/image/upload/v1695152663/statics/planetai_k7k4wb.png');
const NetworkImage planetaM = NetworkImage(
    'https://res.cloudinary.com/dqiwrcosz/image/upload/v1695152663/statics/planetam_tykn8e.png');
const NetworkImage planetaF = NetworkImage(
    'https://res.cloudinary.com/dqiwrcosz/image/upload/v1695152662/statics/planetaf_d4yqyh.png');
const NetworkImage circulo = NetworkImage(
    'https://res.cloudinary.com/dqiwrcosz/image/upload/v1695156998/statics/circulo_aeedye.png');
const NetworkImage baseGif = NetworkImage(
    'https://res.cloudinary.com/dqiwrcosz/image/upload/v1695157034/statics/base_ukffbu.gif');
const NetworkImage rocketGif = NetworkImage(
    'https://res.cloudinary.com/dqiwrcosz/image/upload/v1695157083/statics/rocket_z2qbbc.gif');
const NetworkImage rocketInd = NetworkImage(
    'https://res.cloudinary.com/dqiwrcosz/image/upload/v1693117714/statics/cohete_cskqev.gif');
const NetworkImage ufoGif = NetworkImage(
    'https://res.cloudinary.com/dqiwrcosz/image/upload/v1695157182/statics/ufo_tp1lxv.gif');
const NetworkImage bgContacto = NetworkImage(
    'https://res.cloudinary.com/dqiwrcosz/image/upload/v1695157212/statics/bgcontact_lv8hpk.png');
const NetworkImage bgEncargado = NetworkImage(
    'https://res.cloudinary.com/dqiwrcosz/image/upload/v1695157238/statics/encargadobg_xabrz4.png');
const NetworkImage bgMentoria = NetworkImage(
    'https://res.cloudinary.com/dqiwrcosz/image/upload/v1695157268/statics/mentoriabg_wjclim.png');
const NetworkImage bgAsesoria = NetworkImage(
    'https://res.cloudinary.com/dqiwrcosz/image/upload/v1695157294/statics/asesoriabg_karz0f.png');
const NetworkImage bgConferencia = NetworkImage(
    'https://res.cloudinary.com/dqiwrcosz/image/upload/v1695157323/statics/conferenciasbg_fqr5sv.png');
const NetworkImage iconInsta = NetworkImage(
    'https://res.cloudinary.com/dqiwrcosz/image/upload/v1695157390/statics/iconInsta_ptkhau.png');
const NetworkImage iconFb = NetworkImage(
    'https://res.cloudinary.com/dqiwrcosz/image/upload/v1695157433/statics/logo-facebook_glutae.png');
const NetworkImage iconTiktok = NetworkImage(
    'https://res.cloudinary.com/dqiwrcosz/image/upload/v1695157465/statics/logo-tiktok_oii03t.png');
const NetworkImage bgHome = NetworkImage(
    'https://res.cloudinary.com/dqiwrcosz/image/upload/v1695152485/statics/bghome_zyt712.png');
const NetworkImage adsCircle = NetworkImage(
    'https://res.cloudinary.com/dqiwrcosz/image/upload/v1695157486/statics/ADS_du7z30.png');
const NetworkImage arrDown = NetworkImage(
    'https://res.cloudinary.com/dqiwrcosz/image/upload/v1695152540/statics/arr-down_phz4pk.png');
const NetworkImage btnComent = NetworkImage(
    'https://res.cloudinary.com/dqiwrcosz/image/upload/v1693593488/statics/comments_vggbgq.png');
const NetworkImage downMaterial = NetworkImage(
    'https://res.cloudinary.com/dqiwrcosz/image/upload/v1693593811/statics/descMate_ej15xq.png');
const NetworkImage certfGuiaImg = NetworkImage(
    'https://res.cloudinary.com/dqiwrcosz/image/upload/v1693593977/statics/certf_gnidpt.png');
const NetworkImage fotoJorgeCursos = NetworkImage(
    'https://res.cloudinary.com/dqiwrcosz/image/upload/v1694402626/statics/jorgecursos_zkzkv7.png');
const String noimage =
    'https://res.cloudinary.com/dqiwrcosz/image/upload/v1695157523/statics/noimage_nstphk.jpg';

final List<String> resultadosMini = [
  'https://res.cloudinary.com/dqiwrcosz/image/upload/v1691610046/statics/RESULTADOS_2_mini_ci5h8o.png',
  'https://res.cloudinary.com/dqiwrcosz/image/upload/v1691610046/statics/RESULTADOS_3_mini_g7mgho.png',
  'https://res.cloudinary.com/dqiwrcosz/image/upload/v1691610046/statics/RESULTADOS_4_mini_nfs65i.png',
  'https://res.cloudinary.com/dqiwrcosz/image/upload/v1691610046/statics/RESULTADOS_5_mini_sbyizy.png',
  'https://res.cloudinary.com/dqiwrcosz/image/upload/v1691610046/statics/RESULTADOS_6_mini_hcnlut.png',
];
final List<String> resultados = [
  'https://res.cloudinary.com/dqiwrcosz/image/upload/v1691611683/statics/RESULTADOS_3_exrois.jpg',
  'https://res.cloudinary.com/dqiwrcosz/image/upload/v1691611683/statics/RESULTADOS_1_ebfwzw.jpg',
  'https://res.cloudinary.com/dqiwrcosz/image/upload/v1691611682/statics/RESULTADOS_7_ebzjdi.jpg',
  'https://res.cloudinary.com/dqiwrcosz/image/upload/v1691611684/statics/RESULTADOS_8_blg3db.jpg',
  'https://res.cloudinary.com/dqiwrcosz/image/upload/v1691611681/statics/RESULTADOS_9_dzvtc1.jpg',
];

Curso cursoDummy = Curso(
  preorder: false,
  testimonios: [],
  totalEstudiantes: '0',
  duracion: '0',
  estado: true,
  publicado: true,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
  descripcion: '',
  img: '',
  urlImgCert: '',
  baner: '',
  modulos: [
    Modulo(
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      coments: [],
      estado: true,
      img: '',
      video:
          'https://static.vecteezy.com/system/resources/previews/004/844/749/mp4/icon-loading-round-gradient-angle-loop-out-animation-with-dark-background-gradient-line-style-for-game-animation-and-others-free-video.mp4',
      id: 'id',
      nombre: '',
      descripcion: '',
      curso: '',
      usuario: '',
      idDriveFolder: '',
      idDriveZip: '',
    )
  ],
  nombre: 'nombre',
  precio: '',
  usuario: '',
  id: '',
);

Usuario usuarioDummy = Usuario(
    nombre: '',
    apellido: '',
    correo: '',
    img: '',
    telf: '',
    me: '',
    instagram: '',
    facebook: '',
    tiktok: '',
    rol: 'USER_ROLE',
    estado: true,
    google: false,
    cursos: [],
    progress: [],
    confirmCode: '',
    sessionId: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    uid: '',
    certificados: []);

final certDummy = Certificado(
  id: 'id',
  urlPdf: 'urlPdf',
  cursoId: 'cursoId',
  usuarioId: 'usuarioId',
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);
