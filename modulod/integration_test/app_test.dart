// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:modulod/main.dart';

void main() {
  testWidgets('AppTest', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 10));

    await tester.enterText(find.byType(TextFormField), '@#\$');
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 10));

    await tester.enterText(find.byType(TextFormField), 'Matemática-Avançada');
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 10));

    await tester.enterText(find.byType(TextFormField), 'Mate');
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 10));

    await tester.enterText(find.byType(TextFormField), 'Física Quântica');
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 10));

    await tester.enterText(find.byType(TextFormField), '');
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 10));

    await tester.tap(find.byIcon(Icons.grid_view_outlined));
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 10));

    await tester.ensureVisible(find.text('Lógica'));
    await tester.pumpAndSettle();
    await tester.pump(Duration(milliseconds: 500));
    await tester.longPress(find.text('Lógica'));
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 10));

    await tester.tap(find.byType(TextButton).first);
    await tester.pumpAndSettle();
    await tester.pump(Duration(milliseconds: 500));

    await tester.tap(find.byIcon(Icons.list));
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 10));

    await tester.ensureVisible(find.text('Lógica'));
    await tester.pumpAndSettle();
    await tester.pump(Duration(milliseconds: 500));
    await tester.tap(find.text('Lógica'));
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 10));

    await tester.tap(find.byType(TextButton).first);
    await tester.pumpAndSettle();
    await tester.pump(Duration(milliseconds: 500));
    await tester.tap(find.byType(FloatingActionButton).first);
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 10));

    await salvar(tester);

    await tester.ensureVisible(find.byKey(const Key('completo')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('completo')),
      'Desenvolvimento de Aplivativos Móveis',
    );
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 10));

    await salvar(tester);

    await tester.ensureVisible(find.byKey(const Key('breve')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('breve')), 'Mobile');
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 10));

    await salvar(tester);

    await tester.ensureVisible(find.byKey(const Key('categoria')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('categoria')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('Qualidade de Software')));
    await tester.pump(Duration(seconds: 10));

    await salvar(tester);

    await tester.ensureVisible(find.byKey(const Key('inicio')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('inicio')));
    await tester.pumpAndSettle();
    for (int i = 0; i < 4; i++) {
      await tester.tap(find.byTooltip('Previous month'));
      await tester.pumpAndSettle();
    }
    await tester.tap(find.text('15'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(milliseconds: 500));
    await salvar(tester);

    await tester.ensureVisible(find.byKey(const Key('inicio')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('inicio')));
    await tester.pumpAndSettle();
    for (int i = 0; i < 5; i++) {
      await tester.tap(find.byTooltip('Next month'));
      await tester.pumpAndSettle();
    }
    await tester.tap(find.text('12'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 10));

    await tester.ensureVisible(find.byKey(const Key('fim')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('fim')));
    await tester.pumpAndSettle();
    for (int i = 0; i < 4; i++) {
      await tester.tap(find.byTooltip('Next month'));
      await tester.pumpAndSettle();
    }
    await tester.tap(find.text('12'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 10));
    await salvar(tester);

    await tester.ensureVisible(find.byKey(const Key('fim')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('fim')));
    await tester.pumpAndSettle();
    for (int i = 0; i < 6; i++) {
      await tester.tap(find.byTooltip('Next month'));
      await tester.pumpAndSettle();
    }
    await tester.tap(find.text('12'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 10));

    await salvar(tester);

    await tester.tap(find.byIcon(Icons.add_box_outlined));
    await tester.pumpAndSettle();
    for (int i = 0; i < 6; i++) {
      await tester.tap(find.byIcon(Icons.add).first);
      await tester.pumpAndSettle();
    }
    await tester.pump(const Duration(seconds: 10));

    for (int i = 0; i < 2; i++) {
      await tester.tap(find.byIcon(Icons.remove).last);
      await tester.pumpAndSettle();
    }
    await tester.pump(const Duration(seconds: 10));

    await tester.tap(find.text('Fechar'));
    await tester.pumpAndSettle();
    await salvar(tester);

    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 10));

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 10));

    await salvar(tester);

    await tester.ensureVisible(find.byKey(const Key('nome')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('nome')), 'Robson Denner');
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 10));

    await tester.ensureVisible(find.byKey(const Key('email')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('email')),
      'robson.denneremailcom',
    );
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 10));

    await tester.ensureVisible(find.byKey(const Key('email')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('email')),
      'robson.denner@email.com',
    );
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 10));

    await salvar(tester);

    await tester.tap(find.byIcon(Icons.edit_document));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 10));

    await tester.ensureVisible(find.text('Gerar Relatório'));
    await tester.pumpAndSettle();
    await tester.pump(Duration(milliseconds: 500));
    await tester.tap(find.text('Gerar Relatório'));
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 10));

    await tester.ensureVisible(find.byIcon(Icons.search).first);
    await tester.pumpAndSettle();
    await tester.pump(Duration(milliseconds: 500));
    await tester.tap(find.byIcon(Icons.search).first);
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 10));

    for (int i = 0; i < 3; i++) {
      await tester.tap(find.byIcon(Icons.add).first);
      await tester.pumpAndSettle();
      await tester.pump(Duration(seconds: 10));
    }

    await tester.tap(find.byIcon(Icons.remove).last);
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 10));

    await tester.tap(find.text('Fechar'));
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 10));

    await tester.tap(find.byIcon(Icons.close).first);
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 10));

    await tester.ensureVisible(find.byIcon(Icons.search).last);
    await tester.pumpAndSettle();
    await tester.pump(Duration(milliseconds: 500));
    await tester.tap(find.byIcon(Icons.search).last);
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 10));

    for (int i = 0; i < 2; i++) {
      await tester.tap(find.byIcon(Icons.add).first);
      await tester.pumpAndSettle();
      await tester.pump(Duration(seconds: 10));
    }

    await tester.tap(find.byIcon(Icons.remove).last);
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 10));

    await tester.tap(find.text('Fechar'));
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 10));

    await tester.ensureVisible(find.text('Gerar Relatório'));
    await tester.pumpAndSettle();
    await tester.pump(Duration(milliseconds: 500));
    await tester.tap(find.text('Gerar Relatório'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.textContaining('descricao'));
    await tester.pumpAndSettle();
    await tester.pump(Duration(seconds: 10));

    await tester.tap(find.byIcon(Icons.person));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(seconds: 10));
  });
}

salvar(WidgetTester tester) async {
  await tester.ensureVisible(find.text('Salvar'));
  await tester.pumpAndSettle();
  await tester.pump(Duration(milliseconds: 500));
  await tester.tap(find.text('Salvar'));
  await tester.pumpAndSettle();
  await tester.pump(Duration(seconds: 10));
}
