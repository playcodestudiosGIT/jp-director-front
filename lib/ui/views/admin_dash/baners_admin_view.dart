import 'package:flutter/material.dart';
import 'package:jpdirector_frontend/constant.dart';
import 'package:jpdirector_frontend/providers/baners_provider.dart';
import 'package:jpdirector_frontend/ui/shared/labels/dashboard_label.dart';
import 'package:jpdirector_frontend/ui/shared/labels/title_label.dart';
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
          ? const EdgeInsets.only(top: 15, left: 15 / 2, right: 15 / 2)
          : const EdgeInsets.only(top: 15, left: 15 / 2, right: 15 / 2),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const SizedBox(height: 80),
          const Padding(
            padding: EdgeInsets.only(left: 0.0),
            child: TitleLabel(
              texto: 'Administración de Baners',
            ),
          ),
          Theme(
            data: ThemeData.dark().copyWith(cardColor: bgColor),
            child: PaginatedDataTable(
              
              dataRowMaxHeight: 200,
              dataRowMinHeight: 200,
              columns: [
                DataColumn(
                  label: Text('IMAGEN', style: DashboardLabel.h4.copyWith(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('NOMBRE', style: DashboardLabel.h4.copyWith(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('ID\'s', style: DashboardLabel.h4.copyWith(fontWeight: FontWeight.bold)),
                ),
                DataColumn(
                  label: Text('ACCIONES', style: DashboardLabel.h4.copyWith(fontWeight: FontWeight.bold)),
                ),
              ],
              source: BanersDTS(baners, context),
              header: Text(
                'Lista de Baners',
                style: DashboardLabel.paragraph,
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
            ),
          )
        ],
      ),
    );
  }
}
