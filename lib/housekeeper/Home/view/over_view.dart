import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';
import 'package:pennisula_group/const/router/routes.dart';
import 'package:pennisula_group/const/shared_widgets/custom_appbar_widget.dart';
import 'package:pennisula_group/const/shared_widgets/empty_widget.dart';
import 'package:pennisula_group/const/ui_utils/custom_colors.dart';
import 'package:pennisula_group/const/ui_utils/ui_utils.dart';
import 'package:pennisula_group/housekeeper/Home/model/my_task_reposnse_model.dart';
import 'package:pennisula_group/housekeeper/Home/model/task_model.dart';
import 'package:pennisula_group/housekeeper/Home/view/detailed_screen.dart';
import 'package:pennisula_group/housekeeper/controller/task_controller.dart';
import 'package:provider/provider.dart';

class OverView extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  OverView({super.key});
  // final  _taskManager = TaskController();
MyTask ?myTask;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    
        return Scaffold(
          appBar:  CustomAppBarWidget(
            title: 'Overview',
          ),
          body: FutureBuilder(future: TaskController().getTaskStatistics(context),
            builder: (context,snapshot) {

                   if (snapshot.connectionState == ConnectionState.waiting &&
                            !snapshot.hasData) {

                          return const Center(child: CupertinoActivityIndicator());
                        }
                      
                        if (snapshot.connectionState == ConnectionState.done &&
                            !snapshot.hasData) {
                          return const EmptyWidget(
                            imageAsset: 'no_task.png',
                            message:
                                'Tasks aasigned to you and tasks created for you appears here.',
                          );
                        }
                      
                        if (snapshot.data == null) {
                          
                          return const EmptyWidget(
                            imageAsset: 'no_task.png',
                            message:
                                'Tasks aasigned to you and tasks created for you appears here.',
                          );
                        }if(snapshot.hasData){
                          myTask = snapshot.data;

                        }
              return Consumer<TaskController>(
      builder: (context,controller,_) {
                  return ListView(
                    controller: _scrollController,
                    children: [Column(
                              children: [
                                Container(
                                  color: customGreyColor.withValues(alpha: .1),
                                  height: 45,
                                  width: size.width,
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 16.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              'My Summary',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(fontWeight: FontWeight.w600),
                                            ),IconButton(icon: Icon(Icons.refresh),onPressed: ()=> TaskController().getTaskStatistics(context)
        ,)
                                          ],
                                        ),
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: SizedBox(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        HomeTaskCountCard(
                                            size: size,
                                            count:"${myTask?.taskSummary?.todoTasks??0}",
                                            desc: "Todo Task",
                                            image: 'dots.png',
                                            color: const Color(0xffff5722)),
                                        HomeTaskCountCard(
                                            size: size,
                                            count: "${myTask?.taskSummary?.scheduledTasks??0}",
                                            desc: 'Sheduled Tasks',
                                            image: 'circles.png',
                                            color: const Color(0xff03a9f4)),
                                        HomeTaskCountCard(
                                          size: size,
                                          count: "${myTask?.taskSummary?.doneTasks??0}",
                                          desc: 'Done',
                                          image: 'layers.png',
                                          color: const Color(0xff4caf50),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      Container(
                        color: customGreyColor.withValues(alpha: .1),
                        height: 45,
                        width: size.width,
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text(
                                'My Tasks',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                       ListView.builder(
                                controller: _scrollController,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  String date = DateTime.now().toString();
                                  List<String> dateList = date.split(' ');
                                  return HomeTaskSummary(
                                    onTap: () {
                  if(myTask?.taskData?[index] != null){
                                      Routes.push(screen: TaskAssignedDetailScreen(myTask: myTask!.taskData![index]));
                  
                  }
                                    },
                                    size: size,
                                    priority:myTask?.taskData?[index].name??'',
                                    time: myTask?.taskData?[index].dueDate.toString().split(" ").first??"",
                                    title: myTask?.taskData?[index].description,
                                  );
                                },
                                itemCount: snapshot.data?.taskData?.length??0)
                    
                    ],
                  );
                }
              );
            }
          ),
        );
      
  }
}

class HomeTaskSummary extends StatelessWidget {
  const HomeTaskSummary({
    super.key,
    required this.size,
    required this.title,
    required this.priority,
    required this.time,
    required this.onTap,
  });

  final Size size;
  final String? title;
  final String priority;
  final String time;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 10),
      child: InkWell(
        onTap: onTap,
        child: Card(
          elevation: 0,
          color: brightness == Brightness.dark
              ? customGreyColor.withValues(alpha: .1)
              : priority == 'Low'
                  ? const Color.fromRGBO(236, 249, 245, 1)
                  : priority == 'Medium'
                      ? const Color.fromRGBO(251, 245, 225, 1)
                      : const Color.fromRGBO(252, 244, 248, 1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 80,
                  decoration: BoxDecoration(
                      color: priority == 'Low'
                          ? Colors.green
                          : priority == 'Medium'
                              ? Colors.amber
                              : Colors.red,
                      borderRadius: BorderRadius.circular(45)),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      width: size.width - 90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '$priority Priority',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    color: priority == 'Low'
                                        ? Colors.green
                                        : priority == 'Medium'
                                            ? Colors.amber
                                            : Colors.red,
                                    fontWeight: FontWeight.w600),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                AntDesign.clockcircleo,
                                color: customGreyColor,
                                size: 15,
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                time,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color: customGreyColor,
                                        fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: size.width - 90,
                      child: Text(title!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyLarge),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeTaskCountCard extends StatelessWidget {
  const HomeTaskCountCard({
    super.key,
    required this.size,
    required this.desc,
    required this.count,
    required this.image,
    this.color,
  });

  final Size size;
  final String desc;
  final String? count;
  final String image;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color!.withValues(alpha: .4),
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: 130,
        width: size.width / 3 - 32,
        child: Stack(
          children: [
            Positioned(
                top: 2,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/$image',
                      fit: BoxFit.cover,
                    ))),
            Positioned(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 130,
                width: size.width / 3 - 32,
                color: Colors.black87.withValues(alpha: .3),
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    desc,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.normal, color: Colors.white),
                  ),
                  Text(
                    '$count',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontWeight: FontWeight.bold, color: color),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
