import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:modulod/controllers/app.dart';
import 'package:modulod/styles/styles.dart';
import 'package:modulod/widgets/toast.dart';

class CursosCadastro extends StatefulWidget {
  const CursosCadastro({super.key});

  @override
  State<CursosCadastro> createState() => _CursosCadastroState();
}

class _CursosCadastroState extends State<CursosCadastro> {
  TextEditingController completo = TextEditingController();
  TextEditingController breve = TextEditingController();
  TextEditingController sumario = TextEditingController();
  TextEditingController inicio = TextEditingController();
  TextEditingController fim = TextEditingController();

  DateTime dtInicio = DateTime.now();
  DateTime dtFim = DateTime.now();

  Map? categoria;
  String? formato;

  List<String> formatos = [
    'Atividade Única',
    'Formato Social',
    'Formato tópicos',
    'Formato semanal',
  ];

  bool visivel = true;

  salvar() async {
    if (completo.text.isEmpty) {
      MyToast.get('Nome completo é obrigatório');
    } else if (breve.text.isEmpty) {
      MyToast.get('Nome breve é obrigatório');
    } else if (categoria == null) {
      MyToast.get('Categoria é obrigatório');
    } else if (inicio.text.isEmpty) {
      MyToast.get('Data início é obrigatória');
    } else if (dtInicio.isBefore(DateTime.now())) {
      MyToast.get('Data início não pode ser anterior ao dia atual');
    } else if (dtFim.isBefore(dtInicio)) {
      MyToast.get('Data fim não pode ser anterior a data de início');
    } else if (professoresSelecionados.isEmpty) {
      MyToast.get('Selecione ao menos um professor');
    } else if (formKey.currentState!.validate()) {
      App.cursos.add({
        "id": App.cursos.last['id'] + 1,
        "nomeCompleto": completo.text,
        "nomeBreve": breve.text,
        "categoria_id": categoria!['id'],
        "visivel": visivel,
        "dataInicio": inicio.text,
        "dataFim": fim.text,
        "descricao": sumario.text,
        "formato": formato.toString(),
        "professores_id": [
          for (var prof in professoresSelecionados) prof['id'],
        ],
        "porcentagem": 0.0,
      });
      await App.salvar();
      MyToast.get('Curso salvo com sucesso!');
      Navigator.pop(context);
      App.pagina.value++;
      App.pagina.value--;
    } else {
      MyToast.get('Preencha todos os campos');
    }
  }

  var formKey = GlobalKey<FormState>();

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
                          if (professoresSelecionados.length == 5) {
                            MyToast.get('No máximo 5 professores');
                          } else {
                            professoresSelecionados.add(prof);
                          }
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.home),
        ),
        title: Text('Cursos - Novo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(height: 16),
                TextFormField(
                  key: const Key('completo'),
                  controller: completo,
                  keyboardType: TextInputType.text,
                  maxLength: 50,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nome completo é obrigatório';
                    }

                    if (value.length < 10) {
                      return 'Formato inválido';
                    }

                    if (!value.contains(' ') ||
                        value.indexOf(' ') == 0 ||
                        value.indexOf(' ') == value.length - 1) {
                      return 'Formato inválido';
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Nome Completo',
                  ),
                ),
                Container(height: 16),
                TextFormField(
                  key: const Key('breve'),
                  controller: breve,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nome breve é obrigatório';
                    }

                    return null;
                  },
                  maxLength: 15,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Nome Breve',
                  ),
                ),
                Container(height: 16),
                DropdownButtonFormField(
                  key: const Key('categoria'),
                  value: categoria,
                  validator: (value) {
                    if (value == null) {
                      return 'Categoria é obrigatório';
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Categoria',
                  ),
                  items: [
                    for (var cat in App.categorias)
                      DropdownMenuItem(
                        key: Key(cat['nome']),
                        value: cat,
                        child: Text(cat['nome']),
                      ),
                  ],
                  onChanged: (value) => setState(() {
                    categoria = value as Map;
                  }),
                ),
                Container(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Visivel', style: TextStyle(fontSize: 16)),
                    Switch(
                      value: visivel,
                      onChanged: (value) => setState(() {
                        visivel = !visivel;
                      }),
                    ),
                  ],
                ),
                Container(height: 16),
                TextFormField(
                  key: const Key('inicio'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Data Início é obrigatória';
                    }

                    return null;
                  },
                  controller: inicio,
                  readOnly: true,
                  onTap: () =>
                      showDatePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2030),
                        initialDate: DateTime.now(),
                      ).then((value) {
                        if (value != null) {
                          dtInicio = value;
                          inicio.text = DateFormat(
                            "dd/MM/yyyy",
                          ).format(dtInicio);
                        }

                        setState(() {});
                      }),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Data Início',
                  ),
                ),
                Container(height: 16),
                TextFormField(
                  key: const Key('fim'),
                  controller: fim,
                  onTap: () =>
                      showDatePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2030),
                        initialDate: DateTime.now(),
                      ).then((value) {
                        if (value != null) {
                          dtFim = value;
                          fim.text = DateFormat("dd/MM/yyyy").format(dtFim);
                        }

                        setState(() {});
                      }),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Data Fim',
                  ),
                ),
                Container(height: 16),
                TextFormField(
                  key: const Key('sumario'),
                  controller: sumario,
                  keyboardType: TextInputType.text,
                  maxLength: 200,
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Sumário',
                  ),
                ),
                Container(height: 16),
                DropdownButtonFormField(
                  value: formato,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Formato',
                  ),
                  items: [
                    for (var format in formatos)
                      DropdownMenuItem(value: format, child: Text(format)),
                  ],
                  onChanged: (value) => setState(() {
                    formato = value.toString();
                  }),
                ),
                Container(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Professores', style: TextStyle(fontSize: 16)),
                    IconButton(
                      onPressed: () => modalProfessores(),
                      icon: Icon(Icons.add_box_outlined),
                    ),
                  ],
                ),
                Container(
                  width: width,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Cores.preto),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (var prof in professoresSelecionados)
                          Slidable(
                            key: ValueKey(prof['id']),
                            endActionPane: ActionPane(
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    setState(() {
                                      professoresSelecionados.remove(prof);
                                    });
                                  },
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Deletar',
                                ),
                              ],
                            ),

                            child: ListTile(title: Text(prof['nome'])),
                          ),
                      ],
                    ),
                  ),
                ),
                Container(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () => salvar(),
                      child: Text('Salvar'),
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
