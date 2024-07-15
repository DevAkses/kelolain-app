import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:safeloan/app/widgets/loading.dart';
import 'package:safeloan/firebase_options.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'app/modules/login/controllers/login_controller.dart';
import 'app/routes/app_pages.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authC = Get.put(LoginController(), permanent: true);

  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authC.streamAuthStatus,
      builder: (context, snapshot) {
        if (kDebugMode) {
          print(snapshot);
        }
        if (snapshot.connectionState == ConnectionState.active) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Application",
            initialRoute:
                snapshot.data != null && snapshot.data!.emailVerified == true
                    ? Routes.NAVIGATION
                    : Routes.LOGIN,
            getPages: AppPages.routes,
          );
        } else {
          return const LoadingView();
        }
      },
    );
  }
}


