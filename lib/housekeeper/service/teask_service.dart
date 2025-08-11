import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class TeaskService {
  Future<dynamic>getMyTask(String ipAddress) async {
    print("http://${ipAddress}/api/house_keeping_work");
    print(ipAddress);

    final headers = {
      'Content-Type': 'application/json',
      'Cookie':
          'session_id=gFlCKZ7mX886EwYso_AxXaZiMqW5Mt9PWoEh7WWEw9_W_E2TTTnmxVnlm6O3pwTTAdSCo_wRaqdscKquFamt',
    };

    try {
      var dio = Dio();
      var response = await dio.request(
        "http://${ipAddress}/api/house_keeping_work",
        options: Options(method: 'GET', headers: headers),
        data: {},
      );

      if (response.statusCode == 200) {
        print('✅ Upload successful: ${jsonEncode(response.data['result'])}');
        
        return response.data['result'];
      } else {
        // debugPrint('⚠️ Server error: ${response.statusCode} - ${response.statusMessage}');
        return response.data['result'];
      }
    } catch (e) {

      return null;
    }
  }

  Future<dynamic>workCompleted(List<MultipartFile> attachment,String duration,int taskId, description, String ipAddress)async{
   Map<String, dynamic> result ;
    // print(tempAttachment.runtimeType);
    try{
      var headers = {
  'Content-Type': 'application/json',
  'Cookie': 'session_id=ozTRiTK0SvMVrAQvqBgxmGsHa5viv_Mt1wJcowdoVjqyF8ffYvQ4kDVeRhYKOWMLB7N9moz0JMoD47P3YD__'
};
var data = FormData.fromMap({
  'files': attachment,
  'duration': duration,
  'task_id': taskId,
  "description":description
});

print(data.fields);
var dio = Dio();
var response = await dio.request(
  'http://${ipAddress}/api/house_keeping_work_done',
  options: Options(
    method: 'POST',
    headers: headers,
  ),
  data: data,
);
 result = jsonDecode(response.data);

if (response.statusCode == 200) {
  

  print(json.encode(response.data));
  return result;
}
else {
    return result;

}
    }catch (e){
return null;
    }
  }
}
