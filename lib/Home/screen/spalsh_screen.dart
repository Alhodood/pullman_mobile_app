import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pennisula_group/Home/screen/home_screen.dart';
import 'package:pennisula_group/authentication/view/login_screen.dart';
import 'package:pennisula_group/const/app_typography.dart';
import 'package:pennisula_group/const/router/routes.dart';
import 'package:pennisula_group/const/space_helpper.dart';
import 'package:pennisula_group/const/ui_utils/custom_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {

    Timer(
        Duration(seconds: 3),
        () {
    showIPInputDialog(context);
           Routes.pushRemoveUntil(screen:LoginScreen() );
       
        });
    return  Scaffold(body: SizedBox(width: double.infinity,height: double.infinity,
      child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height/2.5),
                    // Image.asset("AppImages.logoWithName",width: MediaQuery.of(context).size.width/2.5,),
   SvgPicture.asset("assets/logo.svg",width: MediaQuery.of(context).size.width/2.5,),
        // Icon(Icons.hotel_class_outlined,color: Colors.blue,size: 80,),
        Text("PUllMAN Group".toUpperCase(),
        style: AppText.b1b!.copyWith(color:primaryColor ),textAlign: TextAlign.center,),
       
          Spacer(),Text("Version 0.1",style: AppText.l1b,textAlign: TextAlign.center,),vSpaceRegular
        ]
      )
    ));
  }

 Future<void> showIPInputDialog(BuildContext context) async {
  final TextEditingController ipController = TextEditingController();

  // Load existing IP if available
  final prefs = await SharedPreferences.getInstance();
  // ipController.text = prefs.getString('server_ip') ?? '';

  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Enter Server IP"),
      content: TextField(
        controller: ipController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          hintText: "e.g., 192.168.1.100"
        )
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () async {
            final ip = ipController.text.trim();
            if (ip.isNotEmpty) {
              await prefs.setString('server_ip', ip);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("IP Saved: $ip")),
              );
            }
          },
          child: const Text("Save"),
        ),
      ],
    ),
  );
}

}