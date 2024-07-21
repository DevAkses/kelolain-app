import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safeloan/app/widgets/loading.dart';
import 'package:safeloan/firebase_options.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'app/modules/Auth/login/controllers/login_controller.dart';
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
          if (snapshot.data != null && snapshot.data!.emailVerified == true) {
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(snapshot.data!.uid)
                  .get(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.done) {
                  if (userSnapshot.data != null && userSnapshot.data!.exists) {
                    String role = userSnapshot.data!['role'];
                    if (role == 'Pengguna') {
                      return GetMaterialApp(
                        debugShowCheckedModeBanner: false,
                        title: "Application",
                        initialRoute: Routes.NAVIGATION,
                        getPages: AppPages.routes,
                      );
                    } else if (role == 'Konselor') {
                      return GetMaterialApp(
                        debugShowCheckedModeBanner: false,
                        title: "Application",
                        initialRoute: Routes.NAVIGATION_KONSELOR,
                        getPages: AppPages.routes,
                      );
                    } else if (role == 'Admin') {
                      return GetMaterialApp(
                        debugShowCheckedModeBanner: false,
                        title: "Application",
                        initialRoute: Routes.NAVIGATION_ADMIN,
                        getPages: AppPages.routes,
                      );
                    }
                  }
                }
                return const LoadingView();
              },
            );
          } else {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: "Application",
              initialRoute: Routes.LOGIN,
              getPages: AppPages.routes,
            );
          }
        } else {
          return const LoadingView();
        }
      },
    );
  }
}
