import 'package:fluttertoast/fluttertoast.dart';
import 'package:modulod/styles/styles.dart';

class MyToast {
  static get(String txt) {
    Fluttertoast.showToast(
      msg: txt,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Cores.azulClaro,
      textColor: Cores.branco,
      fontSize: 16.0,
    );
  }
}
