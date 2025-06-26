import 'package:flutter/material.dart';

class App {
  static ValueNotifier<int> pagina = ValueNotifier(0);
  static ValueNotifier<int> modal = ValueNotifier(0);

  static List categorias = [];
  static List cursos = [];
  static List professores = [];

  static bool lista = true;
  static bool relatorio = false;
}
