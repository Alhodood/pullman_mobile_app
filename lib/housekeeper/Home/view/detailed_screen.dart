import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pennisula_group/const/app_typography.dart';
import 'package:pennisula_group/const/router/routes.dart';
import 'package:pennisula_group/const/space_helpper.dart';
import 'package:pennisula_group/housekeeper/Home/model/my_task_reposnse_model.dart';
import 'package:pennisula_group/housekeeper/Home/view/dashboard.dart';
import 'package:pennisula_group/housekeeper/controller/task_controller.dart';
import 'package:provider/provider.dart';

class TaskAssignedDetailScreen extends StatefulWidget {
  TaskAssignedDetailScreen({super.key, required this.myTask});
  TaskDatum myTask;
  @override
  State<TaskAssignedDetailScreen> createState() =>
      _TaskAssignedDetailScreenState();
}

class _TaskAssignedDetailScreenState extends State<TaskAssignedDetailScreen> {
  // @override
  void initState() {
    super.initState();
    // Automatically show bottom sheet (like snackbar behavior)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      TaskController().completAllTask(false);

      // showModalBottomSheet(
      //   context: context,
      //   isScrollControlled: true,
      //   shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      //   ),
      //   builder: (_) => const JobBottomSheet(),
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskController>(
      builder: (context, controller, _) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Task Details', style: AppText.h3b),
            // backgroundColor: Colors.deepPurple,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle('Title'),
                      _infoCard(widget.myTask.name ?? ""),
            
                      _sectionTitle('Assigned To'),
                      _infoCard(widget.myTask.assignees?.first ?? ""),
            
                      _sectionTitle('Due Date'),
                      _infoCard(
                        widget.myTask.dueDate.toString().split('.').first,
                      ),
            
                      _sectionTitle('Status'),
                      _statusChip(widget.myTask.type ?? ""),
                      vSpaceRegular,
            
                      Text(
                        'Required to Complete',
                        style: AppText.b1b!.copyWith(color: Colors.red),
                      ),
                    if( widget.myTask.checklist.isNotEmpty)  SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            widget.myTask.checklist.length,
                            (inde) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _sectionTitle(
                                    widget.myTask.checklist[inde].type ?? "",
                                  ),vSpaceMin,
                                  Column(
                                    children: List.generate(
                                      widget.myTask.checklist[inde].items.length,
                                      (indexx) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: _infoCard(
                                            widget
                                                .myTask
                                                .checklist[inde]
                                                .items[indexx].name??"",
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      _sectionTitle('Description'),
                      _infoCard(widget.myTask.description ?? ""),
                      _sectionTitle('Description'),
                      TextField(
                        controller: controller.descriptionController,
                        decoration: InputDecoration(
                          hintText: 'Add a notes...',
                          // suffixIcon: IconButton(
                          //   icon: const Icon(Icons.send),
                          //   onPressed: () {},
                          // ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _sectionTitle('Attachments'),
                          IconButton(
                            onPressed: () {
                              controller.addAttachment();
                            },
                            icon: Icon(Icons.add),
                          ),
                          
                        ],
                      ),vSpaceLarge
                    ],
                  ),
            
                  // _commentBox(),
                  controller.attachment.isEmpty
                      ? SizedBox()
                      : ListView.builder(
                        itemCount: controller.attachment.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              Routes.push(
                                screen: FullImageScreen(
                                  imageFile: controller.attachment[index],
                                ),
                              );
                            },
                            leading: const Icon(
                              Icons.insert_drive_file,
                              color: Colors.grey,
                            ),
                            title: Text(
                              path.basename(controller.attachment[index].path),
                              style: AppText.b2b!.copyWith(color: Colors.grey),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                controller.deleteAttachment(index);
                              },
                            ),
                          );
                        },
                      ),
                  vSpaceXl,
            
                  //  _attachmentList(),
            
                  // vSpace,
                ],
              ),
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  print(controller.completedAllTask);
                  if (controller.completedAllTask == false) {
                    if (controller.workStartedTime == null) {
                      controller.saveWorkSatrtedTime(DateTime.now());
                    }
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      useSafeArea: true,
                      backgroundColor: Colors.transparent,
                      builder:
                          (_) => JobDialog(
                            checkList: widget.myTask.checklist,
                            startTime:
                                controller.workStartedTime ?? DateTime.now(),
                          ),
                    );
                  }
                  if (controller.completedAllTask == true) {
                    if (controller.attachment.isEmpty) {
                      controller.addAttachment();
                      // showDialog(
                      //   context: context,
                      //   builder: (_) => AlertDialog(
                      //     title: const Text("Job Completed"),
                      //     content: Text("Total Duration: ${duration.inMinutes} minutes"),
                      //     actions: [
                      //       TextButton(
                      //         onPressed: () => Navigator.pop(context),
                      //         child: const Text("OK"),
                      //       )
                      //     ],
                      //   ),
                      // );
                    } else {
                      final currentTime = DateTime.now();
                      print("work started `time${controller.workStartedTime}");

                      final duration = currentTime.difference(
                        controller.workStartedTime!,
                      );
                      print(duration);
                      final hour = duration.inHours;
                      final minitues = duration.inMinutes;
                      controller.workCompletedApi(
                        context,
                        "${hour}.$minitues",
                        widget.myTask.id,
                      );
                    }
                    //
                  }
                },
                child: Text(
                  controller.completedAllTask == false
                      ? "Start Job"
                      : "Task Completed",
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // Button background color
                  foregroundColor: Colors.white, // Text/icon color
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }

  Widget _sectionTitle(String title) => Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 8),
    child: Text(title, style: AppText.b1b),
  );

  Widget _infoCard(String text) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.grey.shade100,
    ),
    child: Text(text, style: AppText.b2b),
  );

  Widget _statusChip(String status) => Chip(
    label: Text(status),
    backgroundColor: Colors.orange.shade100,
    labelStyle: const TextStyle(color: Colors.orange),
  );

  Widget _attachmentList() => Column(
    children: [
      ListTile(
        leading: const Icon(Icons.insert_drive_file, color: Colors.grey),
        title: Text(
          'ac_maintenance_guide.pdf',
          style: AppText.b2b!.copyWith(color: Colors.grey),
        ),
        trailing: IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
      ),
      ListTile(
        leading: const Icon(Icons.image, color: Colors.grey),
        title: const Text('broken_ac.jpg'),
        trailing: IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
      ),
    ],
  );

  Widget _commentBox() => Column(
    children: [
      ListTile(
        leading: const CircleAvatar(child: Icon(Icons.person)),
        title: const Text('John Doe'),
        subtitle: const Text('I checked the unit. Need spare part.'),
        trailing: const Text('2 hrs ago'),
      ),
      const SizedBox(height: 10),
      TextField(
        decoration: InputDecoration(
          hintText: 'Add a comment...',
          suffixIcon: IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {},
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    ],
  );
}
// class JobDialog extends StatefulWidget {
//   final List<Checklist> checkList;
//   final DateTime startTime;

//   const JobDialog({
//     super.key,
//     required this.checkList,
//     required this.startTime,
//   });

//   @override
//   State<JobDialog> createState() => _JobDialogState();
// }

// class _JobDialogState extends State<JobDialog> {
//   void finishJob() {
//     final controller = Provider.of<TaskController>(context, listen: false);
//     if (!widget.checkList.every((e) => e.items.every((p) => p.selected ?? false))) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please complete all checklist items")),
//       );
//       return;
//     }

//     controller.completAllTask(true);
//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       insetPadding: const EdgeInsets.all(16),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               /// Header
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Job Started at ${widget.startTime}",
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.deepPurple,
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () => Navigator.pop(context),
//                     icon: const Icon(Icons.close),
//                   )
//                 ],
//               ),
//               const SizedBox(height: 20),

//               /// Checklist Items
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: widget.checkList.length,
//                 itemBuilder: (context, i) {
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.checkList[i].type ?? '',
//                         style: AppText.b1b,
//                       ),
//                       ...List.generate(
//                         widget.checkList[i].items.length,
//                         (j) => CheckboxListTile(
//                           title: Text(
//                             widget.checkList[i].items[j].name ?? "",
//                             style: AppText.b2b,
//                           ),
//                           value: widget.checkList[i].items[j].selected ?? false,
//                           activeColor: Colors.deepPurple,
//                           onChanged: (val) {
//                             setState(() {
//                               widget.checkList[i].items[j].selected = val!;
//                             });
//                           },
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),

