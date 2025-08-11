import 'dart:convert';
import 'dart:developer';
import 'dart:io';
// import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pennisula_group/Home/model/emirate_id_model.dart';
import 'package:pennisula_group/Home/screen/home_screen.dart';
import 'package:pennisula_group/Home/service/eid_scanner.dart';
import 'package:pennisula_group/const/dailog_widgets.dart';
import 'package:pennisula_group/const/router/routes.dart';
import 'package:provider/provider.dart';

class EIDScannerProvider extends ChangeNotifier {
  final numberController= TextEditingController();
  final remarkController= TextEditingController();

  final eIDScannerService=EIDScannerService();
  EmirateIdModel? _eidData;
  bool _loading = false;
bool apiLoader=false;
  EmirateIdModel? get eidData => _eidData;
  bool get isLoading => _loading;
int guestWithYou=0;
String ? selectedKey, selectedVisiter, selectedAttentedBy;
List<String>GuestList=[];
selectKey(value){
  selectedKey=value;
  notifyListeners();
}
selectVisiterType(value){
  selectedVisiter=value;
  notifyListeners();
  
}selectAttendedBy(value){
    selectedAttentedBy=value;
  notifyListeners();
}

// addGuest(value){
//   GuestList.add(value);
 
//   notifyListeners();
// }deleteGuest(index){
//   GuestList.removeAt(index);
//   notifyListeners();
// }changeGusetWidget(value){
//     selectedKey=value;
//   notifyListeners();
// }

  Future<void> scanEIDCard() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      _loading = true;
      notifyListeners();

      final data = await EIDScannerService.scanEmirateId(image: File(image.path));
      _eidData = data;

      _loading = false;
      notifyListeners();
    }
  }

  void clearData() {
    _eidData = null;
    dateController.clear();
    selectedKey=null;
    selectedAttentedBy=null;
    selectedVisiter=null;
    numberController.clear();
    remarkController.clear();
    notifyListeners();
  }
  uploadEidDetails(ipAddress,date// File element
  )async{
    apiLoader=true;
    notifyListeners();
    if(_eidData != null){
_eidData?.keyLog=selectedKey;
_eidData?.visiterType=selectedVisiter;
_eidData?.selectAttendedBy=selectedAttentedBy;
_eidData?.remark=remarkController.text;
_eidData?.currentDate=date;

// _eidData?.number=remarkController.text;

// print("befor api call");
 final response= await   eIDScannerService.uploadEmiratesId(_eidData!,ipAddress,
 );
 apiLoader=false;
    notifyListeners();
if(response!= null){

print("------------99-----$response");
final temp=jsonDecode(response);
// print("----------55555-------${temp.runtimeType}");
// print("----------esrdtyu-------${response['data']}");
// print("-------rtt678----------${response['message']}");
// print("--------------6t78---${response['status'].runtimeType}");
// print("----gdf-------------${response['data'].runtimeType}");
// print("----rd-------------${response['message'].runtimeType}");

if(temp['status'].toString()=='true')
{

// print("--------000999------------$response");

  AppDialogBoxes.showPopup(temp['message']);
clearData();
Routes.pushreplace(screen: EIDScannerScreen());
}else{
  // print("------------iijjjjh---------$response");

    AppDialogBoxes.showPopup(temp['message']);

}
}else{

  AppDialogBoxes.showPopup("Something went wrong. Please try later");
}
    }
    apiLoader=false;
    notifyListeners();
  }

  TextEditingController dateController = TextEditingController();

Future<void> selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime(2100),
  );
  if (picked != null) {
    dateController.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
  }
  notifyListeners();
}

}
