import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:intl/intl.dart';
import 'package:pennisula_group/Home/model/emirate_id_model.dart';
import 'package:path/path.dart' as path;


class EIDScannerService {
 static EmirateIdModel? collectedData;
  static Future<EmirateIdModel?> scanEmirateId({required File image}) async {
    List<String> eIdDates = [];
    final textDetector = GoogleMlKit.vision.textRecognizer();
    final recognizedText = await textDetector.processImage(
      InputImage.fromFilePath(image.path),
    );

    final text = recognizedText.text.toLowerCase();
    if (!text.contains("resident identity card") && !text.contains("united arab emirates")) {
      return null;
    }

    final lines = recognizedText.text.split('\n');
    String? name, number, nationality, sex;

    for (var line in lines.map((e) => e.trim())) {
      if (_isDate(line)) {
        eIdDates.add(line);
      } else if (_isNumberID(line)) {
        number = line;
      } else {
        name ??= _parseField(line, "Name:");
        nationality ??= _parseField(line, "Nationality");
        sex ??= _parseField(line, "Sex:");
      }
    }

    eIdDates = _sortDates(eIdDates);
    textDetector.close();

    if (name == null || number == null) return null;

     
  return  collectedData=
    EmirateIdModel(
      name: name,
      number: number,
      nationality: nationality,
      sex: sex,
      dateOfBirth: eIdDates.length > 0 ? eIdDates[0] : null,
      issueDate: eIdDates.length > 1 ? eIdDates[1] : null,
      expiryDate: eIdDates.length > 2 ? eIdDates[2] : null,
    );
  }

  static bool _isDate(String text) =>
      RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(text);

  static bool _isNumberID(String text) =>
      RegExp(r'^\d{3}-\d{4}-\d{7}-\d{1}$').hasMatch(text);

  static String? _parseField(String line, String prefix) =>
      line.startsWith(prefix) ? line.replaceFirst(prefix, '').trim() : null;

  static List<String> _sortDates(List<String> dates) {
    final format = DateFormat("dd/MM/yyyy");
    final dateList = dates.map((d) => format.parse(d)).toList()..sort();
    return dateList.map((d) => format.format(d)).toList();
  }



Future<dynamic> uploadEmiratesId(EmirateIdModel req, String ipAddress
// ,File data
) async {
// print("hi");
  //  final fileName = path.basename(data.path);
  final headers = {
    'Content-Type': 'application/http',
    'Cookie': 'session_id=gFlCKZ7mX886EwYso_AxXaZiMqW5Mt9PWoEh7WWEw9_W_E2TTTnmxVnlm6O3pwTTAdSCo_wRaqdscKquFamt'
  };
  final formData = FormData.fromMap({
      "name": req.name,
    "date_Of_birth": req.dateOfBirth,
    "issue_date": req.issueDate,
    "expiry_date": req.expiryDate,
    "nationality": req.nationality,
    "eid_number": req.number,"sex":req.sex, 
    "number":req.number,
    "currentDate" :req.currentDate,
"keyLog"  :req.keyLog,
"visiterType": req.visiterType,
"attendedBy" :req.selectAttendedBy,
"remarks" : req.remark
    
      // 'file': await MultipartFile.fromFile(data.path, filename: fileName),
    });
    // print(fileName);
  // final body = jsonEncode({
  //   "name": req.name,
  //   "date_Of_birth": req.dateOfBirth,
  //   "issue_date": req.issueDate,
  //   "expiry_date": req.expiryDate,
  //   "nationality": req.nationality,
  //   "eid_number": req.number,"sex":req.sex, 
  //   "attachment":data
  // });


  try {
    final dio = Dio();
    final response = await dio.post(
      'http://$ipAddress/api/emirates_id_for_registration',
      options: Options(headers: headers),
      data: formData
    );

    if (response.statusCode == 200) {
      // debugPrint('✅ Upload successful: ${jsonEncode(response.data)}');
return (response.data);
    } else {
      print(response.data);
      debugPrint('⚠️ Server error: ${response.statusCode} - ${response.statusMessage}');
      return jsonEncode(response.data);
    }
  } catch (e) {
    // debugPrint('❌ Upload failed: $e');
    return null;
  }
}

  }


  

