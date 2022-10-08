import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:v1/components/Hari.dart';
import 'package:get/get.dart';
import 'package:v1/controller/home/Home.dart';
import 'package:connectivity/connectivity.dart';

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
      appBar: AppBar(
        title: Image.asset(
          "assets/Logos.png",
          height: 50,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 40, left: 10),
              child: Text(
                "Sugeng, ${getSapaan()}\n",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              alignment: Alignment.topLeft,
            ),
            StreamBuilder(
                stream: Connectivity().onConnectivityChanged,
                builder: (context, snapshot) {
                  switch (snapshot.data) {
                    case ConnectivityResult.none:
                      return Text("No Internet Connection!");
                    case ConnectivityResult.wifi:
                    case ConnectivityResult.mobile:
                      return ProgramHari(soal: soal);
                    default:
                      return Text("No Internet Connection!");
                  }
                }),
          ],
        ),
      ),
    );
  }
}

class ProgramHari extends StatelessWidget {
  const ProgramHari({
    Key? key,
    required this.soal,
  }) : super(key: key);

  final CollectionReference<Map<String, dynamic>> soal;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: soal.get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Something Went Error! please try again later!");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Expanded(
              child: ListView(children: [
                SizedBox(
                  height: 30,
                ),
                ...snapshot.data!.docs.map((e) {
                  Map<String, dynamic> data = e.data() as Map<String, dynamic>;
                  return Hari(
                      hari: data["ke"],
                      progrss: 0,
                      totalBagian: data["chapter"],
                      id: e.id,
                      bagianDesc: data["deskripsi"]);
                }).toList()
              ]),
            );
          }
          return Container(
            child: const Center(child: CircularProgressIndicator()),
            width: 200,
            height: 200,
            alignment: Alignment.center,
          );
        });
  }
}
