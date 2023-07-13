import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:jpdirector_frontend/models/baner.dart';
import 'package:jpdirector_frontend/ui/shared/modals/baners_modal.dart';
import 'package:provider/provider.dart';

import '../api/jp_api.dart';
import '../constant.dart';
import '../providers/baners_provider.dart';
import '../services/notificacion_service.dart';
import '../ui/cards/white_card.dart';

class BanersDTS extends DataTableSource {
  List<Baner> baners;
  final BuildContext context;

  BanersDTS(this.baners, this.context);

  @override
  DataRow getRow(int index) {
    final baner = baners[index];

    return DataRow.byIndex(index: index, cells: [
      DataCell(
        Stack(
          children: [
            Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                    width: 340,
                    height: 150,
                    child: Image(
                      image: (baner.img == '') ? const NetworkImage(noimage) : NetworkImage(baner.img),
                      fit: BoxFit.cover,
                    ))),

            const Positioned(
                bottom: 20,
                right: 20,
                child: Icon(
                  Icons.edit_outlined,
                  size: 20,
                  color: bgColor,
                )),
          ],
        ),
        onTap: () => pickImage(context, baner.id.toString()),
      ),
      DataCell(Text(baner.nombre)),
      DataCell(Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Text(baner.priceId),
          const SizedBox(height: 4),
          Text(baner.cursoId),
        ],
      )),
      DataCell(Row(
        children: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) => BanersModal(baner: baner),
                );
              },
              icon: const Icon(
                Icons.edit_outlined,
                size: 16,
                color: bgColor,
              )),
          IconButton(
              onPressed: () {
                final dialog = AlertDialog(
                  title: const Text('Esta seguro de borrar'),
                  content: Text('Borrar definitivamente el baner "${baner.nombre}"'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('No')),
                    TextButton(
                        onPressed: () async {
                          //BORRAR USUARIO
                          final isDelete = await Provider.of<BanersProvider>(context, listen: false).deleteBaner(baner.id);
                          if (isDelete != null && context.mounted) {
                            Navigator.of(context).pop();
                            NotificationServices.showSnackbarError('Lead "${baner.nombre}" Eliminado', Colors.green);
                          } else {
                            Navigator.of(context).pop();
                            NotificationServices.showSnackbarError('Error Eliminando Usuario', Colors.red);
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
  int get rowCount => baners.length;

  @override
  int get selectedRowCount => 0;

  pickImage(BuildContext context, String id) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;

      if (file.extension!.toLowerCase() != 'jpg' && file.extension!.toLowerCase() != 'jpeg' && file.extension!.toLowerCase() != 'png') {
        alertaDeDialogo(title: 'Extension Invalida', dubtitle: 'La extension debe ser "PNG, JPG ó JPEG"', textButton: 'Entendido');
      }
      if (file.size > 1000000) {
        alertaDeDialogo(title: 'Tamaño invalido', dubtitle: 'La imagen debe pesar menos de 1 MB', textButton: 'Entendido');
      }

      await JpApi.editBanerImg('/uploads/baners/$id', file.bytes!);

      if(context.mounted) Provider.of<BanersProvider>(context, listen: false).getBaners();

      notifyListeners();
      NotificationServices.showSnackbarError('cambiada con exito', Colors.green);
    } else {
      // User canceled the picker
    }
  }

  alertaDeDialogo({required String title, required String dubtitle, required String textButton}) {
    return showDialog(
      context: context,
      builder: (context) => Center(
          child: SizedBox(
              width: 200,
              height: 200,
              child: WhiteCard(
                  // isDrag: false,
                  title: title,
                  child: Center(
                      child: Column(
                    children: [
                      Text(dubtitle),
                      const SizedBox(
                        height: 60,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [ElevatedButton(onPressed: () => Navigator.pop(context), child: Text(textButton))],
                      )
                    ],
                  ))))),
    );
  }
}













// 
