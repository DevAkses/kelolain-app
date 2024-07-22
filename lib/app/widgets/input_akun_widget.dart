import 'package:flutter/material.dart';
import 'package:safeloan/app/utils/warna.dart';

class InputWidget extends StatelessWidget {
  final String judul;
  final String hint;
  final TextEditingController controller;

  const InputWidget(
      {super.key,
      required this.judul,
      required this.hint,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width * 0.8;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(judul, style: const TextStyle(color: Utils.biruSatu, fontSize: 16, fontWeight: FontWeight.bold),),
        const SizedBox(height: 5),
        SizedBox(
          height: 50,
          width: lebar,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              border: const OutlineInputBorder()
            ),
          ),
        ),
      ],
    );
  }
}
