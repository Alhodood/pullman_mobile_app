// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(body: Center(child: ElevatedButton(onPressed: ()async{
//       var headers = {
//   'Content-Type': 'application/json',
//   'Cookie': 'session_id=gFlCKZ7mX886EwYso_AxXaZiMqW5Mt9PWoEh7WWEw9_W_E2TTTnmxVnlm6O3pwTTAdSCo_wRaqdscKquFamt'
// };
// var data = json.encode({
//   "emirates_id": "784-1987-1234567-1",
//   "name": "Shas",
// "date_Of_birth":"1993-12-26",
// "issue_date":"2023-02-16",
// "expiry_date":"2025-07-08",
// "nationality":"India",
// "eid_number":"456780-234-23234234"
// });
// var dio = Dio();
// var response = await dio.request(
//   'http://10.255.254.23:8069/api/emirates_id_for_registration',
//   options: Options(
//     method: 'GET',
//     headers: headers,
//   ),
//   data: data,
// );

// if (response.statusCode == 200) {
//   print(json.encode(response.data));
// }
// else {
//   print(response.statusMessage);
// }
//     }, child: Text("register")),));
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pullman_mobile_app/Home/controller/emirate_id_controller.dart';
import 'package:pullman_mobile_app/Home/screen/pdf_generater_pdf_screen.dart';
import 'package:pullman_mobile_app/const/app_typography.dart';
import 'package:pullman_mobile_app/const/dailog_widgets.dart';
import 'package:pullman_mobile_app/const/router/routes.dart';
import 'package:pullman_mobile_app/const/space_helpper.dart';
import 'package:pullman_mobile_app/const/ui_utils/custom_colors.dart';
import 'package:pullman_mobile_app/const/widget/drop_dawon_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class EIDScannerScreen extends StatelessWidget {
  const EIDScannerScreen({super.key});

  Widget _buildDetailCard(String title, String? value, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: primaryColor),
        title: Text(title, style: AppText.b1b),
        subtitle: Text(value ?? 'Not found', style: AppText.b2),
      ),
    );
  }
 Widget _buildDetailCardWithWidget( Widget child, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child:Row(mainAxisAlignment: MainAxisAlignment.start,
          children: [
          hSpaceSmall,  Icon(icon, color: primaryColor),Expanded(child: child)
          ],
        ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EIDScannerProvider>(context);
    final eid = provider.eidData;

    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(excludeHeaderSemantics: true,automaticallyImplyLeading:false,
  title:  Text('Visitor Desk',style: AppText.b1b?.copyWith(color: Colors.white)),        centerTitle: true,
        backgroundColor: primaryColor,
        // actions: [
        //   if (eid != null)
        //     IconButton(
        //       icon: const Icon(Icons.clear),
        //       onPressed: () => provider.clearData(),
        //     )
        // ],
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : eid == null
              ?  Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [          Image.asset('assets/Emirates-ID.jpg'),

                  Text('Scan an Emirates ID to view details', style: AppText.h3b,textAlign: TextAlign.center,),
                ],
              ))
              : Consumer<EIDScannerProvider>(
                builder: (context, controller,_) {
                  return SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [vSpaceSmall,
                          Row(mainAxisAlignment: MainAxisAlignment.end,
                            children: [Card(
                        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                        elevation: 3,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Date: ${DateTime.now().toString().split(" ").first}",style: AppText.b1b),
                        ))],),vSpaceSmall,
                          _buildDetailCard('Name', eid.name, Icons.person),
                            _buildDetailCardWithWidget( TextField(keyboardType:TextInputType.number ,controller: controller.numberController,
                              decoration: InputDecoration(hintText: "Contact Number",
                                border: OutlineInputBorder(borderSide: BorderSide.none)),), Icons.phone),
                          _buildDetailCard('ID Number', eid.number, Icons.credit_card),
                        
                          _buildDetailCard('Nationality', eid.nationality, Icons.flag),
                          _buildDetailCard('Sex', eid.sex, Icons.male),
                          _buildDetailCard('Date of Birth', eid.dateOfBirth, Icons.cake),
                          _buildDetailCard('Issue Date', eid.issueDate, Icons.calendar_today),
                          _buildDetailCard('Expiry Date', eid.expiryDate, Icons.event_available),
                    Row(
                            children: [    Expanded(
                              child: _buildDetailCardWithWidget( 
                          AppDropDownButton(itemList: ["45678","23423","23545","56765","78856","123344","676785"],hint:controller.selectedKey??"Key log",onChange:(qw){
                            controller.selectKey(qw);
                          }), Icons.key),
                            ),    Expanded(
                              child: _buildDetailCardWithWidget( 
                          AppDropDownButton(itemList: ["Visiter","Employee","Meeting","Customer",],hint:controller.selectedVisiter??"Visiter type",onChange:(qw){
                            controller.selectVisiterType(qw);
                          }), Icons.golf_course_outlined),
                            ),   
                            ],
                          ),
                           _buildDetailCardWithWidget( 
                          AppDropDownButton(itemList: ["Arun","Rahul","Pooja","Dayana"],hint:controller.selectedAttentedBy??"Attented By",onChange:(qw){controller.selectAttendedBy(qw);}), Icons.person_3_outlined),
                          
                          //   Row(
                          //   children: [    Expanded(
                          //     child: _buildDetailCardWithWidget( 
                          // AppDropDownButton(itemList: ["Arun","Rahul","Pooja","Dayana"],hint:"Attented By",onChange:(qw){}), Icons.note),
                          //   ),    Expanded(child: Row(mainAxisAlignment: MainAxisAlignment.end,
                          //     children: [
                            
                          //     Text("Guest with You: ${provider.guestWithYou}",style: AppText.b2b,),IconButton(onPressed: (){}, icon: Icon(Icons.add,color: Colors.green,)),
                          //   ],))
                          //   ],
                          // ),Visibility(
                          //   // visible: provider.guestWithYou>1?true:false,
                          //   child: Card(
                          //         margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                          //         elevation: 3,
                          //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          //         child:TextField(
                          //             decoration: InputDecoration(suffixIcon:  IconButton(onPressed: (){}, icon: Icon(Icons.add)),
                          //               hintText: "Guest name",
                          //               border: OutlineInputBorder(borderSide: BorderSide.none)),),
                          //       ),
                          // ),
                  //     Card(
                  //       margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                  //       elevation: 3,
                  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  //       child:                    
                  // Column(children: List.generate(provider.GuestList.length, (index) {return Text(provider.GuestList[index]);
                  
                  // })),),
                            _buildDetailCardWithWidget( TextField(maxLines: 5,controller: controller.remarkController,keyboardType: TextInputType.text,
                              decoration: InputDecoration(hintText: "Remarks",
                                border: OutlineInputBorder(borderSide: BorderSide.none)),), Icons.edit),
                  
                       vSpaceLarge,
                         controller.apiLoader?Center(child: CircularProgressIndicator(),): Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [ GestureDetector(onTap: () async{
                                                   final prefs = await SharedPreferences.getInstance();
  final ipAddress = prefs.getString('server_ip');
// 10.255.254.23:8069
  if(ipAddress!= null){
  if (controller.numberController.text.isEmpty) {
  AppDialogBoxes.showPopup("Please enter the number");
} 
else if (controller.remarkController.text.isEmpty) {
  AppDialogBoxes.showPopup("Please enter remarks");
} 
else if (controller.selectedKey == null || controller.selectedKey.toString().trim().isEmpty) {
  AppDialogBoxes.showPopup("Please select a key");
} 
else if (controller.selectedAttentedBy == null || controller.selectedAttentedBy.toString().trim().isEmpty) {
  AppDialogBoxes.showPopup("Please select who attended");
} 
else if (controller.selectedVisiter == null || controller.selectedVisiter.toString().trim().isEmpty) {
  AppDialogBoxes.showPopup("Please select a visitor");
} else{
// print(ipAddress);
            provider.uploadEidDetails(ipAddress, DateTime.now().toString().split(" ").first);

  }

  }else{
showIPInputDialog(context);
  }
                  // Routes.push(screen: SignaturePdfPage(eid: eid,));
                              },
                  child: Container(width: MediaQuery.of(context).size.width/1.2,
                    padding: EdgeInsets.all(10),
                    child:Center(child: Text("Continue".toUpperCase(),
                    style: AppText.b1b?.copyWith(color: Colors.white))),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: primaryColor)),
                              ),
                            ],
                          )],
                      ),
                    );
                }
              ),
    floatingActionButton: Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    if (eid != null)
      FloatingActionButton(
        heroTag: 'clear',
        backgroundColor: Colors.redAccent,
        onPressed: () => provider.clearData(),
        child: const Icon(Icons.delete),
        tooltip: 'Clear Data',
      ),
   hSpaceRegular,
    FloatingActionButton.extended(
      heroTag: 'scan',
      onPressed: () async{

 
        // showIPInputDialog(context);
        provider.scanEIDCard();
      },
      label:  Text( provider.eidData==null?"Scan ID":"Retake",style:AppText.b1b?.copyWith(color: Colors.white)),
      icon: const Icon(Icons.camera_alt,color: Colors.white,),
      backgroundColor: primaryColor
    )
  ]
)
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
