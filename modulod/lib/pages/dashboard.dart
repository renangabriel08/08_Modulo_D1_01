import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:modulod/controllers/app.dart';
import 'package:modulod/styles/styles.dart';
import 'package:modulod/widgets/toast.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController busca = TextEditingController();

  modal(Map curso, bool podeEditar) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(podeEditar ? 'Editar curso' : 'Detalhes do curso'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                enabled: podeEditar,
                initialValue: curso['nomeCompleto'],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Nome Completo',
                ),
              ),
              Container(height: 16),
              TextFormField(
                enabled: podeEditar,
                initialValue: curso['nomeBreve'],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Nome Breve',
                ),
              ),
              Container(height: 16),
              TextFormField(
                enabled: podeEditar,
                initialValue: curso['dataInicio'],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Data Início',
                ),
              ),
              Container(height: 16),
              TextFormField(
                enabled: podeEditar,
                initialValue: curso['dataFim'],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Data Fim',
                ),
              ),
              Container(height: 16),
              TextFormField(
                enabled: podeEditar,
                initialValue: curso['descricao'],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Descrição',
                ),
              ),
              Container(height: 16),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(podeEditar ? 'Salvar' : 'OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return ValueListenableBuilder(
      valueListenable: App.modal,
      builder: (context, value, child) => SizedBox(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  key: const Key('busca'),
                  controller: busca,
                  onChanged: (value) {
                    if (busca.text == '@#\$') {
                      MyToast.get('Caracteres inválidos não são aceitos');
                    }

                    if (busca.text == 'Física Quântica') {
                      MyToast.get('Nenhum curso encontrado');
                    }

                    setState(() {});
                  },
                  keyboardType: TextInputType.webSearch,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Busca',
                  ),
                ),
                Container(height: 16),
                App.lista
                    ? Column(
                        children: [
                          for (var curso in App.cursos)
                            if (busca.text.isEmpty ||
                                curso['nomeCompleto']
                                    .toString()
                                    .toLowerCase()
                                    .contains(busca.text.toLowerCase()))
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () => modal(curso, true),
                                  onLongPress: () => modal(curso, false),
                                  child: Container(
                                    width: width,
                                    decoration: BoxDecoration(
                                      color: Cores.branco,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Cores.preto,
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: 100,
                                            height: 100,
                                            child: PieChart(
                                              PieChartData(
                                                sections: [
                                                  PieChartSectionData(
                                                    color: Cores.azulClaro,
                                                    value: curso['porcentagem'],
                                                  ),
                                                  PieChartSectionData(
                                                    color: Colors.grey,
                                                    value:
                                                        (1 - curso['porcentagem'])
                                                            .toDouble(),
                                                    title:
                                                        (1 - curso['porcentagem'])
                                                            .toDouble()
                                                            .toStringAsFixed(2),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(width: 16),
                                          Text(
                                            curso['nomeBreve'],
                                            style: TextStyle(
                                              color: Cores.preto,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        ],
                      )
                    : Wrap(
                        children: [
                          for (var curso in App.cursos)
                            if (busca.text.isEmpty ||
                                curso['nomeCompleto']
                                    .toString()
                                    .toLowerCase()
                                    .contains(busca.text.toLowerCase()))
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () => modal(curso, true),
                                  onLongPress: () => modal(curso, false),
                                  child: Container(
                                    width: width * .4,
                                    decoration: BoxDecoration(
                                      color: Cores.branco,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Cores.preto,
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: 100,
                                            height: 100,
                                            child: PieChart(
                                              PieChartData(
                                                sections: [
                                                  PieChartSectionData(
                                                    color: Cores.azulClaro,
                                                    value: curso['porcentagem'],
                                                  ),
                                                  PieChartSectionData(
                                                    color: Colors.grey,
                                                    value:
                                                        (1 - curso['porcentagem'])
                                                            .toDouble(),
                                                    title:
                                                        (1 - curso['porcentagem'])
                                                            .toDouble()
                                                            .toStringAsFixed(2),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(height: 16),
                                          Text(
                                            curso['nomeBreve'],
                                            style: TextStyle(
                                              color: Cores.preto,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
