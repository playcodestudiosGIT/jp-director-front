import 'package:flutter/material.dart';
import 'package:jpdirector_frontend/constant.dart';
import 'package:jpdirector_frontend/providers/leads_provider.dart';

import 'package:provider/provider.dart';

import '../../../datatables/leads_datasource.dart';
import '../../../generated/l10n.dart';
import '../../shared/labels/dashboard_label.dart';
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
    final appLocal = AppLocalizations.of(context);
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
          Padding(
            padding: const EdgeInsets.only(left: 0.0),
            child: TitleLabel(
              texto: appLocal.adminLeads,
            ),
          ),
          Theme(
            data: ThemeData.dark().copyWith(cardColor: bgColor),
            child: PaginatedDataTable(
              columns: [
                DataColumn(
                  label: Text(appLocal.datosDescarga, style: DashboardLabel.h4.copyWith(color: blancoText.withOpacity(0.5))),
                ),
                DataColumn(
                  label: Text(appLocal.acciones, style: DashboardLabel.h4.copyWith(color: blancoText.withOpacity(0.5))),
                ),
              ],
              source: LeadsDTS(leads, context),
              header: Text(
                appLocal.listaDescarga,
                style: DashboardLabel.h3,
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
                    color: bgColor,
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
