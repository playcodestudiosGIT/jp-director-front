import 'package:flutter/material.dart';
import 'package:jp_director/constant.dart';
import 'package:jp_director/generated/l10n.dart';
import 'package:jp_director/providers/form_provider.dart';
import 'package:jp_director/ui/shared/labels/dashboard_label.dart';
import 'package:jp_director/ui/shared/labels/title_label.dart';

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
    final appLocal = AppLocalizations.of(context);
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
          Padding(
            padding: const EdgeInsets.only(left: 0.0),
            child: TitleLabel(
              texto: appLocal.adminForms,
            ),
          ),
          Theme(
            data: ThemeData.dark().copyWith(cardColor: bgColor),
            child: PaginatedDataTable(
              dataRowMaxHeight: 370,
              dataRowMinHeight: 300,
              columns:  [
                DataColumn(
                  label: Text(appLocal.informacionMayus, style: DashboardLabel.h4.copyWith(color: blancoText.withOpacity(0.5))),
                ),
                DataColumn(
                  label: Text(appLocal.redesSociales, style: DashboardLabel.h4.copyWith(color: blancoText.withOpacity(0.5))),
                ),
                DataColumn(
                  label: Text(appLocal.acciones, style: DashboardLabel.h4.copyWith(color: blancoText.withOpacity(0.5))),
                ),
              ],
              source: FormsDTS(forms, context),
              header: Text(
                appLocal.listaForm,
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
                      builder: (context) => const FormsModal(
                        form: null,
                      ),
                    );
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.format_list_numbered_outlined,
                        color: bgColor,
                        size: 16,
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
