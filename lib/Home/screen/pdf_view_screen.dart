

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:pullman_mobile_app/Home/controller/emirate_id_controller.dart';
import 'package:pullman_mobile_app/const/app_typography.dart';
import 'package:pullman_mobile_app/const/router/routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PdfPreviewScreen extends StatelessWidget {
  final String path;
  File file;
   PdfPreviewScreen({super.key, required this.path, required this.file});

  @override
  Widget build(BuildContext context) {
    final provider= Provider.of<EIDScannerProvider>(context,listen: false);
    return Scaffold(
      appBar: AppBar(leading: IconButton(onPressed: (){
        Routes.back();
      }, icon: Icon(Icons.arrow_back,color: Colors.white,)),
        centerTitle: true,
        title:  Text("PDF PREVIEW",style: AppText.h3!.copyWith(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
      ),
      body: PDFView(
        filePath: path,
        swipeHorizontal: false,
        autoSpacing: true,
        pageSnap: true,
      ),floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
          provider.apiLoader?CircularProgressIndicator():  GestureDetector(onTap: () async{
                     final prefs = await SharedPreferences.getInstance();
  final ipAddress = prefs.getString('server_ip');
// 10.255.254.23:8069
  if(ipAddress!= null){
  
            // provider.uploadEidDetails(ipAddress,file);

  }else{
showIPInputDialog(context);
  }
      },child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(padding: EdgeInsets.all(10),
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.blueAccent,borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Text("Upload".toUpperCase(),style: AppText.b1b!.copyWith(color: Colors.white),textAlign: TextAlign.center, ),),
      )),
    );
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
          hintText: "e.g., 192.168.1.100",
        ),
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

