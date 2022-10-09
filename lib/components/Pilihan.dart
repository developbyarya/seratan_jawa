import 'package:flutter/material.dart';
import 'package:v1/components/Aksara.dart';
import 'package:v1/constant/Color.dart';
import 'package:get/get.dart';
import 'package:v1/controller/Utama/Utama.dart';
import 'package:v1/controller/components/Pilihan.dart';
import 'package:v1/utils/lib/storeage_control/user_progress.dart';

class Pilihan extends StatelessWidget {
  final String pertanyaan;
  final int kunci;
  final List<dynamic> option;
  final PageController pageController;
  String? massage;
  Pilihan(this.pertanyaan, this.kunci, this.option, this.pageController,
      {Key? key, this.massage})
      : super(key: key);
  var _controller = Get.find<UtamaController>();
  var _selfController = Get.put(PilihanController());

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 120),
          child: Column(children: [
            Text(
              pertanyaan,
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 80,
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
                        child: TextAksara(
                          opsi,
                          size: 42,
                          color: Colors.black,
                        ),
                        alignment: Alignment.center,
                        width: 175,
                        height: 155,
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
                    child: Column(
                      children: [
                        Text(
                          _controller.allowNext.value
                              ? (_controller.isCorrect.value
                                  ? "Benar"
                                  : "Salah")
                              : "",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: _controller.isCorrect.value
                                  ? ColorsConstant.sucess
                                  : ColorsConstant.error),
                        ),
                        Text(
                          _controller.allowNext.value ? (massage ?? "") : "",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 16,
                              color: _controller.isCorrect.value
                                  ? ColorsConstant.sucess
                                  : ColorsConstant.error),
                        )
                      ],
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
                            UserProgress.setProgress(
                                _controller.id, _controller.bagian);
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
