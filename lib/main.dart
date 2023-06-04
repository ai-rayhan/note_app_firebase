import 'package:flutter/material.dart';
import 'package:note_app_firebase/provider/tasks.dart';
import 'package:provider/provider.dart';
import 'package:stripe_payment/stripe_payment.dart';

import 'screens/add_task_screen.dart';
import 'screens/tasks_screen.dart';
import 'widgets/bottom_navigation_bar.dart';

void main() {
  // StripePayment.setOptions(
  //   StripeOptions(
  //     publishableKey: "pk_test_51NEyyFCLicb7WxzzXr1nPmEUKNiMxfbv9jxDIAA8bKAt5JNyC99H9LuWKv8QCP1Rhz3LGm3J0KoTtauIlWxumwbA00NVbsdhKA",
  //   ),
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Tasks(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyBottomNavBar(),
        routes: {
          'addtask': (ctx) => EditTaskScreen(),
        },
      ),
    );
  }
}
