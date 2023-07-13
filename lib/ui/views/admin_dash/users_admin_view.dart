import 'package:flutter/material.dart';
import 'package:jpdirector_frontend/constant.dart';

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
        ? const EdgeInsets.only(top: 15, left: 50, right: 15 / 2)
        : const EdgeInsets.only(top: 15, left: 15, right: 15 / 2),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const SizedBox(height: 80),
          const Padding(
            padding: EdgeInsets.only(left: 30.0),
            child: Text(
              'Administración de Usuarios', style: TextStyle(color: Colors.white),
            ),
          ),
      
          PaginatedDataTable(
            dataRowMaxHeight: 150,
            dataRowMinHeight: 150,
            columns: const [
              DataColumn(
                label: Text('Foto'),
              ),
              DataColumn(label: Text('Nombre')),
              DataColumn(label: Text('Cursos')),
              DataColumn(label: Text('Acciones')),
            ],
            source: UsersDTS(users, context),
            header: const Text(
              'Lista de usuarios',
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
