import 'package:flutter/material.dart';
import 'package:v1/components/Aksara.dart';
import 'package:get/get.dart';
import '../constant/Color.dart';
import '../controller/Utama/Utama.dart';

class PilihanKartu extends StatelessWidget {
  final pertanyaan;
  final kunci;
  final List<dynamic> option;
  final PageController pageController;

  PilihanKartu(this.pertanyaan, this.kunci, this.option, this.pageController,
      {Key? key})
      : super(key: key);

  var _controller = Get.find<UtamaController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 60, left: 20, right: 20),
          child: Column(children: [
            Container(
              width: 250,
              height: 220,
              child: Stack(
                children: [
                  Align(
                    child: TextAksara(
                        String.fromCharCode(int.parse(pertanyaan, radix: 16)),
                        size: 72),
                    alignment: Alignment.center,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: ColorsConstant.primary,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: option.map((opsi) {
                  return InkWell(
                    onTap: () {
                      if (!_controller.isAnswered.value) {
                        if (opsi == option[kunci]) {
                          _controller.setCorrect();
                        }
                        _controller.setAnswered();
                      }
                    },
                    child: Obx(() => Container(
                        child: Text(
                          opsi,
                          style: TextStyle(
                            fontSize: 42,
                            color: Colors.black,
                          ),
                        ),
                        alignment: Alignment.center,
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 4),
                                blurRadius: 4,
                                color: ColorsConstant.shadow)
                          ],
                          border: Border.all(
                              width: 1,
                              color: _controller.isAnswered.value
                                  ? _controller
                                      .getColorState(opsi == option[kunci])
                                  : ColorsConstant.border),
                          borderRadius: BorderRadius.circular(12),
                        ))),
                  );
                }).toList())
          ]),
        ),
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Obx(() => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      primary: _controller.isAnswered.value
                          ? ColorsConstant.primary
                          : ColorsConstant.primaryInactive,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      minimumSize: Size(double.infinity, 50)),
                  child: Text(_controller.isLast.value ? "selesai" : "Lanjut"),
                  onPressed: () {
                    if (_controller.isLast.value) {
                      Get.back();
                    }
                    _controller.increment();
                    _controller.resetAnswer();
                    pageController.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease);
                  },
                )),
          ),
        ),
      ],
    );
  }
}
