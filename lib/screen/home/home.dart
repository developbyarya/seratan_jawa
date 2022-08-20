import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:v1/components/Hari.dart';
import 'package:get/get.dart';
import 'package:v1/controller/home/Home.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  getSapaan() {
    int jam = int.parse(DateFormat("kk").format(DateTime.now()));

    if (jam >= 3 && jam <= 10) {
      return "Enjing";
    } else if (jam > 10 && jam <= 14) {
      return "Siyang";
    } else if (jam > 14 || jam < 3) {
      return "Sonten";
    }
  }

  final mainController = Get.put(HomeController());
  var soal = FirebaseFirestore.instance.collection('soal');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 40, left: 10),
              child: Text(
                "Sugeng, ${getSapaan()}\n",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            FutureBuilder<QuerySnapshot>(
                future: soal.get(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text(
                        "Something Went Error! please try again later!");
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Column(
                        children: snapshot.data!.docs.map((e) {
                      Map<String, dynamic> data =
                          e.data() as Map<String, dynamic>;
                      return Hari(
                          hari: data["ke"],
                          progrss: 0,
                          totalBagian: data["chapter"],
                          id: e.id,
                          bagianDesc: data["deskripsi"]);
                    }).toList());
                  }
                  return const CircularProgressIndicator();
                }),
          ],
        ),
      ),
    );
  }
}
