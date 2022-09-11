import 'package:get/get.dart';

class KetikJawabanController extends GetxController {
  var jawaban = "".obs;

  setJawaban(String Jjawaban) {
    jawaban.value = Jjawaban;
  }
}
