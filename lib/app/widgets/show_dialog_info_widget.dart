import 'package:flutter/material.dart';
import 'package:safeloan/app/utils/warna.dart';
import 'package:safeloan/app/widgets/button_widget.dart';

void showDialogInfoWidget(
    judul, linkImage, onPressed, buttonName, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Utils.backgroundCard),
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                judul,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Image.asset(
                linkImage,
                scale: 3,
              ),
              SizedBox(height: 15,),
              ButtonWidget(onPressed: onPressed, nama: buttonName)
            ],
          ),
        ),
      );
    },
  );
}
