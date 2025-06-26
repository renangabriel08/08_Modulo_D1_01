import 'package:flutter/material.dart';
import 'package:modulod/controllers/app.dart';
import 'package:modulod/styles/styles.dart';
import 'package:modulod/widgets/toast.dart';

class Relatorios extends StatefulWidget {
  const Relatorios({super.key});

  @override
  State<Relatorios> createState() => _RelatoriosState();
}

class _RelatoriosState extends State<Relatorios> {
  List professoresSelecionados = [];
  modalProfessores() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Selecionar professores'),
        content: ValueListenableBuilder(
          valueListenable: App.modal,
          builder: (context, value, child) => SingleChildScrollView(
            child: Column(
              children: [
                for (var prof in App.professores)
                  ListTile(
                    title: Text(prof['nome']),
                    trailing: IconButton(
                      onPressed: () {
                        if (professoresSelecionados.contains(prof)) {
                          professoresSelecionados.remove(prof);
                        } else {
                          professoresSelecionados.add(prof);
                        }

                        App.modal.value++;
                        setState(() {});
                      },
                      icon: Icon(
                        professoresSelecionados.contains(prof)
                            ? Icons.remove
                            : Icons.add,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Fechar'),
          ),
        ],
      ),
    );
  }

  List cursosSelecionados = [];
  modalCursos() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Selecionar cursos'),
        content: ValueListenableBuilder(
          valueListenable: App.modal,
          builder: (context, value, child) => SingleChildScrollView(
            child: Column(
              children: [
                for (var curso in App.cursos)
                  ListTile(
                    title: Text(curso['nomeCompleto']),
                    trailing: IconButton(
                      onPressed: () {
                        if (cursosSelecionados.contains(curso)) {
                          cursosSelecionados.remove(curso);
                        } else {
                          cursosSelecionados.add(curso);
                        }

                        App.modal.value++;
                        setState(() {});
                      },
                      icon: Icon(
                        cursosSelecionados.contains(curso)
                            ? Icons.remove
                            : Icons.add,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Fechar'),
          ),
        ],
      ),
    );
  }

  TextEditingController relatorio = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: width,
              height: height * .3,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Cores.preto),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Cursos'),
                      trailing: IconButton(
                        onPressed: () => modalCursos(),
                        icon: Icon(Icons.search),
                      ),
                    ),
                    Divider(),
                    for (var curso in cursosSelecionados)
                      ListTile(
                        title: Text(curso['nomeCompleto']),
                        trailing: IconButton(
                          onPressed: () => setState(() {
                            cursosSelecionados.remove(curso);
                          }),
                          icon: Icon(Icons.close),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Container(height: 16),
            Container(
              width: width,
              height: height * .3,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Cores.preto),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Professores'),
                      trailing: IconButton(
                        onPressed: () => modalProfessores(),
                        icon: Icon(Icons.search),
                      ),
                    ),
                    Divider(),
                    for (var prof in professoresSelecionados)
                      ListTile(
                        title: Text(prof['nome']),
                        trailing: IconButton(
                          onPressed: () => setState(() {
                            professoresSelecionados.remove(prof);
                          }),
                          icon: Icon(Icons.close),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Container(height: 16),
            ElevatedButton(
              onPressed: () {
                if (professoresSelecionados.isEmpty ||
                    cursosSelecionados.isEmpty) {
                  MyToast.get('Selecione ao menos um curso ou professor');
                } else {
                  relatorio.clear();
                  App.relatorio = true;
                  App.pagina.value++;
                  App.pagina.value--;

                  relatorio.text += 'Cursos:\n';

                  for (var curso in cursosSelecionados) {
                    relatorio.text += '$curso\n';
                  }

                  relatorio.text += '\nProfessores:\n';
                  for (var prof in professoresSelecionados) {
                    relatorio.text += '$prof\n';
                  }

                  setState(() {});
                }
              },
              child: Text('Gerar Relatório'),
            ),
            Container(height: 16),
            TextFormField(
              controller: relatorio,
              maxLines: 20,
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
