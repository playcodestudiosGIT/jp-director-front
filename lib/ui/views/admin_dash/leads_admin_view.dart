import 'package:flutter/material.dart';
import 'package:jpdirector_frontend/constant.dart';
import 'package:jpdirector_frontend/providers/leads_provider.dart';

import 'package:provider/provider.dart';

import '../../../datatables/leads_datasource.dart';
import '../../shared/labels/title_label.dart';
import '../../shared/modals/leads_modal.dart';

class LeadsAdminView extends StatefulWidget {
  
  const LeadsAdminView({super.key});

  @override
  State<LeadsAdminView> createState() => _LeadsAdminViewState();
}

class _LeadsAdminViewState extends State<LeadsAdminView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    Provider.of<LeadsProvider>(context, listen: false).getLeads();
  }

  @override
  Widget build(BuildContext context) {
    final leads = Provider.of<LeadsProvider>(context).leads;
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
              texto: 'Administración de Leads',
            ),
          ),
          Theme(
            data: ThemeData.dark().copyWith(cardColor: bgColor),
            child: PaginatedDataTable(
              columns: const [
                DataColumn(
                  label: Text('INFORMACIÓN', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('ACCIONES', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
              source: LeadsDTS(leads, context),
              header: const Text(
                'Lista de descargas',
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
                      builder: (context) => const LeadsModal(
                        lead: null,
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.email_outlined,
                    color: Colors.white,
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
