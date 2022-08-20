import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:v1/constant/Color.dart';
import 'package:get/get.dart';
import 'package:v1/controller/Utama/Utama.dart';

class Materi extends StatelessWidget {
  final String aksara;
  final String latin;
  final PageController pageController;
  Materi(
      {required String this.aksara,
      required String this.latin,
      required PageController this.pageController,
      Key? key})
      : super(key: key);

  Widget Aksara(String aksara, {double? size = 28}) {
    return Text(
      aksara,
      style: TextStyle(
          color: Colors.white, fontFamily: 'AksaraJawa', fontSize: size),
    );
  }

  final _controller = Get.find<UtamaController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 130),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 250,
              height: 220,
              child: Stack(
                children: [
                  Align(
                    child: Aksara(
                        String.fromCharCode(int.parse(aksara, radix: 16)),
                        size: 96),
                    alignment: Alignment.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0, right: 24),
                    child: Align(
                      child: Text(
                        latin,
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                      alignment: Alignment.bottomRight,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: ColorsConstant.primary,
              ),
            ),
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
                child: Obx(() =>
                    Text(_controller.isLast.value ? "selesai" : "Lanjut")),
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
