import 'package:flutter/material.dart';
import 'package:v1/components/Aksara.dart';
import 'package:v1/constant/Color.dart';
import 'package:get/get.dart';
import 'package:v1/controller/Utama/Utama.dart';

class Pilihan extends StatelessWidget {
  final pertanyaan;
  final kunci;
  final List<dynamic> option;
  final PageController pageController;
  Pilihan(this.pertanyaan, this.kunci, this.option, this.pageController,
      {Key? key})
      : super(key: key);

  var _controller = Get.find<UtamaController>();

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
                      if (!_controller.isAnswered.value) {
                        if (opsi == option[kunci]) {
                          _controller.setCorrect();
                        }
                        _controller.setAnswered();
                      }
                    },
                    child: Obx(() => Container(
                        child: TextAksara(
                          String.fromCharCode(int.parse(opsi, radix: 16)),
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
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  primary: ColorsConstant.primary,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  minimumSize: Size(double.infinity, 50)),
              child: Obx(
                  () => Text(_controller.isLast.value ? "selesai" : "Lanjut")),
              onPressed: () {
                if (_controller.isLast.value) {
                  Get.back();
                }
                _controller.increment();
                _controller.resetAnswer();
                pageController.nextPage(
                    duration: Duration(milliseconds: 500), curve: Curves.ease);
              },
            ),
          ),
        ),
      ],
    );
  }
}
