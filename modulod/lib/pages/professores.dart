import 'package:flutter/material.dart';
import 'package:modulod/controllers/app.dart';

class Professores extends StatefulWidget {
  const Professores({super.key});

  @override
  State<Professores> createState() => _ProfessoresState();
}

class _ProfessoresState extends State<Professores> {
  TextEditingController busca = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: busca,
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
            for (var prof in App.professores)
              ListTile(
                onLongPress: () => setState(() {
                  if (prof['press'] == null) {
                    prof['press'] = true;
                  } else {
                    prof['press'] = !prof['press'];
                  }
                }),
                title: Text(prof['nome']),
                subtitle: Text(prof['descricao']),
                trailing: prof['press'] == null
                    ? null
                    : prof['press']
                    ? IconButton(onPressed: () => (), icon: Icon(Icons.delete))
                    : null,
              ),
          ],
        ),
      ),
    );
  }
}
