import 'package:flutter/material.dart';
import 'package:jpdirector_frontend/constant.dart';
import 'package:jpdirector_frontend/ui/shared/labels/title_label.dart';

import 'package:provider/provider.dart';

import '../../../datatables/users_datasource.dart';
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
    Provider.of<UsersProvider>(context, listen: false).getPaginatedUsers();
    final List<Usuario> users = Provider.of<UsersProvider>(context).users;
    final size = MediaQuery.of(context).size;
    return Container(
      padding: (size.width < 715)
        ? const EdgeInsets.only(top: 15, left: 15/2, right: 15 /2)
        : const EdgeInsets.only(top: 15, left: 15/2, right: 15 /2),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const SizedBox(height: 80),
          const Padding(
            padding: EdgeInsets.only(left: 0.0),
            child: TitleLabel(
              texto: 'Administración de Usuarios'
            ),
          ),
      
          Theme(
            data: ThemeData.dark().copyWith(cardColor: bgColor),
            child: PaginatedDataTable(
              dataRowMaxHeight: 150,
              dataRowMinHeight: 150,
              columns: const [
                DataColumn(
                  label: Text('IMAGEN', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                DataColumn(label: Text('INFORMACIÓN', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('CURSOS', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('ACCIONES', style: TextStyle(fontWeight: FontWeight.bold))),
              ],
              source: UsersDTS(users, context),
              header: const Text(
                'Lista de usuarios',
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
          
                    if(isCourse){
                      setState(() {
                        Provider.of<UsersProvider>(context, listen: false).getPaginatedUsers();
                      });
                    }
                  },
                  child: const Icon(
                    Icons.person_add,
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
