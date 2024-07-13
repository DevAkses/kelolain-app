import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:safeloan/app/utils/AppColors.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String nama;
  final Color color;

  const ButtonWidget({
    super.key, 
    required this.onPressed, 
    required this.nama,
    this.color = Colors.blue, // Warna default adalah biru
  });

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width * 0.8;
    return SizedBox(
      width: lebar,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.textHijauTua, // Mengatur warna tombol
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Mengurangi nilai dari 10 menjadi 4
          ),
        ),
        onPressed: onPressed,
        child: Text(nama, style: const TextStyle(color: AppColors.textPutih, fontSize: 16, fontWeight: FontWeight.bold),),
      ),
    );
  }
}
