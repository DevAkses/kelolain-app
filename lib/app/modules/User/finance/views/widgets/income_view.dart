import 'package:flutter/material.dart';
import 'package:safeloan/app/utils/warna.dart';
import 'package:safeloan/app/widgets/button_back_leading.dart';
import 'package:safeloan/app/widgets/button_widget.dart';
import 'package:safeloan/app/widgets/input_akun_widget.dart';

class IncomeView extends StatelessWidget {
  final TextEditingController nominalC = TextEditingController();
  final TextEditingController dateC = TextEditingController();
  final TextEditingController notesC = TextEditingController();
  final ValueNotifier<String> selectedCategory = ValueNotifier<String>('');

  IncomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width * 0.1;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tambah Pemasukan",
          style: Utils.header,
        ),
        centerTitle: true,
        leading: const ButtonBackLeading(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InputAkunWidget(
              nama: 'Nominal',
              hintText: '0',
              leadingIcon: Icons.attach_money,
              controller: nominalC,
            ),
            const SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: lebar, right: lebar),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Kategori',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 7, bottom: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildCategoryColumn(
                          category: 'Gaji',
                          icon: Icons.wallet,
                          selectedCategory: selectedCategory,
                        ),
                        _buildCategoryColumn(
                          category: 'Hadiah',
                          icon: Icons.card_giftcard,
                          selectedCategory: selectedCategory,
                        ),
                        _buildCategoryColumn(
                          category: 'Investasi',
                          icon: Icons.attach_money,
                          selectedCategory: selectedCategory,
                        ),
                        _buildCategoryColumn(
                          category: 'Freelance',
                          icon: Icons.work_history_rounded,
                          selectedCategory: selectedCategory,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            InputAkunWidget(
              nama: 'Tanggal',
              hintText: '15/07/2024',
              leadingIcon: Icons.date_range,
              controller: dateC,
            ),
            const SizedBox(height: 10),
            InputAkunWidget(
              nama: 'Catatan',
              hintText: 'Masukkan Catatan',
              leadingIcon: Icons.assignment,
              controller: notesC,
            ),
            const SizedBox(height: 30),
            ButtonWidget(
              onPressed: () {},
              nama: 'Tambah',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryColumn({
    required String category,
    required IconData icon,
    required ValueNotifier<String> selectedCategory,
  }) {
    return ValueListenableBuilder<String>(
      valueListenable: selectedCategory,
      builder: (context, value, child) {
        bool isSelected = value == category;
        return GestureDetector(
          onTap: () {
            selectedCategory.value = category;
          },
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isSelected ? Utils.biruLima : Colors.transparent,
                  border: Border.all(
                      color: isSelected ? Utils.biruEmpat : Colors.transparent),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  size: 35,
                  color: isSelected ? Utils.biruDua : Colors.black,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                category,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? Utils.biruDua : Colors.black,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
