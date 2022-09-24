import 'package:flutter/material.dart';
import 'package:v1/components/Aksara.dart';
import 'package:v1/constant/Color.dart';
import 'package:v1/controller/Utama/Utama.dart';
import 'package:get/get.dart';
import 'package:v1/controller/components/Multiaksara.dart';

class PertanyaanLatin extends StatelessWidget {
  final String pertanyaan;
  final List<dynamic> option;
  final int kunci;
  final PageController pageController;
  String? massage;
  PertanyaanLatin(this.pertanyaan, this.option, this.kunci, this.pageController,
      {Key? key, this.massage})
      : super(key: key);
  final _controller = Get.find<UtamaController>();
  final _selfController = Get.put(MultiaksaraController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
          child: Column(
            children: [
              const Text(
                "Terjemahkan",
                style: TextStyle(fontSize: 18),
              ),
              Text(
                pertanyaan + " :...",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(
                    children: option
                        .map((e) => InkWell(
                              onTap: () {
                                _selfController.setChoice(option.indexOf(e));
                                _controller.setAnswered();
                              },
                              child: Obx(() => Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15),
                                      child: TextAksara(
                                        e,
                                        size: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
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
                                                  ? _controller.getColorState(
                                                      kunci ==
                                                          option.indexOf(e))
                                                  : (_selfController
                                                              .choice.value ==
                                                          option.indexOf(e))
                                                      ? ColorsConstant.primary
                                                      : ColorsConstant.border)
                                              : ColorsConstant.border),
                                    ),
                                  )),
                            ))
                        .toList()),
              ),
            ],
          ),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                        ]),
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
                          if (_selfController.choice.value == kunci)
                            _controller.setCorrect();
                        }
                      },
                    ),
                  ),
                ],
              ),
            )),
      ]),
    );
  }
}
