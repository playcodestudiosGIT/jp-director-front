import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jpdirector_frontend/providers/all_cursos_provider.dart';
import 'package:jpdirector_frontend/ui/shared/labels/dashboard_label.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import '../models/curso.dart';
import '../services/notificacion_service.dart';
import '../ui/shared/modals/cursos_modal.dart';

class CursosDTS extends DataTableSource {
  final BuildContext context;
  final int length;

  CursosDTS(this.context, this.length);

  @override
  DataRow getRow(int index) {
    List<Curso> cursos = Provider.of<AllCursosProvider>(context).allCursos;
    final curso = cursos[index];

    final modulos = curso.modulos.where((modulo) => modulo.estado).toList();

    return DataRow.byIndex(index: index, cells: [
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Text(
              curso.nombre.toUpperCase(),
              style: DashboardLabel.h4,
            ),
            const SizedBox(height: 4),
            Text(
              curso.precio,
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
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: curso.id));
                      // copied successfully
                    },
                    icon: Icon(
                      Icons.copy_outlined,
                      size: 12,
                      color: Colors.white.withOpacity(0.5),
                    ))
              ],
            ),
            // const Spacer(),
            Row(
              children: [
                Text(
                  'Modulos: ',
                  style: DashboardLabel.mini,
                ),
                Text(modulos.length.toString()),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Duración: ',
                  style: DashboardLabel.mini,
                ),
                Text(curso.duracion),
              ],
            ),
            const SizedBox(height: 30),
          ],
        ),
      )),
      DataCell(Row(
        children: [
          IconButton(
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
                Icons.edit_outlined,
                size: 16,
                color: azulText,
              )),
          // IconButton(onPressed: () {}, icon: const Icon(Icons.email_outlined)),
          IconButton(
              onPressed: () {
                final dialog = AlertDialog(
                  title: const Text('Esta seguro de borrar'),
                  content: Text('Borrar definitivamente el usuario "${curso.nombre}"'),
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
                            NotifServ.showSnackbarError('Lead "${curso.nombre}" Eliminado', Colors.green);
                          } else {
                            if(context.mounted)Navigator.pop(context, false);
                            NotifServ.showSnackbarError('Error Eliminando Curso', Colors.red);
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
