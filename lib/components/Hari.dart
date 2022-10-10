import 'package:flutter/material.dart';
import 'package:v1/constant/Color.dart';
import 'package:get/get.dart';
import 'package:v1/screen/Meteri/Bagian.dart';
import 'package:v1/utils/lib/storeage_control/user_progress.dart';

class Hari extends StatelessWidget {
  final String hari;
  final int totalBagian;
  final String bagianDesc;
  final String id;
  const Hari(
      {Key? key,
      required this.hari,
      required this.totalBagian,
      required this.id,
      required this.bagianDesc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.to(Bagian(id, hari, bagianDesc, totalBagian));
          },
          child: Stack(
            children: [
              FutureBuilder<double>(
                  future: UserProgress.getAllProgress(id, totalBagian),
                  builder: (context, snapshot) {
                    return Center(
                      child: SizedBox(
                        width: 120,
                        height: 120,
                        child: CircularProgressIndicator(
                          value: snapshot.data,
                          color: ColorsConstant.primary,
                          backgroundColor: ColorsConstant.primaryShade,
                          strokeWidth: 10,
                        ),
                      ),
                    );
                  }),
              Container(
                width: 100,
                alignment: Alignment.center,
                height: 100,
                child: Text(
                  hari,
                  style: TextStyle(
                      color: ColorsConstant.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 36),
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(3, 4),
                          blurRadius: 10,
                          color: ColorsConstant.shadow)
                    ]),
              )
            ],
            alignment: Alignment.center,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Hari-$hari",
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
