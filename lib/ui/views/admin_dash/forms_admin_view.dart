import 'package:flutter/material.dart';
import 'package:jpdirector_frontend/constant.dart';
import 'package:jpdirector_frontend/providers/form_provider.dart';
import 'package:jpdirector_frontend/ui/shared/labels/title_label.dart';

import 'package:provider/provider.dart';

import '../../../datatables/forms_datasource.dart';
import '../../shared/modals/form_modal.dart';

class FormAdminView extends StatefulWidget {
  
  const FormAdminView({super.key});

  @override
  State<FormAdminView> createState() => _FormAdminViewState();
}

class _FormAdminViewState extends State<FormAdminView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    Provider.of<FormProvider>(context, listen: false).getForms();
  }

  @override
  Widget build(BuildContext context) {
    final forms = Provider.of<FormProvider>(context).allForms;
    final size = MediaQuery.of(context).size;
    return Container(
      padding: (size.width < 715)
        ? const EdgeInsets.only(top: 15, left: 15/2, right: 15 / 2)
        : const EdgeInsets.only(top: 15, left: 15/2, right: 15 / 2),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const SizedBox(height: 80),
          const Padding(
            padding: EdgeInsets.only(left: 0.0),
            child: TitleLabel(
              texto: 'Administración de Formularios',
            ),
          ),
          Theme(
            data: ThemeData.dark().copyWith(cardColor: bgColor),
            child: PaginatedDataTable(
              dataRowMaxHeight: 370,
              dataRowMinHeight: 300,
              columns: const [
                DataColumn(
                  label: Text('INFORMACIÓN', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('REDES SOCIALES', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('ACCIONES', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
              source: FormsDTS(forms, context),
              header: const Text(
                'Lista de Formularios',
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
                      builder: (context) => const FormsModal(
                        form: null,
                      ),
                    );
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.add_outlined,
                        color: Colors.white,
                      ),
                      Icon(
                        Icons.format_list_numbered_outlined,
                        color: Colors.white,
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
