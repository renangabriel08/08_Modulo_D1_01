import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modulod/controllers/app.dart';
import 'package:modulod/pages/dashboard.dart';
import 'package:modulod/pages/professores.dart';
import 'package:modulod/pages/relatorios.dart';
import 'package:modulod/styles/styles.dart';
import 'package:modulod/widgets/toast.dart';
import 'package:no_screenshot/no_screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late StreamSubscription<List<ConnectivityResult>> subscription;

  bool net = false;

  startApp() async {
    await NoScreenshot.instance.screenshotOff();

    String data = await rootBundle.loadString('assets/dados.json');
    Map dados = jsonDecode(data);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? cursos = prefs.getString('cursos');

    if (cursos == null) {
      App.cursos = dados['cursos'];
    } else {
      App.cursos = jsonDecode(cursos);
    }

    App.categorias = dados['categorias'];
    App.professores = dados['professores_id'];

    setState(() {});

    subscription = Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> result,
    ) {
      if (result.contains(ConnectivityResult.none)) {
        net = false;
        MyToast.get('Sem conexão com internet');
      } else {
        net = true;
      }

      setState(() {});
    });
  }

  @override
  dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    startApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: App.pagina,
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            value == 0
                ? 'Dashboard'
                : value == 1
                ? 'Professores'
                : 'Relatórios',
          ),
          leading: IconButton(
            onPressed: () {
              App.pagina.value = 0;
            },
            icon: Icon(Icons.home),
          ),
          actions: value == 0
              ? [
                  IconButton(
                    onPressed: () {
                      App.lista = false;
                      App.pagina.value++;
                      App.pagina.value--;
                    },
                    icon: Icon(
                      Icons.grid_view_outlined,
                      color: !App.lista ? Colors.grey : Cores.preto,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      App.lista = true;
                      App.pagina.value++;
                      App.pagina.value--;
                    },
                    icon: Icon(
                      Icons.list,
                      color: App.lista ? Colors.grey : Cores.preto,
                    ),
                  ),
                ]
              : [],
        ),
        body: App.cursos.isEmpty
            ? Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: !net
                        ? MediaQuery.of(context).size.height * .72
                        : MediaQuery.of(context).size.height * .79,
                    child: IndexedStack(
                      index: value,
                      children: [Dashboard(), Professores(), Relatorios()],
                    ),
                  ),
                  if (value == 0 && !net)
                    Container(
                      height: MediaQuery.of(context).size.height * .07,
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Sem internet! Os dados podem não estar totalmente salvos.',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                ],
              ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.grey,
          unselectedItemColor: Cores.preto,
          currentIndex: value,
          onTap: (index) => App.pagina.value = index,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_rounded),
              label: 'Cursos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Professores',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit_document),
              label: 'Relatórios',
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: value != 2
              ? Cores.azulClaro
              : App.relatorio
              ? Cores.azulClaro
              : Colors.grey,
          onPressed: () {
            if (value == 0) {
              Navigator.pushNamed(context, '/cadastro_curso');
            } else if (value == 1) {
              Navigator.pushNamed(context, '/cadastro_prof');
            } else {}
          },
          child: Icon(value != 2 ? Icons.add : Icons.save, color: Cores.branco),
        ),
      ),
    );
  }
}
