import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v1/constant/Color.dart';
import 'package:v1/screen/Meteri/Utama.dart';
import 'package:v1/utils/lib/storeage_control/user_progress.dart';

class Bagian extends StatefulWidget {
  final String id;
  final String hari;
  final String bagianDesc;
  final int totalBagian;

  Bagian(this.id, this.hari, this.bagianDesc, this.totalBagian, {Key? key})
      : super(key: key);

  @override
  State<Bagian> createState() => _BagianState();
}

class _BagianState extends State<Bagian> {
  @override
  Widget build(BuildContext context) {
    var instance = FirebaseFirestore.instance.collection('soal').doc(widget.id);
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
              "Program hari ke-${widget.hari}",
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            (widget.bagianDesc),
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: List.generate(widget.totalBagian, (index) => index + 1)
                  .map((e) => FutureBuilder<bool>(
                      future: UserProgress.getProgress(
                          widget.id, "bagian${e.toString()}"),
                      builder: (context, snapshot) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: ListTile(
                            onTap: () {
                              Get.to(() => Utama(
                                      id: widget.id,
                                      totalBagian: widget.totalBagian,
                                      bagian: "bagian${e.toString()}"))!
                                  .then((_) {
                                setState(() {});
                              });
                            },
                            title: Text("Bagian ${e.toString()}"),
                            tileColor: Colors.white,
                            trailing: Icon(
                              Icons.check_circle_outline_rounded,
                              color: (snapshot.data ?? false)
                                  ? ColorsConstant.sucess
                                  : null,
                            ),
                          ),
                        );
                      }))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
