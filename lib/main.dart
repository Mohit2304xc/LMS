import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dummy1/Screen/Onboarding.dart';
import 'package:dummy1/firebase_options.dart';
import 'Repository/AuthenticationRepository.dart';
import 'bindings/general_bindings.dart';

Future<void> main() async {
  //final WidgetsBinding widgetsBinding =
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'LMS',
      initialBinding: GeneralBindings(),
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const OnboardingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


