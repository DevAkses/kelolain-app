import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../utils/AppColors.dart';
import '../controllers/homepage_konselor_controller.dart';

class HomepageKonselorView extends GetView<HomepageKonselorController> {
  const HomepageKonselorView({Key? key}) : super(key: key);
  Widget ButtonAjukan(VoidCallback onPressed) {
    return SizedBox(
      width: 150,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.textHijauTua,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: const Text(
          "Ajukan",
          style: TextStyle(
              color: AppColors.textPutih,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget CardItem(String linkGambar, String namaKonselor, String keahlian,
      String tanggal, String waktu, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      child: Card.outlined(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(linkGambar),
                ),
                title: Text(namaKonselor),
                subtitle: Text(keahlian),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.event,
                    size: 16,
                  ),
                  const Text(
                    "Tanggal: ",
                    style:
                        TextStyle(fontSize: 16, color: AppColors.textHijauTua),
                  ),
                  Text(tanggal)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.access_time,
                    size: 16,
                  ),
                  const Text(
                    " Durasi: ",
                    style:
                        TextStyle(fontSize: 16, color: AppColors.textHijauTua),
                  ),
                  Text(waktu)
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ButtonAjukan(onPressed),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CardItem(
          "https://via.placeholder.com/150",
          "Dev Akses",
          "Dokter Cinta",
          "Senin, 20 Januari",
          "30 Menit",
          () {},
        ),
        CardItem(
          "https://via.placeholder.com/150",
          "John Doe",
          "Psikolog",
          "Selasa, 21 Januari",
          "45 Menit",
          () {},
        ),
      ],
    );
  }
}
