import 'package:get/get.dart';
import 'package:v1/constant/Color.dart';

class UtamaController extends GetxController {
  var progress = 1.obs;
  var isLast = false.obs;
  var isCorrect = false.obs;
  var isAnswered = false.obs;
  increment() => progress++;
  setLastPage() => isLast.value = true;
  setCorrect() => isCorrect.value = true;
  setAnswered() => isAnswered.value = true;
  resetAnswer() {
    isCorrect.value = false;
    isAnswered.value = false;
  }

  getColorState(bool theAnswer) {
    if (isAnswered.value && isCorrect.value && theAnswer) {
      return ColorsConstant.sucess;
    } else if (isAnswered.value && isCorrect.value && !theAnswer) {
      return ColorsConstant.border;
    } else if (isAnswered.value && !isCorrect.value && theAnswer) {
      return ColorsConstant.sucess;
    } else if (isAnswered.value && !isCorrect.value && !theAnswer) {
      return ColorsConstant.error;
    } else {
      return ColorsConstant.border;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
