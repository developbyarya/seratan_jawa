import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v1/controller/Utama/Utama.dart';
import 'package:v1/controller/components/KetikJawaban.dart';
import '../constant/Color.dart';
import 'Aksara.dart';

class KetikJawaban extends StatelessWidget {
  final PageController pageController;
  final double appBarHeight;
  KetikJawaban(this.appBarHeight, this.pageController, {Key? key})
      : super(key: key);

  var _controller = Get.find<UtamaController>();
  var _selfController = Get.put(KetikJawabanController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height - appBarHeight),
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
                      child: TextAksara(
                          String.fromCharCode(int.parse("A9A2", radix: 16)),
                          size: 72),
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
                      _selfController.setJawaban(e);
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
                      child:
                          Text(_controller.isLast.value ? "selesai" : "Lanjut"),
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
        ),
      ),
    );
  }
}
