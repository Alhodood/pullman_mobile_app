import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pullman_mobile_app/Home/controller/emirate_id_controller.dart';
import 'package:pullman_mobile_app/Home/model/emirate_id_model.dart';
import 'package:pullman_mobile_app/Home/screen/pdf_view_screen.dart';
import 'package:pullman_mobile_app/const/app_typography.dart';
import 'package:pullman_mobile_app/const/dailog_widgets.dart';
import 'package:pullman_mobile_app/const/router/routes.dart';
import 'package:pullman_mobile_app/const/space_helpper.dart';
import 'package:pullman_mobile_app/housekeeper/controller/task_controller.dart';
import 'package:pullman_mobile_app/main.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';

class SignaturePdfPage extends StatefulWidget {
   SignaturePdfPage({super.key, required this.eid});
EmirateIdModel eid;
  @override
  
  State<SignaturePdfPage> createState() => _SignaturePdfPageState();
}

class _SignaturePdfPageState extends State<SignaturePdfPage> {
   
  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
  );
  @override
  void initState() {
  nameController.text=widget.eid.name;

  passportController.text=widget.eid.number;
    super.initState();
  }
  final nameController = TextEditingController();
  final passportController = TextEditingController();
  final contactController = TextEditingController();


  Future<void> generatePdfWithSignature({
    required BuildContext context,
    required Uint8List signature,
    required String name,
    required String passportNumber,
    required String contactNumber,
    required String date,
  }) async {
    final pdf = pw.Document();
    final pwImage = pw.MemoryImage(signature);

    final List<String> conditions = [
      "I, the undersigned, hereby acknowledge and agree to the terms and conditions regarding the use of the mechanical bull ride provided at the premises of PENINSULA TEAM.",
      "I understand that the mechanical bull ride is a physical activity that may involve risks including, but not limited to, falls, injuries, or accidents.",
      "I willingly choose to participate in this activity at my own risk and discretion.",
      "I confirm that I am in good health and physically fit to engage in this activity.",
      "I undertake full responsibility for my safety and well-being during the use of the bull ride.",
      "I hereby release and discharge PENINSULA TEAM, its management, staff, and affiliates from any and all liability, claims, demands, or causes of action that may arise from any injury, loss, or damage incurred during or as a result of using the mechanical bull ride.",
      "I agree to follow all instructions and safety guidelines provided by the hotel staff.",
      "This undertaking shall be binding upon me and my heirs, legal representatives, and assigns.",
    ];

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                color: PdfColor.fromHex("#6D0700"),
                child: pw.Padding(
                  padding: pw.EdgeInsets.all(10),
                  child: pw.Container(
                    color: PdfColor.fromHex("#FFFFFF"),
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.SizedBox(height: 20),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(10),
                          child: pw.Container(
                            padding: pw.EdgeInsets.all(10),
                            color: PdfColor.fromHex("#6D0700"),
                            child: pw.Text(
                              "SAFETY UNDERTAKING USE OF MECHANICAL BULL RIDE",
                              style: pw.TextStyle(
                                lineSpacing: 1,
                                fontSize: 20,
                                fontWeight: pw.FontWeight.bold,
                                color: PdfColor.fromHex("#FFFFFF"),
                              ),
                              textAlign: pw.TextAlign.center,
                            ),
                          ),
                        ),

                        pw.Padding(
                          padding: pw.EdgeInsets.symmetric(horizontal: 10),
                          child: pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.SizedBox(height: 20),
                              pw.SizedBox(height: 10),
                              pw.Text(
                                "Date: $date",
                                style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.normal,
                                ),
                              ),
                              pw.SizedBox(height: 10),

                              pw.Text(
                                "Name: $name",
                                style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.normal,
                                ),
                              ),
                              pw.SizedBox(height: 10),

                              pw.Text(
                                "Passport/ID: $passportNumber",
                                style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.normal,
                                ),
                              ),
                              pw.SizedBox(height: 10),

                              pw.Text(
                                "Contact: $contactNumber",
                                style: pw.TextStyle(
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.normal,
                                ),
                              ),
                              pw.SizedBox(height: 20),
                              pw.Text(
                                "Agreement:",
                                style: pw.TextStyle(
                                  fontSize: 16,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.SizedBox(height: 10),
                              ...List.generate(conditions.length, (index) {
                                return pw.Padding(
                                  padding: const pw.EdgeInsets.only(
                                    bottom: 8.0,
                                  ),
                                  child: pw.Row(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text(
                                        "${index + 1}. ",
                                        style: const pw.TextStyle(fontSize: 12),
                                      ),
                                      pw.Expanded(
                                        child: pw.Text(
                                          conditions[index],
                                          style: const pw.TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                              pw.SizedBox(height: 10),
                              pw.Text(
                                "I have read and understood the above and sign this document voluntarily.",
                                textAlign: pw.TextAlign.center,
                                style: pw.TextStyle(
                                  decoration: pw.TextDecoration.underline,
                                  fontSize: 14,
                                  fontWeight: pw.FontWeight.bold,
                                ),
                              ),
                              pw.SizedBox(height: 30),
                              pw.Text(
                                "Signature:",
                                style: pw.TextStyle(fontSize: 14),
                              ),
                              pw.SizedBox(height: 10),
                              pw.Image(pwImage, width: 200, height: 80),
                              pw.SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );

    final outputDir = await getApplicationDocumentsDirectory();
    final filePath = "${outputDir.path}/signed_safety_undertaking.pdf";
    final file = File(filePath);
    await file.writeAsBytes(await pdf.save());

    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PdfPreviewScreen(path: filePath,file: file),
        ),
      );
    }
  }

  @override
  void dispose() {
    _signatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //                 controller.selectDate(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {Routes.back();},
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          "Generator Document",
          style: AppText.h3b!.copyWith(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Consumer<EIDScannerProvider>(
        builder: (context, controller, _) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    color: Colors.blueAccent,
                    child: Column(
                      children: [
                        vSpaceRegular,
                        Container(
                          color: Colors.blueAccent,
                          child: Text(
                            "SAFETY UNDERTAKING USE OF MECHANICAL BULL RIDE",
                            style: AppText.h1b!.copyWith(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          await controller.selectDate(context);
                                        },
                                        child: Text(
                                          controller.dateController.text.isEmpty
                                              ? "Date:"
                                              : "Date:${controller.dateController.text}",
                                          style: AppText.b1b,
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextField(
                                    controller: nameController,
                                    decoration: const InputDecoration(
                                      labelText: "Name of Guest",
                                    ),
                                  ),
                                  vSpaceMin,
                                  TextField(
                                    controller: passportController,
                                    decoration: const InputDecoration(
                                      labelText: "Passport Number / ID",
                                    ),
                                  ),
                                  vSpaceMin,
                                  TextField(
                                    controller: contactController,
                                    decoration: const InputDecoration(
                                      labelText: "Contact Number",
                                    ),
                                  ),
                                  vSpaceMedium,
                                  Column(
                                    children: List.generate(condition.length, (
                                      index,
                                    ) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${index + 1}.",
                                            style: AppText.b1b,
                                          ),
                                          hSpaceMin,
                                          Expanded(
                                            child: Text(
                                              condition[index],
                                              style: AppText.b1b,
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                  ),
                                  vSpaceMedium,
                                  Signature(
                                    controller: _signatureController,
                                    height: 200,
                                    backgroundColor: Colors.grey[200]!,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  vSpaceMedium,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => _signatureController.clear(),
                        child: const Text("Clear"),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final controller = Provider.of<EIDScannerProvider>(
                            context,
                            listen: false,
                          );

                          if (controller.dateController.text.isEmpty) {
                            AppDialogBoxes.showPopup("Please select date");
                          } else if (nameController.text.isEmpty) {
                            AppDialogBoxes.showPopup("Please Enter Guest Name");
                          } else if (passportController.text.isEmpty) {
                            AppDialogBoxes.showPopup(
                              "Please Enter  Guest Passport Number",
                            );
                          } else if (contactController.text.isEmpty) {
                            AppDialogBoxes.showPopup(
                              "Please Enter Guest Contact Number",
                            );
                          } else {
                            final signature =
                                await _signatureController.toPngBytes();
                            if (signature != null && signature.isNotEmpty) {
                              generatePdfWithSignature(
                                context: context,
                                signature: signature,
                                name: nameController.text,
                                passportNumber: passportController.text,
                                contactNumber: contactController.text,
                                date: controller.dateController.text,
                              );
                            } else {
                              AppDialogBoxes.showPopup(
                                "Please sign the document",
                              );
                            }
                          }
                        },
                        child: const Text("Confirm & Preview PDF"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

List<String> condition = [
  "I, the undersigned, hereby acknowledge and agree to the following terms and conditions regarding the use of the mechanical bull ride provided at the premises of PENNISULA TEAM.",
  "I understand that the mechanical bull ride is a physical activity that may involve risks including, but not limited to, falls, injuries, or accidents."
      "I willingly choose to participate in this activity at my own risk and discretion.",

  "I confirm that I am in good health and physically fit to engage in this activity.",
  "I undertake full responsibility for my safety and well-being during the use of the bull ride.",

  "I hereby release and discharge PENNISULA TEAM, its management, staff, and affiliates from any and all liability, claims, demands, or causes of action that may arise from any injury, loss, or damage incurred during or as a result of using the mechanical bull ride.",
  "I agree to follow all instructions and safety guidelines provided by the hotel staff.",
  "This undertaking shall be binding upon me and my heirs, legal representatives, and assigns.",
];
