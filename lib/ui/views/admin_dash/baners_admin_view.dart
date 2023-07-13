import 'package:flutter/material.dart';
import 'package:jpdirector_frontend/constant.dart';
import 'package:jpdirector_frontend/providers/baners_provider.dart';
import 'package:jpdirector_frontend/ui/shared/modals/baners_modal.dart';

import 'package:provider/provider.dart';

import '../../../datatables/baners_datasource.dart';

class BanersAdminView extends StatefulWidget {
  
  const BanersAdminView({super.key});

  @override
  State<BanersAdminView> createState() => _BanersAdminViewState();
}

class _BanersAdminViewState extends State<BanersAdminView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    Provider.of<BanersProvider>(context, listen: false).getBaners();
  }

  @override
  Widget build(BuildContext context) {
    final baners = Provider.of<BanersProvider>(context).baners;
    final size = MediaQuery.of(context).size;
    return Container(
      padding: (size.width < 715)
        ? const EdgeInsets.only(top: 15, left: 50, right: 15 / 2)
        : const EdgeInsets.only(top: 15, left: 15, right: 15 / 2),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const SizedBox(height: 80),
          const Padding(
            padding: EdgeInsets.only(left: 30.0),
            child: Text(
              'Administración de Baners',
              style: TextStyle(color: Colors.white),
            ),
          ),
          PaginatedDataTable(
            dataRowMaxHeight: 150,
            dataRowMinHeight: 150,
            columns: const [
              DataColumn(
                label: Text('Imagen'),
              ),
              DataColumn(
                label: Text('Nombre'),
              ),
              DataColumn(
                label: Text('ID\'s'),
              ),
              DataColumn(
                label: Text('Acciones'),
              ),
            ],
            source: BanersDTS(baners, context),
            header: const Text(
              'Lista de Cursos Disponibles',
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
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) => const BanersModal(
                      baner: null,
                    ),
                  );
                },
                child: const Icon(
                  Icons.style_outlined,
                  color: Colors.white,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
