import 'package:flutter/material.dart';
import 'package:jpdirector_frontend/constant.dart';
import 'package:jpdirector_frontend/ui/shared/labels/dashboard_label.dart';
import 'package:jpdirector_frontend/ui/shared/labels/title_label.dart';

import 'package:provider/provider.dart';

import '../../../datatables/users_datasource.dart';
import '../../../generated/l10n.dart';
import '../../../models/usuario_model.dart';
import '../../../providers/all_cursos_provider.dart';
import '../../../providers/users_provider.dart';
import '../../shared/modals/users_modal.dart';

class UsersAdminView extends StatefulWidget {
  const UsersAdminView({super.key});

  @override
  State<UsersAdminView> createState() => _UsersAdminViewState();
}

class _UsersAdminViewState extends State<UsersAdminView> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  void initState() {
    super.initState();
    Provider.of<UsersProvider>(context, listen: false).getPaginatedUsers();
    Provider.of<AllCursosProvider>(context, listen: false).getAllCursos();
  }

  @override
  Widget build(BuildContext context) {
    final appLocal = AppLocalizations.of(context);
    final List<Usuario> users = Provider.of<UsersProvider>(context).users;
    final size = MediaQuery.of(context).size;
    return Container(
      padding: (size.width < 715)
          ? const EdgeInsets.only(top: 15, left: 15 / 2, right: 15 / 2)
          : const EdgeInsets.only(top: 15, left: 15 / 2, right: 15 / 2),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const SizedBox(height: 80),
          Padding(
            padding: const EdgeInsets.only(left: 0.0),
            child: TitleLabel(texto: appLocal.adminUsuarios),
          ),
          Theme(
            data: ThemeData.dark().copyWith(cardColor: bgColor),
            child: PaginatedDataTable(
              dataRowMaxHeight: 150,
              dataRowMinHeight: 150,
              columns: [
                DataColumn(
                  label: Text(appLocal.imagen, style: DashboardLabel.h4.copyWith(color: blancoText.withOpacity(0.5))),
                ),
                DataColumn(label: Text(appLocal.informacionMayus, style: DashboardLabel.h4.copyWith(color: blancoText.withOpacity(0.5)))),
                DataColumn(label: Text(appLocal.cursoMayus, style: DashboardLabel.h4.copyWith(color: blancoText.withOpacity(0.5)))),
                DataColumn(label: Text(appLocal.acciones, style: DashboardLabel.h4.copyWith(color: blancoText.withOpacity(0.5)))),
              ],
              source: UsersDTS(users, context),
              header: Text(
                appLocal.listaUsuarios,
                style: DashboardLabel.h3,
              ),
              rowsPerPage: _rowsPerPage,
              onRowsPerPageChanged: (value) {
                setState(() {
                  _rowsPerPage = value ?? 5;
                });
              },
              actions: [
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(azulText)),
                  onPressed: () async {
                    final isCourse = await showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) => const UsersModal(
                        user: null,
                      ),
                    );

                    if (isCourse == null) return;

                    if (isCourse) {
                      setState(() {
                        Provider.of<UsersProvider>(context, listen: false).getPaginatedUsers();
                      });
                    }
                  },
                  child: const Icon(
                    Icons.person_add,
                    color: bgColor,
                  ),
                ),
                // ElevatedButton(
                //   style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.transparent)),
                //   onPressed: () {
                //     setState(() {
                      
                //     });
                //   },
                //   child: const Icon(
                //     Icons.refresh,
                //     color: azulText,
                //   ),
                // )
              ],
            ),
          )
        ],
      ),
    );
  }
}
