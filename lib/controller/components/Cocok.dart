import 'package:get/get.dart';

class CocokController extends GetxController {
  var leftChoice = (-1).obs;
  var rightChoice = (-1).obs;
  var correct = [].obs;
  setLeftChoice(int e) => leftChoice.value = e;
  setRightChoice(int e) => rightChoice.value = e;
  appendCorrect(dynamic e) => correct.add(e);
  resetChoice() {
    leftChoice.value = -1;
    rightChoice.value = -1;
  }
}
