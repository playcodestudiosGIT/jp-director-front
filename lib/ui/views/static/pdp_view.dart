import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:jpdirector_frontend/providers/auth_provider.dart';
import 'package:jpdirector_frontend/router/router.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';
import '../../../services/navigator_service.dart';


class PdpView extends StatelessWidget {
  const PdpView({super.key});

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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: 612,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                            'Política de Privacidad',
                            style: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.w700, color: azulText),
                          ),
                          Text(
                            'Última actualización 7 de Marzo  de 2023 Desde ON POINT PRODUCTIONS AGENCY LLC tratamos los datos personales con respeto y sensibilidad.',
                            style: GoogleFonts.roboto(fontSize: 10, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Esta política de privacidad junto con el aviso legal, política de cookies, de ventas, términos y condiciones, y cualquier otra política a la que se haga referencia, identifica cómo se recopilan y procesan los datos personales que se reciben en este sitio web.\n\nLa información que se encuentra en este sitio web no está dirigida a niños. Se entenderá por niño lo que la ley de la jurisdicción donde se encuentre así lo defina, en el caso de Estados Unidos de América es alguien menor a 13 años. Si el usuario cree que algún niño ha proporcionado sus datos personales en este sitio web sin el consentimiento de los padres, deberá escribir a hola@jpdirector.net\n\nSi el usuario tiene menos de 13 años, deberá tener la autorización de sus padres o tutores legales para entregar sus datos personales. JPDIRECTOR no tiene manera de comprobar efectivamente la edad de los usuarios, por lo que queda eximida de cualquier responsabilidad, si el usuario no cumple con lo aquí indicado. En JPDIRECTOR cumplimos con la Ley de Protección de la Privacidad en Línea de los Niños de 1998 (“COPPA”).\n\nDatos identificativos del responsable\n\nTal y como recoge la normativa vigente, te informamos que:\n\n',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              '-La denominación social del responsable por este sitio web es: ON POINT PRODUCTIONS AGENCY LLC, Para efectos de este aviso legal y términos de uso, se entenderá en lo adelante como JPDIRECTOR\n\n-Su domicilio social se encuentra en: 4020 N MacArthur Blvd Suite 122, Irving, Texas 75038, Estados Unidos de América.\n\n-Puedes contactarle al Email: hola@jpdirector.net\n\n-Su actividad social es: formación, blogging y asesoría publicitaria para negocios online.\n\n',
                              style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                            ),
                          ),
                          Text(
                            'Datos solicitados en el sitio web y finalidad del tratamiento.\n',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              '-Nombre, apellidos y correo electrónico en los formularios de contacto: para realizar cualquier contacto directo con JPDIRECTOR, ya sea para plantear dudas, comentarios, sugerencias, solicitar un servicio o producto, o cualquier otra información. No suministrar los datos personales mínimos necesarios imposibilitará a JPDIRECTOR de responder a la petición.\n\n-Nombre, correo electrónico: para poder realizar comentarios en el blog del sitio web.\n\n-Nombre, apellidos, dirección, teléfono, correo electrónico, número de identificación fiscal: se solicitará esta información al momento del pago del servicio para procesar todo lo relacionado con el cliente.\n\n-Nombre, teléfono y correo electrónico para newsletter: con el debido consentimiento expreso y voluntario del titular de los datos, se solicitará en el sitio web la información mínima necesaria para enviar un boletín comercial automatizado, donde se informará sobre publicidad, promociones y otra información de los servicios y/o productos ofrecidos por JPDIRECTOR.\n\n-Correo electrónico: se solicitará el correo electrónico para poder acceder al área de cliente, de acuerdo con los datos suministrados al momento de crear la cuenta.\n\n',
                              style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                            ),
                          ),
                          Text(
                            'JPDIRECTOR en todo momento velará porque el uso que se le da al sitio web, a los contenidos, y al tratamiento de los datos personales del usuario, se realicen de la forma más correcta. Para ello, el usuario siempre podrá ejercer sus derechos de acceso, rectificación, limitación, cancelación, portabilidad, olvido u oposición, todo ello en fiel cumplimiento de las directrices de las leyes que rigen la materia, escribiendo a JPDIRECTOR no vende, no venderá datos personales de los usuarios a otras empresas ni terceros.\n\n',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          Text(
                            'JPDIRECTOR compartirá con terceros los datos que posee, solo para cumplir con los servicios contratados por algún usuario, enviar la newsletter, cumplir con exigencias legales o para la administración del sitio web. A este efecto, se proporcionarán los debidos acuerdos de confidencialidad entre las partes.\n\n',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          Text(
                            'Los enlaces a terceros que se puedan encontrar en el sitio web poseen políticas de privacidad ajenas a JPDIRECTOR. El acceso a estos sitios deberá ser responsabilidad del usuario, siendo su responsabilidad conocerlas y su decisión aceptarlas o no.\n\n',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'FORMULARIOS\n\n',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0XFFFFFFFF)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'El sitio web dispone de 4 tipos de formularios:\n\nDe contacto: el usuario, cliente o participante podrá encontrar formularios que facilitarán la comunicación con JPDIRECTOR para plantear dudas, comentarios, solicitar un presupuesto, reservar alguno de los servicios ofrecidos en el sitio web o exigir algún derecho que tenga. No suministrar los datos personales mínimos necesarios imposibilitará a JPDIRECTOR responder a la petición. Este tratamiento se considerará legítimo por ser parte de una diligencia pre-contractual. El servidor del sitio web y del correo electrónico de JPDIRECTOR serán los encargados del tratamiento.\n\nDe publicidad: se solicitará a los usuarios, compradores o participantes su consentimiento expreso y voluntario para entregar a JPDIRECTOR, los mínimos datos necesarios para enviar publicidad e información comercial relacionada con los servicios y/o productos ofrecidos por JPDIRECTOR, para que se agregue a un fichero automatizado de email marketing gestionado por el encargado del tratamiento que se indica más abajo. El tratamiento de los datos personales que se encuentren en esta sección se ha hecho con el consentimiento del titular de los datos.\n\nPara comentarios en el blog: en aras de evitar el spam, mensajes inadecuados, y hacer un correcto seguimiento, se solicitará al usuario su nombre, email y sitio web para identificarlo en los comentarios que desee realizar en las entradas del blog. Estos datos serán visibles para otros usuarios del sitio web. Si no desea que los datos sean visibles por otras personas, deberá comunicarse con JPDIRECTOR  al correo electrónico hola@jpdirector.net. El servidor del sitio web será el encargado del tratamiento y que se realizará con el consentimiento del titular de los datos.\n\nPara procesar la solicitud del servicio: se solicitará a los usuarios, clientes o participantes sus datos para que JPDIRECTOR pueda procesar los servicios solicitados por el cliente. Tratamiento legítimo de datos personales por la relación contractual que existe con el cliente o participante. Los datos serán guardados en el servidor del sitio web.\n\n',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'DERECHOS\n\n',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0XFFFFFFFF)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'El usuario tiene los siguientes derechos relacionados con sus datos personales:\n\nAcceso: el usuario puede dirigirse a JPDIRECTOR para poder saber los datos que se han recopilado de él.\n\nRectificación: el usuario puede en cualquier momento rectificar los datos que haya suministrado a JPDIRECTOR\n\nOposición: siempre que no interrumpa la prestación de un servicio, o una obligación legal que posea JPDIRECTOR, el usuario podrá solicitar el cese al tratamiento de sus datos personales.\n\nSupresión: siempre que no interrumpa la prestación de un servicio, o una obligación legal que posea JPDIRECTOR, el usuario podrá solicitar la eliminación de sus datos personales.\n\nLimitación al tratamiento: siempre que no interrumpa la prestación de un servicio, o una obligación legal que posea JPDIRECTOR, el usuario podrá solicitar que sus datos personales sean tratados de la forma como él los limite, por ejemplo solicitar que no se modifiquen, que se borren o supriman.\n\nPortabilidad: siempre que el usuario así lo solicite y pueda realizarse, podrá solicitar una copia de sus datos personales en un formato estructurado, de uso común, de lectura mecánica e interoperable, o solicitar que se transmita a otro responsable del tratamiento, siempre que el tratamiento se legitime en base al consentimiento o en el marco de la ejecución de un contrato.\n\nNo ser objeto de decisiones individuales automatizadas: en JPDIRECTOR no se realizan perfiles automatizados que puedan afectar significativa o negativamente al usuario. Cualquier decisión que se tome con base a un perfil automatizado, es con la única finalidad de enviar al usuario una información que haya solicitado de acuerdo con sus hábitos de navegación y descarga de materiales en el sitio web.\n\nInformación: el usuario tiene derecho a saber la forma en la cual son tratados sus datos personales.\n\nPara el ejercicio de cualquiera de estos derechos el usuario puede escribir al correo electrónico hola@jpdirector.net\n\n',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'ENCARGADOS DEL TRATAMIENTO\n\n',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0XFFFFFFFF)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'JPDIRECTOR necesita el apoyo de terceros para ofrecer adecuadamente sus servicios y productos, con los cuales celebra los debidos acuerdos de confidencialidad y verifica el cumplimiento de las normativas sobre protección de datos personales.\n\nLos datos suministrados a estos terceros no podrán ser utilizados para otros fines no autorizados por el titular de los datos.\n\nEn cumplimiento de los principios de información y transparencia, se hace saber que estos terceros son:\n\nMailchimp: Utilizada para el email marketing y gestión de clientes Puedes ver más información sobre política de privacidad en https://mailchimp.com/about/security/\n\n•Hostgator: Proveedor de Hosting (almacenamiento web). Puede ver su política de privacidad en https://es.wix.com/manage/privacy-security-hub\n\n•Facebook: Herramienta utilizada como red social y a los fines de conectarse con el titular de los datos. El servicio es prestado por la empresa Facebook Ireland Ltd., sus servidores están en Estados Unidos. Han adoptado cláusulas tipo de procesamiento de datos aprobadas por la Comisión Europea que pueden ser consultadas en: https://www.facebook.com/legal/terms/dataprocessing. . Puede consultarse su política de provacidad en https://www.facebook.com/business/gdpr. Con esta herramienta también se maneja la publicidad que se pueda realizar en WhatsApp y/o Instagram, así como el análisis de datos y estadísticas para una posible segmentación de la publicidad.\n\n•Google: sistema de publicidad patrocinada (ADS), Servicio de análisis web, para ver las estadísticas del uso del sitio web (Analytics) y sistema de gestión de etiquetas (Tag Manager).Estos servicios son prestados por la empresa Google LLC, ubicada en Mountain View, California, Estados Unidos de América. Han adoptado cláusulas tipo de procesamiento de datos aprobadas por la Comisión Europea que pueden ser consultadas en: https://cloud.google.com/security/gdpr/resource-center. Si desea obtener más información sobre su política de privacidad puede consultar: https://policies.google.com/privacy\n\n•Instagram: Red social y aplicación para subir fotos y vídeos cuyo propietario es la empresa Facebook Inc., que está ubicada en 1601 Willow Road Menlo Park, CA 94025, Estados Unidos de América. En caso de estar fuera de los Estados Unidos de América o Canadá, la entidad de control de datos responsable de la información es Facebook Ireland Ltd., que se encuentra ubicada en 4 Grand Canal Square Grand Canal Harbour, Dublín 2, Irlanda. Han adoptado cláusulas tipo de procesamiento de datos aprobadas por la Comisión Europea que pueden ser consultadas en: https://www.facebook.com/legal/terms/dataprocessing. Para obtener más información sobre la política de privacidad ingresa en: https://help.instagram.com/155833707900388\n\n•Linkedin: Red social orientada a las empresas, a los negocios y el empleo. Puede ser contactada en https://www.linkedin.com/help/linkedin?lang=es  y su política de privacidad puede observarse en https://www.linkedin.com/legal/privacy-policy\n\n•PayPal (Europe) S.à r.l. et Cie, S.C.A.: empresa utilizada para gestionar los pagos mediante tarjeta de débito y  crédito en el sitio web. Ubicada en 22-24 Boulevard Royal L-2449, Luxemburgo. Para más información puede visitar https://www.paypal.com/es/webapps/mpp/ua/privacy-full?locale.x=es_ES\n\n•Pixel de Facebook: herramienta de análisis para publicidad, utilizado para conocer las acciones de los titulares de los datos en este sitio web. Este servicio es proporcionado por Facebook, Inc., que está ubicada en 1601 Willow Road Menlo Park, CA 94025, Estados Unidos de América. En caso de estar fuera de los Estados Unidos de América o Canadá, la entidad de control de datos responsable de la información es Facebook Ireland Ltd., que se encuentra ubicada en 4 Grand Canal Square Grand Canal Harbour, Dublín 2, Irlanda. Han adoptado cláusulas tipo de procesamiento de datos aprobadas por la Comisión Europea que pueden ser consultadas en: https://www.facebook.com/legal/terms/dataprocessing. Para obtener más información sobre la política de privacidad ingresa en  https://www.facebook.com/privacy/explanation\n\n•Stripe: herramienta utilizada para gestionar los pagos mediante tarjeta de débito y crédito en el sitio web. Han adoptado cláusulas tipo de procesamiento de datos aprobadas por la Comisión Europea que pueden ser consultadas en: https://es.wix.com/manage/privacy-security-hub.\n\n•TikTok: Red social y aplicación para subir vídeos cuyo propietario es la empresa TikTok Technology Limited ubicada en 10 Earlsfort Terrace, Dublín, D02 T380, Irlanda. Para los usuarios del Reino Unido: TikTok Information Technologies UK Limited, WeWork, 125 Kingsway, Londres, WC2B 6NH, Reino Unido. Para obtener más información sobre la política de privacidad ingresa en: https://www.tiktok.com/legal/privacy-policy?lang=es\n\n•Twitter: Red social con sede en San Francisco, California, con filiales en San Antonio y Boston en Estados Unidos, prestado por la empresa Twitter, Inc. Han adoptado cláusulas tipo de procesamiento de datos aprobadas por la Comisión Europea que pueden ser consultadas en: https://gdpr.twitter.com/. Puede ser contactada en https://help.twitter.com/en/contact-us y su política de privacidad puede observarse en https://twitter.com/es/privacy\n\n•Vimeo: plataforma creada para la disposición de videos. Este servicio está a cargo de la empresa Vimeo, Inc., ubicada en Estados Unidos y que ha adoptado cláusulas tipo de procesamiento de datos aprobadas por la Comisión Europea. Para más información sobre su política de privacidad puede visitar https://vimeo.com/privacy\n\n•WhatsApp: Herramienta utilizada para la comunicación con los usuarios, compradores, clientes y participantes a través de la empresa WhatsApp Ireland Limited (para los que se encuentran ubicados en Europa), puede contactarse a través del enlace https://www.whatsapp.com/contact/?subject=messenger y su política de privacidad puede observarse en https://www.whatsapp.com/legal?eea=1#privacy-policyación sobre su política de privacidade, consulte https://wpengine.com/legal/privacy/\n\n•Zoom: herramienta utilizada para videoconferencias. Este servicio está a cargo de la empresa Zoom Video Communications, Inc., ubicada en Estados Unidos de América, ha adoptado cláusulas tipo de procesamiento de datos aprobadas por la Comisión Europea que pueden ser consultadas en: https://zoom.us/gdpr. Si desea obtener más información sobre su política de privacidad puede consultar: https://zoom.us/privacy\n\nEn casos puntales JPDIRECTOR  podrá utilizar aplicaciones o herramientas que no hayan sido incluidas o nombradas en este listado, lo anterior por ser una mejor opción que coadyuve a la realización de una determinada tarea; si esto sucediera JPDIRECTOR notificará de esta situación a sus usuarios, clientes o participantes según fuere el caso.\n\n',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'POLÍTICAS RELACIONADAS CON LA NEWSLETTER\n\n',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0XFFFFFFFF)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Estas políticas se entenderán en todo momento como parte complementaria de los términos y condiciones expuestos en el sitio web, siendo ambos de igual aplicación al momento de una controversia. La política de privacidad y de propiedad intelectual aplicada será la misma que se expone en los términos y condiciones del sitio web.\n\nSe entenderá como “newsletter” al boletín digital que JPDIRECTOR realiza de forma periódica y que hace llegar a sus suscriptores a través de un proveedor de servicios de correo electrónico externo, al cual el usuario se ha suscrito de manera voluntaria.\n\nJPDIRECTOR no está en la obligación de enviar en períodos de tiempo definidos la newsletter, por lo que es totalmente libre de hacerlo cuando lo estime conveniente. El usuario podrá en todo momento ejercer sus derechos de acceso, rectificación, cancelación u oposición siguiendo las instrucciones que encontrará en el pie de página de la newsletter.\n\nEl usuario no deberá compartir su contenido con terceros, ya que esto violaría los derechos de autor de JPDIRECTOR. El único canal de distribución posible es el administrado y/o autorizado por JPDIRECTOR.\n\nJPDIRECTOR no se hará responsable por el contenido de terceros expuesto en la newsletter, cualquier controversia que surja deberá ser tratada directamente con la persona o empresa de la cual se hace mención.\n\nTodo el material que se expone en la newsletter está protegido por derechos de autor a favor de JPDIRECTOR, y en el caso de pertenecer a terceros, se entenderá que JPDIRECTOR tiene la debida autorización para utilizarlo como se haya convenido con el autor.\n\n',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'INTERÉS LEGÍTIMO\n\n',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0XFFFFFFFF)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Cuando se realice un lanzamiento de productos o servicios nuevos, o promociones especiales por tiempo determinado, se recogerá el nombre y correo electrónico de los usuarios del sitio web mediante un formulario. Este tratamiento de datos personales se hará con base en el interés legítimo que posee JPDIRECTOR para aumentar sus ventas, dar a conocer sus productos o servicios y cumplir con la finalidad de enviarle al titular de los datos la información prometida en el sitio web.\n\nEste tratamiento será realizado mientras perdure el interés legítimo de JPDIRECTOR. Para aumentar las garantías y respeto a la privacidad, se ofrece la posibilidad de la exclusión voluntaria de esta publicidad mediante un método fácil y de ejecución inmediata, ubicado en la parte inferior de los correos electrónicos que reciba.\n\nPara saber si este interés es proporcionado y respetuoso con los derechos de los titulares de los datos, se ha realizado una ponderación que puede ser solicitada en cualquier momento escribiendo al correo electrónico hola@jpdirector.net\n\n',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'DURACIÓN DEL TRATAMIENTO\n\n',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0XFFFFFFFF)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'En el caso de los datos personales suministrados para facturación y compra de productos o servicios, serán guardados por el tiempo legalmente aplicable.\n\nEn el caso de los datos personales suministrados para boletines comerciales electrónicos y comentarios en el blog, será por el tiempo que el titular de los datos desee permanecer en la lista de suscripción, por lo que podrá darse de baja en el momento que así lo desee, de forma automática como se indica en cada boletín, o escribiendo al soporte@quieroads.com\n\n',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0XFFFFFFFF).withOpacity(0.6)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'RESIDENTES EN CALIFORNIA, ESTADOS UNIDOS\n\n',
                            style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0XFFFFFFFF)),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            'JPDIRECTOR cumple con la Ley de Privacidad del Consumidor de California de 2018 (“CCPA”). Los residentes en California tienen derecho a solicitar que JPDIRECTOR  revele qué información personal ha recopilado, utilizado, divulgado y vendido durante el período de 12 meses anterior a la recepción de dicha solicitud. Para ejercer este derecho, así como el de eliminación u oposición al tratamiento de sus datos, el usuario deberá escribir a hola@jpdirector.net\n\n',
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
                              'This site is not part of Meta website or Meta Inc.\nThis site is not part of the Tik Tok website or Tik Tok inc.\nThis site is NOT endorsed by Meta or Tik Tok in any way.\nMeta is a trademark of Meta and Tik Tok is a trademark of Tik Tok Inc',
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
