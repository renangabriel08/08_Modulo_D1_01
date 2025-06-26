import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:modulod/controllers/app.dart';
import 'package:modulod/styles/styles.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modulod/widgets/toast.dart';

class ProfessoresCadastro extends StatefulWidget {
  const ProfessoresCadastro({super.key});

  @override
  State<ProfessoresCadastro> createState() => _ProfessoresCadastroState();
}

class _ProfessoresCadastroState extends State<ProfessoresCadastro> {
  TextEditingController nome = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController telefone = MaskedTextController(
    mask: '(00) 00000-0000',
  );
  TextEditingController desc = TextEditingController();
  File? img;

  salvar() async {
    if (nome.text.isEmpty) {
      MyToast.get('Nome é obrigatório');
    } else {
      App.professores.add({
        "id": App.professores.last['id'] + 1,
        "nome": nome.text,
        "email": email.text,
        "telefone": telefone.text,
        "descricao": desc.text,
      });

      Navigator.pop(context);
      App.pagina.value++;
      App.pagina.value--;
      MyToast.get('Professor salvo com sucesso!');
    }
  }

  tirarFoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);

    if (photo != null) {
      img = File(photo.path);
    }

    setState(() {});
  }

  List professoresSelecionados = [];
  modalProfessores() {
    showDialog(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            App.pagina.value = 0;
          },
          icon: Icon(Icons.home),
        ),
        title: Text('Professores - Novo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                key: const Key('nome'),
                controller: nome,
                keyboardType: TextInputType.text,
                maxLength: 60,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Nome',
                ),
              ),
              Container(height: 16),
              TextFormField(
                key: const Key('email'),
                controller: email,
                onChanged: (value) {
                  if (email.text == 'robson.denneremailcom') {
                    MyToast.get('Formato inválido de email');
                  }
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'E-mail',
                ),
              ),
              Container(height: 16),
              TextFormField(
                key: const Key('telefone'),
                controller: telefone,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Telefone',
                ),
              ),
              Container(height: 16),
              TextFormField(
                key: const Key('desc'),
                controller: desc,
                maxLines: 3,
                maxLength: 200,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Descrição',
                ),
              ),
              Container(height: 16),
              GestureDetector(
                onTap: () => tirarFoto(),
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Cores.preto),
                  ),
                  child: img == null
                      ? Center(child: Icon(Icons.person, size: 50))
                      : InteractiveViewer(
                          child: Image.file(img!, fit: BoxFit.cover),
                        ),
                ),
              ),
              Container(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      App.pagina.value = 0;
                    },
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
    );
  }
}