//               const SizedBox(height: 20),

//               /// Confirm Button
//               ElevatedButton.icon(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.deepPurple,
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 ),
//                 onPressed: finishJob,
//                 icon: const Icon(Icons.check),
//                 label: const Text("Confirm Task"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


class JobDialog extends StatefulWidget {
  final List<Checklist> checkList;

  JobDialog({super.key, required this.checkList, required this.startTime});
  DateTime startTime;

  @override
  State<JobDialog> createState() => _JobDialogState();
}

class _JobDialogState extends State<JobDialog> {
  late List<bool> checklistStatus;

  @override
  void finishJob() {
    final controller = Provider.of<TaskController>(context, listen: false);
    if (!widget.checkList.every((e) => e.items.every((p)=>p.selected ?? false))) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please complete all checklist items")),
      );
      return;
    }

    // final duration = DateTime.now().difference(startTime);
    controller.completAllTask(true);
    Navigator.pop(context); // Close dialog
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: SingleChildScrollView(scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            Column(children: [  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Job Started at ${widget.startTime}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepPurple,
                    ),
                  ),IconButton(onPressed: (){
                    Routes.back();
                  }, icon: Icon(Icons.close))
                ],
              ),
              const SizedBox(height: 20),
              ],),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.checkList.length,
                itemBuilder: (context, indes) {
                  return Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(widget.checkList[indes].type??'',style: AppText.b1b,),
                      Column(
                        children: List.generate(widget.checkList[indes].items.length, (index){
                          return   CheckboxListTile(
                            title: Text(widget.checkList[indes].items[index].name?? "",style: AppText.b2b,),
                            value: widget.checkList[indes].items[index].selected?? false,
                            activeColor: Colors.deepPurple,
                            onChanged: (val) {
                              setState(() => widget.checkList[indes].items[index].selected= val!);
                            },
                          );
                        })
                      ),
                    ],
                  );
                },
              ),
            SizedBox(
              child: Column(children: [  const SizedBox(height: 20),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: finishJob,
                  icon: const Icon(Icons.check),
                  label: const Text("Confirm Task"),
                ),],),
            )
            ],
          ),
        ),
      ),
    );
  }
}

class JobCompletedDialog extends StatelessWidget {
  final String duration;

  const JobCompletedDialog({super.key, required this.duration});

  @override
  Widget build(BuildContext context) {
    final timeText = "$duration";

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon at the top
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.green.shade100,
              child: const Icon(
                Icons.check_circle_rounded,
                size: 60,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Congratulations!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "You have successfully completed the job.",
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              "Total Working Time: $timeText",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.done_all_rounded),
              label: const Text("Close"),
              onPressed: () => Routes.pushRemoveUntil(screen: DashboardView()),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FullImageScreen extends StatelessWidget {
  final File imageFile;

  const FullImageScreen({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Preview'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(child: Image.file(imageFile, fit: BoxFit.contain)),
    );
  }
}
