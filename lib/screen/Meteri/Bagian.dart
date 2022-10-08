import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v1/screen/Meteri/Utama.dart';

class Bagian extends StatelessWidget {
  final String id;
  final String hari;
  final String bagianDesc;
  final int totalBagian;

  Bagian(this.id, this.hari, this.bagianDesc, this.totalBagian, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var instance = FirebaseFirestore.instance.collection('soal').doc(id);
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Program hari ke-$hari",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            (bagianDesc),
            style: const TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: List.generate(totalBagian, (index) => index + 1)
                  .map((e) => Container(
                        margin: EdgeInsets.only(bottom: 5),
                        child: ListTile(
                          onTap: () {
                            Get.to(() => Utama(
                                id: id,
                                totalBagian: totalBagian,
                                bagian: "bagian${e.toString()}"));
                          },
                          title: Text("Bagian ${e.toString()}"),
                          tileColor: Colors.white,
                          trailing: Icon(Icons.check_circle_outline_rounded),
                        ),
                      ))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
