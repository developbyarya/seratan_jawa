import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v1/components/Aksara.dart';
import 'package:v1/controller/Utama/Utama.dart';
import 'package:v1/controller/components/Cocok.dart';

import '../constant/Color.dart';

class Cocok extends StatelessWidget {
  final List<dynamic> left;
  final List<dynamic> right;
  final List<dynamic> kunci;
  final PageController pageController;
  Cocok(this.left, this.right, this.kunci, this.pageController, {Key? key})
      : super(key: key);

  var _controller = Get.find<UtamaController>();
  var _selfController = Get.put(CocokController());

  @override
  Widget build(BuildContext context) {
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
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              e,
                              style: TextStyle(
                                  color: _selfController.correct
                                          .contains(left.indexOf(e))
                                      ? ColorsConstant.border
                                      : Colors.black),
                            ),
                            alignment: Alignment.center,
                            width: 140,
                            height: 70,
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
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  alignment: Alignment.center,
                                  width: 140,
                                  height: 70,
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
                    padding: EdgeInsets.only(top: 30),
                    child: Container(
                      color: _controller.allowNext.value
                          ? ColorsConstant.primaryShade
                          : Colors.transparent,
                      height: 120,
                      width: double.infinity,
                      alignment: Alignment.topCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Text(
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
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: StadiumBorder(),
                                  primary: _selfController.correct.length ==
                                          kunci.length
                                      ? ColorsConstant.primary
                                      : ColorsConstant.primaryInactive,
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  minimumSize: Size(double.infinity, 50)),
                              child: Text(
                                  _selfController.correct.length == kunci.length
                                      ? (_controller.isLast.value
                                          ? "selesai"
                                          : "Lanjut")
                                      : "check"),
                              onPressed: () {
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
