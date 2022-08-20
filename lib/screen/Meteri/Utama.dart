import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:v1/components/Materi.dart';
import 'package:v1/components/Pilihan.dart';
import 'package:v1/constant/Color.dart';
import 'package:v1/controller/Utama/Utama.dart';
import 'package:v1/screen/Meteri/Bagian.dart';
import 'package:get/get.dart';

import '../../components/PilihanKartu.dart';

class Utama extends StatelessWidget {
  final String id;
  final int totalBagian;
  final String bagian;

  Utama(
      {required this.id,
      required this.totalBagian,
      required this.bagian,
      Key? key})
      : super(key: key);

  final _controller = Get.put(UtamaController());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection("soal")
            .doc(id)
            .collection(bagian)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            PageController pageController = PageController();
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                leading: CloseButton(color: Colors.black),
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Obx(() => ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(9999)),
                      child: LinearProgressIndicator(
                        value: _controller.progress / totalBagian,
                        minHeight: 15,
                      ),
                    )),
                actions: [
                  Container(
                    child: Obx(() => Text(
                          "${_controller.progress}/$totalBagian",
                          style: TextStyle(color: Colors.black),
                        )),
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(right: 15),
                  )
                ],
              ),
              body: PageView(
                controller: pageController,
                onPageChanged: (index) {
                  if (index + 1 == totalBagian) {
                    print("yeay terakhir");
                    _controller.setLastPage();
                  }
                },
                children: snapshot.data!.docs.map((e) {
                  Map<String, dynamic> soalResult =
                      e.data() as Map<String, dynamic>;
                  print("hello");
                  if (soalResult["tipe"] == "materi") {
                    return Materi(
                      aksara: soalResult["data"]["aksara"]
                          .toString()
                          .split("\\u")
                          .sublist(1)[0],
                      latin: soalResult["data"]["latin"],
                      pageController: pageController,
                    );
                  } else if (soalResult["tipe"] == "pilihan") {
                    return Pilihan(
                        soalResult["data"]["pertanyaan"],
                        soalResult["data"]["kunciIndex"],
                        soalResult["data"]["option"],
                        pageController);
                  } else if (soalResult["tipe"] == "pilihan_kartu") {
                    return PilihanKartu(
                        soalResult["data"]["pertanyaan"],
                        soalResult["data"]["kunciIndex"],
                        soalResult["data"]["option"],
                        pageController);
                  }

                  return Text("Apalah gitu");
                }).toList(),
                physics: NeverScrollableScrollPhysics(),
              ),
            );
          }

          return Scaffold(
              backgroundColor: Colors.brown, body: CircularProgressIndicator());
        });
  }

  @override
  void dispose() {
    print("Element Removed");
  }
}
