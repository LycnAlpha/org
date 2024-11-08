import 'package:flutter/material.dart';
import 'package:org_connect_pt/screens/employee_leave_screen/employee_leave_screen.dart';
import 'package:org_connect_pt/screens/employee_list_screen/employee_list_screen.dart';
import 'package:org_connect_pt/screens/personal_leave_screen/personal_leave_screen.dart';
import 'package:org_connect_pt/screens/more_options_screen/more_option_screen_widgets/list_item.dart';
import 'package:org_connect_pt/screens/more_options_screen/more_option_screen_widgets/tile_item.dart';
import 'package:org_connect_pt/screens/more_options_screen/more_option_screen_widgets/toggle_button.dart';
import 'package:org_connect_pt/screens/more_options_screen/more_option_screen_widgets/type_button.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';

class MoreOptionScreenSupervisor extends StatelessWidget {
  final bool isList;
  final bool isPersonal;
  final onTypeChanged;
  final onToggleButtonClicked;

  const MoreOptionScreenSupervisor({
    super.key,
    required this.isList,
    required this.isPersonal,
    this.onTypeChanged,
    this.onToggleButtonClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(BasicColors.tertiary),
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            TypeButton(
              isPersonal: isPersonal,
              onTypeChanged: onTypeChanged,
            ),
            ToggleButton(
              isList: isList,
              onToggleButtonClicked: onToggleButtonClicked,
            ),
            generalTab(context),
            Visibility(visible: isPersonal, child: insightsTab(context))
          ],
        ),
      ),
    );
  }

  Widget toggleButton(bool isList, onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: const Color(BasicColors.tertiary),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                offset: const Offset(0, 0),
                blurRadius: 7,
                spreadRadius: 2,
              ),
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (isList) {
                      onTap();
                    }
                  },
                  child: Icon(
                    Icons.laptop,
                    color: isList
                        ? Colors.grey.shade300
                        : const Color(BasicColors.primary),
                  ),
                ),
                VerticalDivider(
                  color: Colors.grey.shade300,
                  thickness: 2.0,
                ),
                GestureDetector(
                  onTap: () {
                    if (!isList) {
                      onTap();
                    }
                  },
                  child: Icon(
                    Icons.list_outlined,
                    color: isList
                        ? const Color(BasicColors.primary)
                        : Colors.grey.shade300,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget generalTab(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              'General',
              style: TextStyle(
                  color: Color(BasicColors.primary),
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
          ),
          isList ? generalList(context) : generalTiles(context),
        ],
      ),
    );
  }

  Widget generalList(BuildContext context) {
    return isPersonal
        ? Column(
            children: [
              const ListItem(
                image: 'assets/icons/icon_attendance.png',
                label: 'Attendance',
              ),
              ListItem(
                image: 'assets/icons/icon_leave.png',
                label: 'Leave',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PersonalLeaveScreen()),
                  );
                },
              ),
              const ListItem(
                image: 'assets/icons/icon_incidents.png',
                label: 'Incidents',
              ),
              const ListItem(
                image: 'assets/icons/icon_pay_slips.png',
                label: 'Pay Slips',
              ),
              const ListItem(
                image: 'assets/icons/icon_loans.png',
                label: 'Loans',
              ),
              const ListItem(
                image: 'assets/icons/icon_performance.png',
                label: 'Performance',
              ),
            ],
          )
        : Column(
            children: [
              ListItem(
                image: 'assets/icons/icon_employee_profile.png',
                label: 'Employee Profile',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EmployeeListScreen(),
                    ),
                  );
                },
              ),
              const ListItem(
                image: 'assets/icons/icon_attendance_management.png',
                label: 'Attendance Management',
              ),
              ListItem(
                image: 'assets/icons/icon_leave_management.png',
                label: 'Leave Management',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EmployeeLeaveScreen()),
                  );
                },
              ),
              const ListItem(
                image: 'assets/icons/icon_incident_management.png',
                label: 'Incident Management',
              ),
              const ListItem(
                image: 'assets/icons/icon_performance_evaluations.png',
                label: 'Performance Evaluations',
              ),
              const ListItem(
                image: 'assets/icons/icon_training.png',
                label: 'Training Management',
              ),
              const ListItem(
                image: 'assets/icons/icon_policies.png',
                label: 'Policy & Compliance',
              ),
              const ListItem(
                image: 'assets/icons/icon_inquiries.png',
                label: 'Inquiries',
              ),
            ],
          );
  }

  Widget generalTiles(BuildContext context) {
    return (MediaQuery.of(context).size.width / 130).floor() == 3
        ? isPersonal
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const TileItem(
                        image: 'assets/icons/icon_attendance.png',
                        label: 'Attendance',
                      ),
                      TileItem(
                        image: 'assets/icons/icon_leave.png',
                        label: 'Leave',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PersonalLeaveScreen()),
                          );
                        },
                      ),
                      const TileItem(
                        image: 'assets/icons/icon_incidents.png',
                        label: 'Incidents',
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      TileItem(
                        image: 'assets/icons/icon_pay_slips.png',
                        label: 'Pay Slips',
                      ),
                      TileItem(
                        image: 'assets/icons/icon_loans.png',
                        label: 'Loans',
                      ),
                      TileItem(
                        image: 'assets/icons/icon_performance.png',
                        label: 'Performance',
                      ),
                    ],
                  )
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      TileItem(
                        image: 'assets/icons/icon_employee_profile.png',
                        label: 'Employee Profile',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EmployeeListScreen(),
                            ),
                          );
                        },
                      ),
                      const TileItem(
                        image: 'assets/icons/icon_attendance_management.png',
                        label: 'Attendance Management',
                      ),
                      TileItem(
                        image: 'assets/icons/icon_leave_management.png',
                        label: 'Leave Management',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const EmployeeLeaveScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      TileItem(
                        image: 'assets/icons/icon_incident_management.png',
                        label: 'Incident Management',
                      ),
                      TileItem(
                        image: 'assets/icons/icon_performance_evaluations.png',
                        label: 'Performance Evaluations',
                      ),
                      TileItem(
                        image: 'assets/icons/icon_training.png',
                        label: 'Training Management',
                      ),
                    ],
                  ),
                  const Row(
                    children: [
                      TileItem(
                        image: 'assets/icons/icon_policies.png',
                        label: 'Policy & Compliance',
                      ),
                      TileItem(
                        image: 'assets/icons/icon_inquiries.png',
                        label: 'Inquiries',
                      ),
                    ],
                  )
                ],
              )
        : isPersonal
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const TileItem(
                        image: 'assets/icons/icon_attendance.png',
                        label: 'Attendance',
                      ),
                      TileItem(
                        image: 'assets/icons/icon_leave.png',
                        label: 'Leave',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PersonalLeaveScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TileItem(
                        image: 'assets/icons/icon_incidents.png',
                        label: 'Incidents',
                      ),
                      TileItem(
                        image: 'assets/icons/icon_pay_slips.png',
                        label: 'Pay Slips',
                      ),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TileItem(
                        image: 'assets/icons/icon_loans.png',
                        label: 'Loans',
                      ),
                      TileItem(
                        image: 'assets/icons/icon_performance.png',
                        label: 'Performance',
                      ),
                    ],
                  )
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TileItem(
                        image: 'assets/icons/icon_employee_profile.png',
                        label: 'Employee Profile',
                      ),
                      TileItem(
                        image: 'assets/icons/icon_attendance_management.png',
                        label: 'Attendance Management',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TileItem(
                        image: 'assets/icons/icon_leave_management.png',
                        label: 'Leave Management',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const EmployeeLeaveScreen()),
                          );
                        },
                      ),
                      const TileItem(
                        image: 'assets/icons/icon_incident_management.png',
                        label: 'Incident Management',
                      ),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TileItem(
                        image: 'assets/icons/icon_performance_evaluations.png',
                        label: 'Performance Evaluations',
                      ),
                      TileItem(
                        image: 'assets/icons/icon_training.png',
                        label: 'Training Management',
                      ),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TileItem(
                        image: 'assets/icons/icon_policies.png',
                        label: 'Policy & Compliance',
                      ),
                      TileItem(
                        image: 'assets/icons/icon_inquiries.png',
                        label: 'Inquiries',
                      ),
                    ],
                  )
                ],
              );
  }

  Widget insightsTab(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              'Insights',
              style: TextStyle(
                  color: Color(BasicColors.primary),
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
          ),
          isList ? insightsList() : insightsTiles(context),
        ],
      ),
    );
  }

  Widget insightsList() {
    return const Column(
      children: [
        ListItem(
          image: 'assets/icons/icon_training.png',
          label: 'Training',
        ),
        ListItem(
          image: 'assets/icons/icon_inquiries.png',
          label: 'Inquiries',
        ),
      ],
    );
  }

  Widget insightsTiles(BuildContext context) {
    return Column(
      children: [
        (MediaQuery.of(context).size.width / 130).floor() == 3
            ? const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TileItem(
                    image: 'assets/icons/icon_training.png',
                    label: 'Training',
                  ),
                  TileItem(
                    image: 'assets/icons/icon_inquiries.png',
                    label: 'Inquiries',
                  ),
                ],
              )
            : const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TileItem(
                    image: 'assets/icons/icon_training.png',
                    label: 'Training',
                  ),
                  TileItem(
                    image: 'assets/icons/icon_inquiries.png',
                    label: 'Inquiries',
                  ),
                ],
              )
      ],
    );
  }
}
