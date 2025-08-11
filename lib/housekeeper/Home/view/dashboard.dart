
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pullman_mobile_app/const/ui_utils/custom_colors.dart';
import 'package:pullman_mobile_app/const/ui_utils/ui_utils.dart';
import 'package:pullman_mobile_app/housekeeper/Home/view/account_view.dart';
import 'package:pullman_mobile_app/housekeeper/Home/view/inbox_view.dart';
import 'package:pullman_mobile_app/housekeeper/Home/view/over_view.dart';
import 'package:pullman_mobile_app/housekeeper/Home/view/task_view.dart';

class DashboardView extends StatefulWidget {
  final int currentIndex;

  const DashboardView({super.key, this.currentIndex = 0});
  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  
  final UiUtilities uiUtilities = UiUtilities();
  String? team;
  int? _currentIndex;
  final List<Widget> _pages = [
    OverView(),
    // const TaskView(),
    // const InboxView(),
     AccountView()
  ];

  _onChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      _currentIndex = widget.currentIndex;
    });
  }



  @override
  Widget build(BuildContext context) {
    return _currentIndex == null
        ? const Scaffold(body: Center(child: CupertinoActivityIndicator()))
        : Scaffold(
            body: IndexedStack(
              index: _currentIndex,
              children: _pages,
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex!,
              onTap: _onChanged,
              selectedIconTheme:
                  Theme.of(context).iconTheme.copyWith(color: customRedColor),
              selectedLabelStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: customRedColor),
              unselectedIconTheme:
                  Theme.of(context).iconTheme.copyWith(color: customGreyColor),
              unselectedLabelStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: customGreyColor),
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: true,
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              selectedItemColor: customRedColor,
              unselectedItemColor: customGreyColor,
              items: [
                BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/chart_pie.svg'),
                    label: 'Overview',
                    activeIcon: SvgPicture.asset(
                      'assets/chart_pie.svg',
                      colorFilter: const ColorFilter.mode(
                          customRedColor, BlendMode.srcIn),
                    )),
                // BottomNavigationBarItem(
                //     icon: SvgPicture.asset('assets/lightning_bolt.svg'),
                //     label: 'Task',
                //     activeIcon: SvgPicture.asset(
                //       'assets/lightning_bolt.svg',
                //       colorFilter: const ColorFilter.mode(
                //           customRedColor, BlendMode.srcIn),
                //     )),
                // BottomNavigationBarItem(
                //     icon: SvgPicture.asset('assets/inbox.svg'),
                //     label: 'Inbox',
                //     activeIcon: SvgPicture.asset(
                //       'assets/inbox.svg',
                //         colorFilter: const ColorFilter.mode(
                //           customRedColor, BlendMode.srcIn),
                //     )),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/user_circle.svg'),
                    label: 'Account',
                    activeIcon: SvgPicture.asset(
                      'assets/user_circle.svg',
                        colorFilter: const ColorFilter.mode(
                          customRedColor, BlendMode.srcIn),
                    ))
              ],
            ),
          );
  }

  void getUserTeam() async {
      showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(builder: (context, setState) {
                return AlertDialog.adaptive(
                  title: Text(
                    'Update your Team',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  content: SizedBox(
                    height: 150,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                  color: Colors.grey, width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                hintStyle: Theme.of(context)
                                    .inputDecorationTheme
                                    .hintStyle,
                                contentPadding:
                                    const EdgeInsets.fromLTRB(15, 1, 15, 1),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.auto,
                                focusedBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .focusedBorder,
                                enabledBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .enabledBorder,
                                disabledBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .disabledBorder,
                                errorBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .errorBorder,
                                focusedErrorBorder: Theme.of(context)
                                    .inputDecorationTheme
                                    .focusedErrorBorder,
                                fillColor: Theme.of(context)
                                    .inputDecorationTheme
                                    .fillColor,
                                filled: true,
                                labelStyle: Theme.of(context)
                                    .inputDecorationTheme
                                    .labelStyle,
                                errorStyle: Theme.of(context)
                                    .inputDecorationTheme
                                    .errorStyle,
                              ),
                              items: dropDown
                                  .map((value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      )))
                                  .toList(),
                              value: team,
                              hint: Text(
                                'Select your team',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              onChanged: (value) {
                                setState(() {
                                  team = value;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: customRedColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            onPressed: () async {
                              // Navigator.pop(context);
                              // if (team == null) {
                              //   uiUtilities.actionAlertWidget(
                              //       context: context,
                              //       alertType: AlertType.error);
                              //   uiUtilities.alertNotification(
                              //       context: context, message: 'Select a team');
                              // } else {
                              //   BotToast.showLoading(
                              //       allowClick: false,
                              //       clickClose: false,
                              //       backButtonBehavior:
                              //           BackButtonBehavior.ignore);
                              //   bool isUpdated = await _userManager
                              //       .updateUserTeam(team: team);
                              //   BotToast.closeAllLoading();
                              //   if (!context.mounted) return;

                              //   if (isUpdated) {
                              //     uiUtilities.actionAlertWidget(
                              //         context: context,
                              //         alertType: AlertType.success);
                              //     uiUtilities.alertNotification(
                              //         context: context,
                              //         message: _userManager.message!);
                              //   } else {
                              //     uiUtilities.actionAlertWidget(
                              //         context: context,
                              //         alertType: AlertType.error);
                              //     uiUtilities.alertNotification(
                              //         context: context,
                              //         message: _userManager.message!);
                              //   }
                              // }
                            },
                            child: Text(
                              'Update team',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: Colors.white),
                            ))
                      ],
                    ),
                  ),
                );
              });
            });
  }

  
}


List<String>dropDown=['abi','ahamed',"loysten"];