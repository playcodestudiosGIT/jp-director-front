// import 'dart:html'L
import 'package:flutter/material.dart';
import 'package:jp_director/models/certificado.dart';

import 'models/curso.dart';
import 'models/modulo.dart';
import 'models/usuario_model.dart';

const String pkStripe = 'pk_test_51NCcdnGhOVgj1hOFzlJboe8kgzH1VX1rvTVqG8PiC5jLTrGXs1bQzwFdXgCJO3y8Ba8dWzaq7VqwtP3O6ph2gISg001gyqcNha';
const String skStripe = 'sk_test_51NCcdnGhOVgj1hOFz0oLPJyzTrmV6vHGVP6wLuZ5cz9rOqGKP9O8CqHBwTBPusa4mI5xz1BHKRORu1GiwVWM1CfV00F85lS9Jb';

const Color bgColor = Color(0xff00041C);
const Color blancoText = Color(0xFFffffff);
const Color azulText = Color(0xff15E0FB);
const Color verdeBorde = Color(0xff9BCB6C);
const NetworkImage logoIso = NetworkImage('https://res.cloudinary.com/dqiwrcosz/image/upload/v1691274003/logojp_iso_vum6rm.png');
const NetworkImage logoGrande = NetworkImage('https://res.cloudinary.com/dyxt5lhzw/image/upload/v1680575762/logogrande_s3thla.png');
const NetworkImage logoJp = NetworkImage('https://res.cloudinary.com/dyxt5lhzw/image/upload/v1680575763/logojp_ykatas.png');
const NetworkImage planetaI = NetworkImage('https://res.cloudinary.com/dyxt5lhzw/image/upload/v1680575459/planetai_pqplnw.png');
const NetworkImage planetaM = NetworkImage('https://res.cloudinary.com/dyxt5lhzw/image/upload/v1680575890/planetam_uhn6yw.png');
const NetworkImage planetaF = NetworkImage('https://res.cloudinary.com/dyxt5lhzw/image/upload/v1680575763/planetaf_u3oxbf.png');
const NetworkImage circulo = NetworkImage('https://res.cloudinary.com/dyxt5lhzw/image/upload/v1680575764/circulo_mvprhd.png');
const NetworkImage baseGif = NetworkImage('https://res.cloudinary.com/dyxt5lhzw/image/upload/v1680575766/base_pphf0f.gif');
const NetworkImage rocketGif = NetworkImage('https://res.cloudinary.com/dyxt5lhzw/image/upload/v1680631413/rocket_aaqsxb.gif');
const NetworkImage rocketInd = NetworkImage('https://res.cloudinary.com/dyxt5lhzw/image/upload/v1680631413/rocket_aaqsxb.gif');
const NetworkImage ufoGif = NetworkImage('https://res.cloudinary.com/dyxt5lhzw/image/upload/v1680631408/ufo_k0zbvx.gif');
const NetworkImage bgContacto = NetworkImage('https://res.cloudinary.com/dyxt5lhzw/image/upload/v1680575765/bgcontact_lxwbfo.png');
const NetworkImage bgEncargado = NetworkImage('https://res.cloudinary.com/dyxt5lhzw/image/upload/v1680575765/encargadobg_tzl7ci.png');
const NetworkImage bgMentoria = NetworkImage('https://res.cloudinary.com/dyxt5lhzw/image/upload/v1680575763/mentoriabg_gdiec1.png');
const NetworkImage bgAsesoria = NetworkImage('https://res.cloudinary.com/dyxt5lhzw/image/upload/v1680651215/asesoriabg_tewxpf.png');
const NetworkImage bgConferencia = NetworkImage('https://res.cloudinary.com/dyxt5lhzw/image/upload/v1680575765/conferenciasbg_cr2xtz.png');
const NetworkImage iconInsta = NetworkImage('https://res.cloudinary.com/dyxt5lhzw/image/upload/v1680651763/iconInsta_p5m2nu.png');
const NetworkImage iconFb = NetworkImage('https://res.cloudinary.com/dyxt5lhzw/image/upload/v1680652723/logo-facebook_my0xq6.png');
const NetworkImage iconTiktok = NetworkImage('https://res.cloudinary.com/dyxt5lhzw/image/upload/v1680575762/logo-tiktok_fw3bfo.png');
const NetworkImage bgHome = NetworkImage('https://res.cloudinary.com/dyxt5lhzw/image/upload/v1680575764/bghome_tnmrqj.png');
const NetworkImage adsCircle = NetworkImage('https://res.cloudinary.com/dyxt5lhzw/image/upload/v1680575763/ADS_h72ur3.png');
const NetworkImage arrDown = NetworkImage('https://res.cloudinary.com/dyxt5lhzw/image/upload/v1680575763/arr-down_ywdc5o.png');
const String noimage = 'https://res.cloudinary.com/dyxt5lhzw/image/upload/v1686363837/noimage_mpl4wc.jpg';

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
