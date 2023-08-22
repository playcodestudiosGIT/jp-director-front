import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jpdirector_frontend/constant.dart';
import 'package:jpdirector_frontend/providers/auth_provider.dart';
import 'package:jpdirector_frontend/router/router.dart';
import 'package:jpdirector_frontend/services/navigator_service.dart';
import 'package:provider/provider.dart';


class TycView extends StatelessWidget {
  const TycView({super.key});

  @override
  Widget build(BuildContext context) {
    final wScreen = MediaQuery.of(context).size.width;
    final authProvider = Provider.of<AuthProvider>(context);
    return Container(
        margin: EdgeInsets.only(
          left: wScreen < 670 && authProvider.authStatus == AuthStatus.authenticated ? 30 : 0,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: bgColor,
          image:
              DecorationImage(image: bgContacto, opacity: 0.2, alignment: (wScreen < 700) ? const Alignment(0.3, 0) : Alignment.center, fit: BoxFit.cover),
          backgroundBlendMode: BlendMode.darken,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (wScreen < 450) const SizedBox(height: 80),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: 612,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      color: bgColor.withOpacity(0.7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 100,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: blancoText,
                                ),
                                onPressed: () {
                                  NavigatorService.navigateTo('/contacto');
                                },
                              )
                            ],
                          ),
                          const SizedBox(height: 90),
                          Text(
                            'Aviso Legal y Términos de Uso del Sitio',
                            style: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.w700, color: azulText),
                          ),
                          Text(
                            'Última actualización 7 de Marzo de 2023',
                            style: GoogleFonts.roboto(fontSize: 10, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            '1. AVISO LEGAL Y TÉRMINOS DE USO',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Puedo garantizarte que te encuentras en un espacio 100 % seguro, para ello debes saber:',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '1.1. DATOS IDENTIFICATIVOS DEL RESPONSABLE',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Tal y como recoge la normativa vigente, le informo que:',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              '-Mi denominación social es: ON POINT PRODUCTIONS AGENCY LLC',
                              style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              '-Mi domicilio social se encuentra en 4020 N MacArthur Blvd Suite 122, Irving, Texas 75038, Estados Unidos de América.',
                              style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              '-Email: hola@jpdirector.net',
                              style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              '-Mi actividad social es: Publicidad',
                              style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '1.2. FINALIDAD DE LA PÁGINA WEB.',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Los servicios prestados por el responsable de la página web son los siguientes:',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              '-La venta de formación y servicios sobre negocios online.',
                              style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              '-Gestionar la lista de suscriptores y usuarios adscritos a la web.',
                              style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              '-Dirigir su red de afiliados y comerciantes así como la gestión de pagos de los mismos.',
                              style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '1.3. USUARIOS:',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'El acceso y/o uso de este sitio web atribuye la condición de USUARIO, que acepta, desde dicho acceso y/o uso, los presentes términos de uso, no obstante, por el mero uso de la página web no significa el inicio de relación laboral/comercial alguna',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '1.4. USO DEL SITIO WEB Y CAPTURA DE INFORMACIÓN:',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '1.4.1 USO DEL SITIO WEB',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          Text(
                            'La página web https://quieroads.com/ en adelante (LA WEB) proporciona el acceso a artículos, informaciones, servicios y datos (en adelante, “los contenidos”) propiedad de ON POINT PRODUCTIONS AGENCY LLC. El USUARIO asume la responsabilidad del uso de la web.\nEl USUARIO se compromete a hacer un uso adecuado de los contenidos que ofrece a través de su web y con carácter enunciativo pero no limitativo, a no emplearlos para:\n(a) incurrir en actividades ilícitas, ilegales o contrarias a la buena fe y al orden público;\n(b) difundir contenidos o propaganda de carácter racista, xenófobo, pornográfico-ilegal, de apología del terrorismo o atentatorio contra los derechos humanos;\n(c) provocar daños en los sistemas físicos y lógicos de la web, de sus proveedores o de terceras personas, introducir o difundir en la red virus informáticos o cualesquiera otros sistemas físicos o lógicos que sean susceptibles de provocar los daños anteriormente mencionados;\n(d) intentar acceder y, en su caso, utilizar las cuentas de correo electrónico de otros usuarios y modificar o manipular sus mensajes.\nON POINT PRODUCTIONS AGENCY LLC se reserva el derecho de retirar todos aquellos comentarios y aportaciones que vulneren el respeto a la dignidad de la persona, que sean discriminatorios, xenófobos, racistas, pornográficos, que atenten contra la juventud o la infancia, el orden o la seguridad pública o que, a su juicio, no resultaran adecuados para su publicación.\nEn cualquier caso, ON POINT PRODUCTIONS AGENCY LLC no será responsable de las opiniones vertidas por los usuarios a través de cualquier herramientas de participación que puedan crearse, conforme a lo previsto en la normativa de aplicación.',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '1.4.2 CAPTURA DE INFORMACIÓN',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              '-Formulario de contacto, donde el USUARIO deberá rellenar el campo de correo electrónico, asunto y nombre.',
                              style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              '-Formulario de suscripción, rellenando el USUARIO los campos necesarios para la suscripción a la web con los campos de nombre, email y número de teléfono.',
                              style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              '-Formulario de venta, rellenando el USUARIO los campos necesarios para la venta con los campos de nombre, email, dirección, teléfono y DNI',
                              style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              '-Cookies de rastreo, conforme a las siguientes reglas',
                              style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              '-Navegación y Dirección IP: Al navegar por esta web, el usuario facilita de forma automática al servidor de la web información relativa a tu dirección IP, fecha y hora de acceso, el hipervínculo que le ha reenviado a éstas, tu sistema operativo y el navegador utilizado.',
                              style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                            ),
                          ),
                          Text(
                            'A pesar de lo anterior, los usuarios podrán darse de baja en cualquier momento de los servicios prestados por ON POINT PRODUCTIONS AGENCY LLC o datos aportados por el USUARIO dando cumplimiento a la normativa vigente sobre Protección de Datos. Asimismo, tanto al suscribirse a esta página web, como al realizar algún comentario o realizar una compra en cualquiera de sus páginas y/o entradas, el usuario consiente:',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              '1. El tratamiento de sus datos personales en el entorno de Wix conforme a sus políticas de privacidad.',
                              style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              '2. El acceso de ON POINT PRODUCTIONS AGENCY LLC a los datos que, de acuerdo con la infraestructura de Wix, necesite el usuario aportar bien para la suscripción a la web bien para cualquier consulta mediante el formulario de contacto.',
                              style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                            ),
                          ),
                          Text(
                            'Asimismo, informamos que la información de nuestros usuarios está protegida de acuerdo a nuestra POLÍTICA DE PRIVACIDAD',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          Text(
                            'Al activar una suscripción, formulario de contacto o comentario, el usuario comprende y acepta que:',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          Text(
                            'Desde el momento en que efectúa su suscripción o accedes a algún servicio de pago,ON POINT PRODUCTIONS AGENCY LLC tiene acceso',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          Text(
                            'a: Nombre, y email, o demás datos necesarios conformando un fichero con el nombre de “USUARIOS DE LA WEB Y SUSCRIPTORES” o en el caso de realizar alguna compra, será suscrito al fichero de “CLIENTES Y/O PROVEEDORES” teniendo acceso a datos de nombre, apellidos, email, dni, teléfono y domicilio completo.',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          Text(
                            'En todo caso ON POINT PRODUCTIONS AGENCY LLC se reserva el derecho de modificar, en cualquier momento y sin necesidad de previo aviso, la presentación y configuración de la web https://quieroads.com/ como el presente aviso legal.',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '2. PROPIEDAD INTELECTUAL E INDUSTRIAL:',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'ON POINT PRODUCTIONS AGENCY LLC por sí o como cesionario, es titular de todos los derechos de propiedad intelectual e industrial de su página web, así como de los elementos contenidos en la misma (a título enunciativo, imágenes, sonido, audio, vídeo, software o textos; marcas o logotipos, combinaciones de colores, estructura y diseño, selección de materiales usados, programas de ordenador necesarios para su funcionamiento, acceso y uso, etc.), titularidad de ON POINT PRODUCTIONS AGENCY LLC o bien de sus licenciantes. Todos los derechos reservados.\nCualquier uso no autorizado previamente por ON POINT PRODUCTIONS AGENCY LLC será considerado un incumplimiento grave de los derechos de propiedad intelectual o industrial del autor.\nQuedan expresamente prohibidas la reproducción, la distribución y la comunicación pública, incluida su modalidad de puesta a disposición, de la totalidad o parte de los contenidos de esta página web, con fines comerciales, en cualquier soporte y por cualquier medio técnico, sin la autorización de ON POINT PRODUCTIONS AGENCY LLC.\nEl USUARIO se compromete a respetar los derechos de Propiedad Intelectual e Industrial titularidad de ON POINT PRODUCTIONS AGENCY LLC. Podrá visualizar únicamente los elementos de la web sin posibilidad de imprimirlos, copiarlos o almacenarlos en el disco duro de su ordenador o en cualquier otro soporte físico. El USUARIO deberá abstenerse de suprimir, alterar, eludir o manipular cualquier dispositivo de protección o sistema de seguridad que estuviera instalado en las páginas de ON POINT PRODUCTIONS AGENCY LLC.\nQueda terminantemente prohibido compartir la licencia para uso con más personas, cada licencia es personal e intransferible reservándonos cuantas acciones civiles y penales nos asistan en aras de salvaguardar nuestros derechos, todo ello bajo apercibimiento de incurrir en un delito contra la propiedad intelectual.',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '3. EXCLUSIÓN DE GARANTÍAS Y RESPONSABILIDAD',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'ON POINT PRODUCTIONS AGENCY LLC no se hace responsable, en ningún caso, de los daños y perjuicios de cualquier naturaleza que pudieran ocasionar, a título enunciativo: por errores u omisiones en los contenidos, por falta de disponibilidad del sitio web, – el cual realizará paradas periódicas por mantenimientos técnicos – así como por la transmisión de virus o programas maliciosos o lesivos en los contenidos, a pesar de haber adoptado todas las medidas tecnológicas necesarias para evitarlo.',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '4. MODIFICACIONES',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'ON POINT PRODUCTIONS AGENCY LLC se reserva el derecho de efectuar sin previo aviso las modificaciones que considere oportunas en su web, pudiendo cambiar, suprimir o añadir tanto los contenidos y servicios que se presten a través de la misma como la forma en la que éstos aparezcan presentados o localizados en su web.',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '5. POLÍTICA DE ENLACES',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Las personas o entidades que pretendan realizar o realicen un hiperenlace desde una página web de otro portal de Internet a la web de ON POINT PRODUCTIONS AGENCY LLC',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          Text(
                            'deberá someterse las siguientes condicionesÑ',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              '-No se permite la reproducción total o parcial de ninguno de los servicios ni contenidos del sitio web sin la previa autorización expresa de ON POINT PRODUCTIONS AGENCY LLC.',
                              style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              '-No se establecerán deep-links ni enlaces IMG o de imagen, ni frames con la web de ON POINT PRODUCTIONS AGENCY LLC sin su previa autorización expresa.',
                              style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              '-No se establecerá ninguna manifestación falsa, inexacta o incorrecta sobre la web de ON POINT PRODUCTIONS AGENCY LLC ni sobre los servicios o contenidos de la misma. Salvo aquellos signos que formen parte del hipervínculo, la página web en la que se establezca no contendrá ninguna marca, nombre comercial, rótulo de establecimiento, denominación, logotipo, eslogan u otros signos distintivos pertenecientes a ON POINT PRODUCTIONS AGENCY LLC salvo autorización expresa de éste.',
                              style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'El establecimiento del hipervínculo no implicará la existencia de relaciones entre ON POINT PRODUCTIONS AGENCY LLC y el titular de la página web o del portal desde el cual se realice, ni el conocimiento y aceptación de ON POINT PRODUCTIONS AGENCY LLC de los servicios y contenidos ofrecidos en dicha página web o portal.',
                              style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              '-ON POINT PRODUCTIONS AGENCY LLC no será responsable de los contenidos o servicios puestos a disposición del público en la página web o portal desde el cual se realice el hipervínculo, ni de las informaciones y manifestaciones incluidas en los mismos.',
                              style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              '-El sitio web de ON POINT PRODUCTIONS AGENCY LLC puede poner a disposición del usuario conexiones y enlaces a otros sitios web gestionados y controlados por terceros. Dichos enlaces tienen como exclusiva función, la de facilitar a los usuarios la búsqueda de información, contenidos y servicios en Internet, sin que en ningún caso pueda considerarse una sugerencia, recomendación o invitación para la visita de los mismos.',
                              style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              '-ON POINT PRODUCTIONS AGENCY LLC no comercializa, ni dirige, ni controla previamente, ni hace propios los contenidos, servicios, informaciones y manifestaciones disponibles en dichos sitios web.',
                              style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              '-ON POINT PRODUCTIONS AGENCY LLC no asume ningún tipo de responsabilidad, ni siquiera de forma indirecta o subsidiaria, por los daños y perjuicios de toda clase que pudieran derivarse del acceso, mantenimiento, uso, calidad, licitud, fiabilidad y utilidad de los contenidos, informaciones, comunicaciones, opiniones, manifestaciones, productos y servicios existentes u ofrecidos en los sitios web no gestionados por ON POINT PRODUCTIONS AGENCY LLC y que resulten accesibles a través de ON POINT PRODUCTIONS AGENCY LLC.',
                              style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '6. DERECHO DE EXCLUSIÓN',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'ON POINT PRODUCTIONS AGENCY LLC se reserva el derecho a denegar o retirar el acceso al portal y/o los servicios ofrecidos sin necesidad de preaviso, a instancia propia o de un tercero, a aquellos usuarios que incumplan las presentes Condiciones Generales de Uso.',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '7. GENERALIDADES',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'ON POINT PRODUCTIONS AGENCY LLC perseguirá el incumplimiento de las presentes condiciones así como cualquier utilización indebida de su web ejerciendo todas las acciones civiles y penales que le puedan corresponder en derecho.',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '8. MODIFICACIÓN DE LAS PRESENTES CONDICIONES Y DURACIÓN',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'ON POINT PRODUCTIONS AGENCY LLC podrá modificar en cualquier momento las condiciones aquí determinadas, siendo debidamente publicadas como aquí aparecen. La vigencia de las citadas condiciones irá en función de su exposición y estarán vigentes hasta que sean modificadas por otras debidamente publicadas.',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '9. RECLAMACIONES Y DUDAS',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'ON POINT PRODUCTIONS AGENCY LLC informa que existen hojas de reclamación a disposición de usuarios y clientes pudiendo remitir un correo a hola@jpdirector.net  indicando su nombre y apellidos, el servicio o producto adquirido y exponiendo los motivos de su reclamación.',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          Text(
                            'También puede dirigir su reclamación por correo postal dirigido a: ON POINT PRODUCTIONS AGENCY LLC, 4020 N MacArthur Blvd Suite 122, Irving, Texas 75038, Estados Unidos de América.',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '10. CONDICIONES DE VENTA',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Las presentes condiciones generales tienen por objeto regular expresamente las condiciones aplicables a los procesos de contratación llevados a cabo por los usuarios “Cliente” de los cursos online y servicios ofrecidos por parte de ON POINT PRODUCTIONS AGENCY LLC a través de su sitio web.',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          Text(
                            'Estas condiciones permanecerán en vigor y serán válidas durante todo el tiempo que estén accesible a través del sitio web, todo ello sin perjuicio de que ON POINT PRODUCTIONS AGENCY LLC se reserva el derecho a modificar, sin previo aviso, las condiciones generales así como cualquiera de los textos legales que se encuentren en dicho sitio web. En todo caso, el acceso a la Web tras su modificación, inclusión y/o sustitución, implica la aceptación de los mismos por parte del usuario.',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          Text(
                            'El cliente se encuentra sujeto a las condiciones generales vigentes en cada uno de los momentos de realizar la contratación correspondiente, no siendo posible la contratación de servicio alguno sin la previa aceptación de las presentes condiciones generales de contratación.',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          Text(
                            'En la presente web podrá adquirir productos o servicios reflejados en cada página de ventas.',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          Text(
                            'Para proceder al pago, el cliente tiene a su disposición los siguientes medios:',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          Text(
                            'Visa/Mastercard/American Express; el usuario deberá proporcionar el nombre del titular de la tarjeta, el número, la fecha de caducidad y el CVV.',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          Text(
                            'Toda la información será tramitada a través de una pasarela de pagos externa a ON POINT PRODUCTIONS AGENCY LLC ubicada en Stripe.com, pudiendo obtener más información visitando su página web https://stripe.com/privacy - https://www.paypal.com/us/home.',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          Text(
                            'Para proceder al pago, normalmente serás redirigido a un carrito donde se te solicitarán los datos necesarios a través de plataformas de terceros como pueden ser Stripe o Paypal.',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '11. LEY APLICABLE Y JURISDICCIÓN',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'La relación entre ON POINT PRODUCTIONS AGENCY LLC y el CLIENTE se regirá por la normativa de Estados Unidos y cualquier controversia se someterá a los Juzgados y tribunales del Estado de Florida, salvo que la Ley aplicable disponga otra cosa.',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            '12. CAUSAS DE DISOLUCIÓN DEL CONTRATO',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'La disolución del contrato de servicios puede ocurrir en cualquier momento por cualquiera de las dos partes.\nNo estás obligado a condiciones de permanencia con ON POINT PRODUCTIONS AGENCY LLC.\nON POINT PRODUCTIONS AGENCY LLC puede terminar o suspender cualquier y todos los Servicios contratados inmediatamente, sin previo aviso o responsabilidad, en caso de que tú no cumplas con las condiciones aquí expuestas.\nA la disolución del contrato, tu derecho a utilizar los Servicios cesará inmediatamente.\nSerán causas de disolución de contrato:',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'La falsedad, en todo o en parte, de los datos suministrados en el proceso de contratación de cualquier servicio.',
                              style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Alterar, eludir, realizar ingeniería inversa, descompilar, desmontar o alterar de ningún modo de la tecnología de seguridad aportada por ON POINT PRODUCTIONS AGENCY LLC.',
                              style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Los casos de abuso de los servicios de soporte por el requerimiento de más horas de las establecidas en el contrato.',
                              style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Opiniones falsas e infundadas con ánimo de desprestigiar al titular de los productos o servicios adquiridos.',
                              style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Cualquier incumplimiento establecido a lo largo de las condiciones.',
                              style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                            ),
                          ),
                          Text(
                            'La disolución implica la pérdida de sus derechos sobre el servicio contratado.',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(8),
                      width: double.infinity,
                      color: bgColor.withOpacity(0.8),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: wScreen < 500 ? 0 : 8,
                            ),
                            child: Text(
                              'JP DIRECTOR | QUIERO ADS',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: blancoText,
                                fontWeight: FontWeight.w700,
                                fontSize: wScreen < 500 ? 10 : 10,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: wScreen < 500 ? 0 : 8),
                            child: Text(
                              'TODOS LOS DERECHOS RESERVADOS © 2023',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: blancoText,
                                fontWeight: FontWeight.w700,
                                fontSize: wScreen < 500 ? 10 : 10,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: wScreen < 500 ? 8 : 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () => NavigatorService.navigateTo(Flurorouter.pdpRoute),
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Text(
                                      'POLÍTICAS DE PRIVACIDAD',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: azulText,
                                        fontWeight: FontWeight.w700,
                                        fontSize: wScreen < 500 ? 10 : 10,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  ' -  ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: blancoText,
                                    fontWeight: FontWeight.w700,
                                    fontSize: wScreen < 500 ? 10 : 10,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => NavigatorService.navigateTo(Flurorouter.tycRoute),
                                  child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Text(
                                      'TÉRMINOS Y CONDICIONES',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: azulText,
                                        fontWeight: FontWeight.w700,
                                        fontSize: wScreen < 500 ? 10 : 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: wScreen < 500 ? 8 : 8),
                            child: Text(
                              'This site is not part of Meta website or Meta Inc.\nThis site is not part of the Tik Tok website or Tik Tok inc.\nThis site is NOT endorsed by Meta or Tik Tok in any way.\n\nMeta is a trademark of Meta and Tik Tok is a trademark of Tik Tok Inc',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: blancoText.withOpacity(0.6),
                                fontWeight: FontWeight.w300,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
