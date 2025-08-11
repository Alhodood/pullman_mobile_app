import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pullman_mobile_app/const/dailog_widgets.dart';
import 'package:pullman_mobile_app/housekeeper/Home/model/my_task_reposnse_model.dart';
import 'package:pullman_mobile_app/housekeeper/Home/model/task_model.dart';
import 'package:pullman_mobile_app/housekeeper/Home/view/detailed_screen.dart';
import 'package:pullman_mobile_app/housekeeper/service/teask_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskController  extends ChangeNotifier{
  final
  descriptionController= TextEditingController();
  bool completedAllTask=false;
  List<File>attachment=[];
  MyTask ?myTask;
  List<Datum>data=[Datum(description: "adfads",dueDate: DateTime.now().toString(),priorityLevel: "low" ),];
   List<TaskDatum> taskDataList=[];
   DateTime? workStartedTime;final teaskService= TeaskService();
bool loader=false;
  saveWorkSatrtedTime(value){
    workStartedTime=value;
    notifyListeners();
  }
  Future<void> addAttachment() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      // _loading = true;
      notifyListeners();

      final data = await File(image.path);
      attachment.add(data); 

      // _loading = false;
      notifyListeners();
    }
  }

  deleteAttachment(index){
attachment.removeAt(index);
notifyListeners();
  }
  
  Future<MyTask?> getTaskStatistics(context)async{
             final prefs = await SharedPreferences.getInstance();
  final ipAddress = prefs.getString('server_ip');
// 10.255.254.23:8069
  if(ipAddress!= null){
final data = await teaskService.getMyTask(ipAddress);

if (data!=null) {
// print("-----be for mapping--------${MyTask.fromJson(data['data'])}");
 
myTask=MyTask.fromJson(data['data']);
print("-------after mapping------${myTask}");

// log(myTask!.toJson().toString());
}

  }else{
showIPInputDialog(context);
  }
    return myTask;

}
 completAllTask(bool value){
  completedAllTask=value;
  notifyListeners();
}
getTasks(){

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

 workCompletedApi(context,duration, taskId, )async{
        final prefs = await SharedPreferences.getInstance();
  final ipAddress = prefs.getString('server_ip');
// 10.255.254.23:8069
  if(ipAddress!= null){
      loader=true;
   List<MultipartFile> tempAttachment=[];
   for(final element in attachment){
    final data= await MultipartFile.fromFile(element.path, filename:  path.basename(element.path));
 tempAttachment.add(data);
   }
               

final result= await teaskService.workCompleted(tempAttachment, duration, taskId, descriptionController.text,ipAddress);
log(result.toString());
if(result != null&& result['status']){  
   showDialog(
                          context: context,
                          builder:
                              (_) => JobCompletedDialog(duration: duration)
                        );
                        descriptionController.clear();
                        workStartedTime=null;
                        attachment.clear();
                        completedAllTask=false;
                        getTaskStatistics(context);
                        notifyListeners();

}
  }else{
    showIPInputDialog(context);

  }

}


}