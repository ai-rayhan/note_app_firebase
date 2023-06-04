import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:note_app_firebase/provider/news.dart';
import 'package:note_app_firebase/provider/tasks.dart';
import 'package:provider/provider.dart';

import 'provider/auth.dart';
import 'screens/add_task_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/tasks_screen.dart';
import 'widgets/bottom_navigation_bar.dart';

void main() {
  // StripePayment.setOptions(
  //   StripeOptions(
  //     publishableKey: "pk_test_51NEyyFCLicb7WxzzXr1nPmEUKNiMxfbv9jxDIAA8bKAt5JNyC99H9LuWKv8QCP1Rhz3LGm3J0KoTtauIlWxumwbA00NVbsdhKA",
  //   ),
  // );
  Stripe.publishableKey = "pk_test_51MWx8OAVMyklfe3CsjEzA1CiiY0XBTlHYbZ8jQlGtVFIwQi4aNeGv8J1HUw4rgSavMTLzTwgn0XRlwoTVRFXyu2h00mRUeWmAf";
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
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
        
        ],
        child: Consumer<Auth>(
          builder: (context, auth, child) => MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: auth.isAuth
                ? MyBottomNavBar()
                : FutureBuilder(
                    future: auth.trytoLogIn(),
                    builder: (context, snapshot) =>
                        snapshot.connectionState == ConnectionState.waiting
                            ? CircularProgressIndicator()
                            : AuthScreen()),
            routes: {
              'addtask': (ctx) => EditTaskScreen(),
            },
          ),
        ));
  }
}
