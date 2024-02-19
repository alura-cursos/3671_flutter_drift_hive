import 'package:flutter/material.dart';
import 'package:flutter_listin/authentication/models/mock_user.dart';
import 'package:flutter_listin/listins/screens/widgets/home_drawer.dart';
import 'package:flutter_listin/listins/screens/widgets/home_listin_item.dart';
import '../models/listin.dart';
import 'widgets/listin_add_edit_modal.dart';
import 'widgets/listin_options_modal.dart';

class HomeScreen extends StatefulWidget {
  final MockUser user;
  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Listin> listListins = [];

  @override
  void initState() {
    // TODO: Ao implementar os Listins, adicionar o refresh aqui
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrawer(user: widget.user),
      appBar: AppBar(
        title: const Text("Minhas listas"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddModal();
        },
        child: const Icon(Icons.add),
      ),
      body: (listListins.isEmpty)
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/bag.png"),
                  const SizedBox(height: 32),
                  const Text(
                    "Nenhuma lista ainda.\nVamos criar a primeira?",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: () {
                return refresh();
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
                child: ListView(
                  children: List.generate(
                    listListins.length,
                    (index) {
                      Listin listin = listListins[index];
                      return HomeListinItem(
                        listin: listin,
                        showOptionModal: showOptionModal,
                      );
                    },
                  ),
                ),
              ),
            ),
    );
  }

  showAddModal({Listin? listin}) {
    showAddEditListinModal(context: context, onRefresh: refresh, model: listin);
  }

  showOptionModal(Listin listin) {
    showListinOptionsModal(
      context: context,
      listin: listin,
      onRemove: remove,
    ).then((value) {
      if (value != null && value) {
        showAddModal(listin: listin);
      }
    });
  }

  refresh() async {
    // Basta alimentar essa variável com Listins que, quando o método for
    // chamado, a tela sera reconstruída com os itens.
    List<Listin> listaListins = [];

    //TODO - CRUD Listin: remover código mockado.
    listaListins.add(
      Listin(
        id: "L01",
        name: "Feira do mês",
        obs: "Para compras de reabastecimento mensais.",
        dateCreate: DateTime.now(),
        dateUpdate: DateTime.now(),
      ),
    );

    setState(() {
      listListins = listaListins;
    });
  }

  void remove(Listin model) async {
    // TODO - CRUD Listin: remover o Listin
    refresh();
  }
}
