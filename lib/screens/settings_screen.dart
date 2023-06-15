import 'package:flutter/material.dart';
import 'package:note_app_firebase/provider/auth.dart';
import 'package:note_app_firebase/widgets/bottom_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../widgets/settings_tools.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  setvalue(value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool('darktheme', value);
  }

  static bool values = false;
  checkMode() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? a = await pref.getBool('darktheme');
    if (a == true) {
      values = true;
      setState(() {});
    } else {
      values = false;
      setState(() {});
    }
  }

  ///////
  ///

  @override
  void initState() {
    checkMode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor:values?Colors.black87 :Colors.deepPurpleAccent,
      appBar: AppBar(
        title: Text("Settings"),

        // actions: [
        //   const Center(child: Text("Dark Mode")),

        // ],
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView(children: [
          const Icon(
            Icons.manage_accounts_rounded,
            size: 70,
            // color: kPrimaryLight,
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Dark Mode",
                style: TextStyle(fontSize: 17),
              ),
              Switch(
                value: values,
                onChanged: (value) {
                  setState(() {
                    values = !values;
                    setvalue(value);
                  });
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const MyApp(),
                    ),
                  );
                },
              ),
            ]),
          ),
          const SizedBox(
            height: 15,
          ),
          Settings_tools(
            icon: Icons.upgrade,
            txt: "Upgrade",
            ontap: () {
              // Navigator.pushNamed(context, 'web');
            },
          ),
          Settings_tools(
            icon: Icons.assignment_outlined,
            txt: "Privacy",
            ontap: () {
              // Navigator.pushNamed(context, 'web');
            },
          ),
          Settings_tools(
            icon: Icons.logout,
            txt: "Logout",
            ontap: () {
              
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
          const SizedBox(
            height: 15,
          ),
          // Settings_tools(
          //     icon: Icons.contact_mail_outlined,
          //     txt: "Help",
          //     ontap: () async {
          //       const toEmail = 'rayhanahmed1127@gmail.com';
          //       const subject = ' ';
          //       const message = ' ';
          //       const url = 'mailto:$toEmail?subject=$subject&body=$message';
          //       if (await canLaunch(url)) {
          //         await launch(url);
          //       }
          //     }),
        ]),
      ),
    );
  }
}
