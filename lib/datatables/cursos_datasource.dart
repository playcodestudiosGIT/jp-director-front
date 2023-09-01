import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jp_director/providers/all_cursos_provider.dart';
import 'package:jp_director/ui/shared/labels/dashboard_label.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import '../generated/l10n.dart';
import '../models/curso.dart';
import '../services/notificacion_service.dart';
import '../ui/shared/botones/custom_button.dart';
import '../ui/shared/modals/cursos_modal.dart';
import '../ui/shared/modals/new_module_dialog.dart';
import '../ui/shared/modals/new_testimonio_dialog.dart';
import '../ui/shared/widgets/square_module.dart';

class CursosDTS extends DataTableSource {
  final BuildContext context;
  final int length;

  CursosDTS(this.context, this.length);

  @override
  DataRow getRow(int index) {
    final appLocal = AppLocalizations.of(context);
    List<Curso> cursos = Provider.of<AllCursosProvider>(context).allCursos;
    final curso = cursos[index];

    // final modulos = curso.modulos.where((modulo) => modulo.estado).toList();

    return DataRow(cells: [
      DataCell(Center(
        child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
            child: Image(
              image: NetworkImage(curso.img),
              fit: BoxFit.cover,
            )),
      )),
      DataCell(SizedBox(
        width: 250,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    splashRadius: 15,
                    onPressed: () async {
                      await Provider.of<AllCursosProvider>(context, listen: false).getCursoModal(curso.id);
                      if (context.mounted) {
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return CursosModal(uid: curso.id);
                            });
                      }
                    },
                    icon: const Icon(
                      Icons.edit,
                      size: 15,
                      color: azulText,
                    )),
              ],
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Text(
                    curso.nombre.toUpperCase(),
                    style: DashboardLabel.h4,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$ ${curso.precio}.00 usd',
                    style: DashboardLabel.mini,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    curso.descripcion,
                    style: DashboardLabel.mini.copyWith(color: blancoText.withOpacity(0.5)),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'ID: ${curso.id}',
                        style: DashboardLabel.mini,
                      ),
                      IconButton(
                          splashRadius: 16,
                          onPressed: () async {
                            await Clipboard.setData(ClipboardData(text: curso.id));
                            // copied successfully
                          },
                          icon: Icon(
                            Icons.copy_outlined,
                            size: 16,
                            color: Colors.white.withOpacity(0.5),
                          ))
                    ],
                  ),
                  // const Spacer(),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        appLocal.duracion2puntos,
                        style: DashboardLabel.mini,
                      ),
                      Text(curso.duracion),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(appLocal.publicado2puntos),
                      if (curso.publicado) const Icon(Icons.visibility, color: Colors.green, size: 16),
                      if (!curso.publicado)
                        const Icon(
                          Icons.visibility_off,
                          color: Colors.red,
                          size: 16,
                        )
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      )),
      DataCell(SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    splashRadius: 16,
                    onPressed: () async {
                      final created = await showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => NewModuleDialog(
                                cursoID: curso.id,
                                modulo: null,
                              ));

                      if (created) {
                        Provider.of<AllCursosProvider>(context, listen: false).getAllCursos();
                      }
                    },
                    icon: const Icon(
                      Icons.add_box_outlined,
                      color: azulText,
                      size: 16,
                    )),
                const SizedBox(width: 15)
              ],
            ),
            ...curso.modulos.map((e) => SquareModulo(
                  cursoID: curso.id,
                  modulo: e,
                )),
            if (curso.modulos.isEmpty) const SizedBox(height: 100),
            const SizedBox(height: 150)
          ],
        ),
      )),
      DataCell(SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    splashRadius: 16,
                    onPressed: () async {
                      final created = await showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) => NewTestimonioDialog(
                                cursoID: curso.id,
                                testimonio: null,
                              ));

                      if (created) {
                        Provider.of<AllCursosProvider>(context, listen: false).getAllCursos();
                      }
                    },
                    icon: const Icon(
                      Icons.add_box_outlined,
                      color: azulText,
                      size: 16,
                    )),
                const SizedBox(width: 15)
              ],
            ),
            ...curso.testimonios.map((e) => Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  width: 300,
                  color: azulText.withOpacity(0.1),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(e.img),
                            radius: 10,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            e.nombre,
                            style: DashboardLabel.mini,
                          ),
                          const Spacer(),
                          IconButton(
                              splashRadius: 15,
                              onPressed: () async {
                                final created = await showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => NewTestimonioDialog(
                                          cursoID: curso.id,
                                          testimonio: e,
                                        ));

                                if (created) {
                                  Provider.of<AllCursosProvider>(context, listen: false).getAllCursos();
                                }
                              },
                              icon: const Icon(
                                Icons.edit,
                                size: 15,
                                color: azulText,
                              )),
                          IconButton(
                              splashRadius: 15,
                              onPressed: () async {
                                await showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          backgroundColor: bgColor,
                                          title: Text('Eliminar Testimonio', style: DashboardLabel.paragraph,),
                                          content: Text(e.nombre, style: DashboardLabel.paragraph,),
                                          actions: [
                                            CustomButton(
                                              text: appLocal.siBorrar,
                                              onPress: () async {
                                                await Provider.of<AllCursosProvider>(context, listen: false).deleteTestimonio(e.id);
                                                if (context.mounted) {
                                                  Navigator.pop(context, true);
                                                }
                                              },
                                              width: 100,
                                              color: Colors.green,
                                            ),
                                            CustomButton(
                                              color: Colors.red,
                                              text: appLocal.cancelarBtn,
                                              onPress: () {
                                                Navigator.pop(context, false);
                                              },
                                              width: 100,
                                            )
                                          ],
                                        ));
                              },
                              icon: const Icon(
                                Icons.clear,
                                size: 15,
                                color: Colors.red,
                              )),
                        ],
                      ),
                      const SizedBox(height: 7),
                      Text(
                        e.testimonio,
                        style: DashboardLabel.mini.copyWith(color: blancoText.withOpacity(0.5)),
                      )
                    ],
                  ),
                )),
            if (curso.testimonios.isEmpty) const SizedBox(height: 100),
            const SizedBox(height: 150)
          ],
        ),
      )),
      DataCell(Row(
        children: [
          IconButton(
              onPressed: () {
                final dialog = AlertDialog(
                  backgroundColor: bgColor,
                  title: Text(
                    appLocal.seguroBorrar,
                    style: DashboardLabel.h4,
                  ),
                  content: Text(
                    '${appLocal.borrarDefinitivo} "${curso.nombre}"',
                    style: DashboardLabel.paragraph,
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        child: const Text('No')),
                    TextButton(
                        onPressed: () async {
                          //BORRAR USUARIO
                          final isDelete = await Provider.of<AllCursosProvider>(context, listen: false).deleteCurso(curso.id);
                          if (isDelete != null && context.mounted) {
                            Navigator.pop(context, true);
                            NotifServ.showSnackbarError('Lead "${curso.nombre}" ${appLocal.eliminado}', Colors.green);
                          } else {
                            if (context.mounted) Navigator.pop(context, false);
                            NotifServ.showSnackbarError(appLocal.errorEliminadoCurso, Colors.red);
                          }
                        },
                        child: const Text('Si, Borrar'))
                  ],
                );
                showDialog(
                  context: context,
                  builder: (context) => dialog,
                );
              },
              icon: Icon(
                Icons.delete_outline,
                size: 16,
                color: Colors.red.withOpacity(0.8),
              )),
        ],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => length;

  @override
  int get selectedRowCount => 0;
}













// 
