import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v1/controller/Utama/Utama.dart';
import 'package:v1/controller/components/KetikJawaban.dart';
import '../constant/Color.dart';
import 'Aksara.dart';

class KetikJawaban extends StatelessWidget {
  final PageController pageController;
  final double appBarHeight;
  final pertanyaan, kunci;
  KetikJawaban(
      this.pertanyaan, this.kunci, this.appBarHeight, this.pageController,
      {Key? key})
      : super(key: key);

  var _controller = Get.find<UtamaController>();
  var _selfController = Get.put(KetikJawabanController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height - appBarHeight - 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 60, left: 20, right: 20),
              child: Column(
                children: [
                  Container(
                    width: 250,
                    height: 220,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: ColorsConstant.primary,
                    ),
                    child: Align(
                      child: TextAksara(pertanyaan, size: 72),
                      alignment: Alignment.center,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    "Bunyi karakter di atas adalah...",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextField(
                    onChanged: (e) {
                      if (e == "") {
                        _controller.removeAnswered();
                      } else {
                        _controller.setAnswered();
                      }
                      _selfController.setJawaban(e.toLowerCase());
                    },
                    decoration: InputDecoration(
                      hintText: "Ketik jawaban anda",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                    ),
                    scrollPadding: EdgeInsets.all(40),
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
                        child: Text(
                          _controller.allowNext.value
                              ? (_controller.isCorrect.value
                                  ? "Benar"
                                  : "Salah \n Jawaban: $kunci")
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
                              ? (_controller.isLast.value
                                  ? "selesai"
                                  : "Lanjut")
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
                              if (kunci.toString().trim() ==
                                  _selfController.jawaban.value) {
                                _controller.setCorrect();
                              }
                              _controller.setAnswered();
                              _controller.allowNext.toggle();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
