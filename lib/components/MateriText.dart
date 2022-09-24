import 'package:flutter/material.dart';
import 'package:v1/components/Aksara.dart';
import 'package:v1/controller/Utama/Utama.dart';
import 'package:get/get.dart';
import 'package:v1/constant/Color.dart';

class MateriText extends StatelessWidget {
  final String title;
  final String text;
  final PageController pageController;
  MateriText(this.title, this.text, this.pageController, {Key? key})
      : super(key: key);
  @override
  final _controller = Get.find<UtamaController>();
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 60, left: 20, right: 20),
          child: Column(
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              TextAksara(
                text.replaceAll("\\n", "\n"),
                size: 18,
                color: Colors.black,
              ),
            ],
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
