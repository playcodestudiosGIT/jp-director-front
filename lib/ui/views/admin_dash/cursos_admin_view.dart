import 'package:flutter/material.dart';
import 'package:jpdirector_frontend/constant.dart';
import 'package:jpdirector_frontend/providers/all_cursos_provider.dart';
import 'package:jpdirector_frontend/ui/shared/modals/cursos_modal.dart';

import 'package:provider/provider.dart';

import '../../../datatables/cursos_datasource.dart';
import '../../shared/labels/title_label.dart';

class CursosAdminView extends StatefulWidget {
  const CursosAdminView({super.key});

  @override
  State<CursosAdminView> createState() => _CursosAdminViewState();
}

class _CursosAdminViewState extends State<CursosAdminView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    Provider.of<AllCursosProvider>(context, listen: false).getAllCursos();
  }

  @override
  Widget build(BuildContext context) {
    final cursos = Provider.of<AllCursosProvider>(context).allCursos;
    final size = MediaQuery.of(context).size;
    return Container(
      padding: (size.width < 715) ? const EdgeInsets.only(top: 15, left: 15/2, right: 15 / 2) : const EdgeInsets.only(top: 15, left: 15/2, right: 15 / 2),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const SizedBox(height: 80),
          const Padding(
            padding: EdgeInsets.only(left: 0.0),
            child: TitleLabel(texto: 'Administración de Cursos',)
          ),
          Theme(
            data: ThemeData.dark().copyWith(cardColor: bgColor),
            child: PaginatedDataTable(
              dataRowMinHeight: 150,
              dataRowMaxHeight: 270,
              columns: const [
                DataColumn(
                  label: Text('IMAGEN DEL CURSO', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('INFORMACION DEL CURSO', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('ACCIONES', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
              source: CursosDTS(context, cursos.length),
              header: const Text(
                'Lista de Cursos',
                // style: ,
                maxLines: 2,
              ),
              rowsPerPage: _rowsPerPage,
              onRowsPerPageChanged: (value) {
                setState(() {
                  _rowsPerPage = value ?? 10;
                });
              },
              actions: [
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(azulText)),
                  onPressed: () async {
                    final allcursosprovider = Provider.of<AllCursosProvider>(context, listen: false);
                    allcursosprovider.cursoModal = allcursosprovider.curso;
                    await showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) => const CursosModal(uid: ''),
                    );
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.add,
                        color: bgColor,
                      ),
                      Icon(
                        Icons.menu_book_outlined,
                        color: bgColor,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
