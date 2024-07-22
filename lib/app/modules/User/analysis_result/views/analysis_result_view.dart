import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safeloan/app/utils/warna.dart';
import '../controllers/analysis_result_controller.dart';

class AnalysisResultView extends GetView<AnalysisResultController> {
  const AnalysisResultView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hasil Analisis',
          style: Utils.header,
        ),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Image(
                  image: AssetImage('assets/images/maskot.png'),
                  width: 40,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            SizedBox(width: 3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  BubbleSpecialOne(
                    text: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Amet aspernatur mollitia repudiandae officia magnam beatae molestiae libero culpa, accusamus dolorum maiores id quasi consectetur magni voluptatibus vitae, ipsa assumenda velit! Fugiat nemo quasi distinctio accusamus dignissimos corporis rerum magni obcaecati excepturi possimus, autem ut deserunt velit molestiae sequi repudiandae doloribus optio perspiciatis ipsa. Porro doloremque ut in facere aperiam possimus veniam, quaerat dolores ipsum alias quisquam ad, eius eligendi. Inventore aperiam magni modi accusamus, harum nisi enim quidem eveniet repudiandae, esse quaerat minima ipsum voluptas cupiditate odio sunt repellat ipsa assumenda! Quod quibusdam voluptate incidunt asperiores aliquam tempore voluptatibus explicabo. sfhbhdbhdsghvgdhvfgsdvgvdsgvfdsvhjsfbbbbbbbbbbhfrurugygydvuuvsdvsasavyysa',
                    isSender: false,
                    color: Utils.biruLima,
                    textStyle: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
