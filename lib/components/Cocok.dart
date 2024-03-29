import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v1/components/Aksara.dart';
import 'package:v1/controller/Utama/Utama.dart';
import 'package:v1/controller/components/Cocok.dart';
import 'package:v1/utils/lib/storeage_control/user_progress.dart';

import '../constant/Color.dart';

class Cocok extends StatelessWidget {
  final List<dynamic> left;
  final List<dynamic> right;
  final List<dynamic> kunci;
  final PageController pageController;
  String? massage;
  Cocok(this.left, this.right, this.kunci, this.pageController,
      {Key? key, this.massage})
      : super(key: key);

  final _controller = Get.find<UtamaController>();
  final _selfController = Get.put(CocokController());

  @override
  Widget build(BuildContext context) {
    _selfController.resetEverything();
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Cocokan!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: left.map((e) {
                      return InkWell(
                        onTap: () {
                          var indexSekarang = left.indexOf(e);
                          _selfController.setLeftChoice(indexSekarang);
                          if (_selfController.rightChoice != -1) {
                            if (_selfController.rightChoice ==
                                kunci[indexSekarang]) {
                              _selfController.appendCorrect(indexSekarang);
                              _selfController.resetChoice();
                            } else {
                              _selfController.resetChoice();
                            }
                          }
                        },
                        child: Obx(() => Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              e,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: _selfController.correct
                                          .contains(left.indexOf(e))
                                      ? ColorsConstant.border
                                      : Colors.black),
                            ),
                            alignment: Alignment.center,
                            width: 160,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(0, 4),
                                    blurRadius: 4,
                                    color: ColorsConstant.shadow)
                              ],
                              border: Border.all(
                                  width: 1,
                                  color: _selfController.correct
                                          .contains(left.indexOf(e))
                                      ? ColorsConstant.sucess
                                      : (_selfController.leftChoice.value ==
                                              left.indexOf(e)
                                          ? ColorsConstant.primary
                                          : ColorsConstant.border)),
                              borderRadius: BorderRadius.circular(12),
                            ))),
                      );
                    }).toList()),
                Column(
                  children: [
                    ...right
                        .map((e) => InkWell(
                              child: Obx(() => Container(
                                  child: TextAksara(
                                    e,
                                    color: _selfController.correct.contains(
                                            kunci.indexOf(right.indexOf(e)))
                                        ? ColorsConstant.border
                                        : Colors.black,
                                    size: 24,
                                  ),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  alignment: Alignment.center,
                                  width: 160,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          offset: const Offset(0, 4),
                                          blurRadius: 4,
                                          color: ColorsConstant.shadow)
                                    ],
                                    border: Border.all(
                                        width: 1,
                                        color: _selfController.correct.contains(
                                                kunci.indexOf(right.indexOf(e)))
                                            ? ColorsConstant.sucess
                                            : (_selfController
                                                        .rightChoice.value ==
                                                    right.indexOf(e)
                                                ? ColorsConstant.primary
                                                : ColorsConstant.border)),
                                    borderRadius: BorderRadius.circular(12),
                                  ))),
                              onTap: () {
                                var indexSekarang = right.indexOf(e);
                                _selfController.setRightChoice(indexSekarang);
                                if (_selfController.leftChoice.value != -1) {
                                  if (kunci[_selfController.leftChoice.value] ==
                                      indexSekarang) {
                                    _selfController.appendCorrect(
                                        _selfController.leftChoice.value);
                                    if (_selfController.correct.length ==
                                        kunci.length) {
                                      _controller.setAnswered();
                                      _controller.setCorrect();
                                      _controller.allowNext.toggle();
                                    }
                                    _selfController.resetChoice();
                                  } else {
                                    _selfController.resetChoice();
                                  }
                                }
                              },
                            ))
                        .toList()
                  ],
                )
              ],
            ),
          ),
          Obx(() => IntrinsicHeight(
                child: Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(
                      color: _controller.allowNext.value
                          ? ColorsConstant.primaryShade
                          : Colors.transparent,
                      height: 180,
                      width: double.infinity,
                      alignment: Alignment.topCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25, top: 30),
                            child: Text(
                              _controller.allowNext.value
                                  ? (_controller.isCorrect.value
                                      ? "Benar \n ${massage ?? ""}"
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
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                  primary: _selfController.correct.length ==
                                          kunci.length
                                      ? ColorsConstant.primary
                                      : ColorsConstant.primaryInactive,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  minimumSize: const Size(double.infinity, 50)),
                              child: Text(
                                  _selfController.correct.length == kunci.length
                                      ? (_controller.isLast.value
                                          ? "selesai"
                                          : "Lanjut")
                                      : "check"),
                              onPressed: () {
                                if (_controller.allowNext.value ||
                                    _selfController.correct.length ==
                                        kunci.length) {
                                  if (_controller.isLast.value) {
                                    UserProgress.setProgress(
                                        _controller.id, _controller.bagian);
                                    Get.back();
                                  }
                                  _controller.increment();
                                  _controller.resetAnswer();
                                  pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.ease);
                                } else {
                                  return;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
