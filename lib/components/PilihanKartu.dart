import 'package:flutter/material.dart';
import 'package:v1/components/Aksara.dart';
import 'package:get/get.dart';
import 'package:v1/controller/components/Pilihan.dart';
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
  var _selfController = Get.put(PilihanController());

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
                      _selfController.setPilihan(opsi);
                      _controller.setAnswered();
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
                                  ? (_controller.allowNext.value
                                      ? _controller
                                          .getColorState(opsi == option[kunci])
                                      : (_selfController.pilihan.value == opsi)
                                          ? ColorsConstant.primary
                                          : ColorsConstant.border)
                                  : ColorsConstant.border),
                          borderRadius: BorderRadius.circular(12),
                        ))),
                  );
                }).toList())
          ]),
        ),
        Obx(() => Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 30),
              color: _controller.allowNext.value
                  ? ColorsConstant.primaryShade
                  : Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(
                      _controller.allowNext.value
                          ? (_controller.isCorrect.value ? "Benar" : "Salah")
                          : "",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: _controller.isCorrect.value
                              ? ColorsConstant.sucess
                              : ColorsConstant.error),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          primary: _controller.isAnswered.value
                              ? ColorsConstant.primary
                              : ColorsConstant.primaryInactive,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          minimumSize: Size(double.infinity, 50)),
                      child: Text(_controller.allowNext.value
                          ? (_controller.isLast.value ? "selesai" : "Lanjut")
                          : "check"),
                      onPressed: () {
                        if (!_controller.isAnswered.value) return;
                        if (_controller.allowNext.value) {
                          if (_controller.isLast.value) {
                            Get.back();
                          }
                          _controller.increment();
                          _controller.resetAnswer();
                          pageController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                        } else {
                          _controller.allowNext.value = true;
                          if (_selfController.pilihan.value == option[kunci])
                            _controller.setCorrect();
                        }
                      },
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
