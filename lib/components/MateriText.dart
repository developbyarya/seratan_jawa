import 'package:flutter/material.dart';
import 'package:v1/components/Aksara.dart';
import 'package:v1/controller/Utama/Utama.dart';
import 'package:get/get.dart';
import 'package:v1/constant/Color.dart';
import 'package:v1/utils/lib/storeage_control/user_progress.dart';

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
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
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
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  primary: ColorsConstant.primary,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  minimumSize: const Size(double.infinity, 50)),
              child: Obx(
                  () => Text(_controller.isLast.value ? "selesai" : "Lanjut")),
              onPressed: () {
                if (_controller.isLast.value) {
                  UserProgress.setProgress(_controller.id, _controller.bagian);
                  Get.back();
                }
                _controller.increment();
                _controller.resetAnswer();
                pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease);
              },
            ),
          ),
        ),
      ],
    );
  }
}
