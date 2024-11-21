import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:org_connect_pt/common/common_providers/all_pending_leaves_provider.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen.dart';
import 'package:org_connect_pt/screens/dashboard_screen/dashboard_screen_widgets/count_card.dart';
import 'package:org_connect_pt/screens/dashboard_screen/dashboard_screen_widgets/remaining_leaves_card.dart';
import 'package:org_connect_pt/screens/employee_list_screen/employee_list_provider.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';
import 'package:org_connect_pt/utils/constants.dart';
import 'package:provider/provider.dart';

class DashboardScreenInterface extends StatelessWidget {
  final int permissionLevel;
  final retry;
  const DashboardScreenInterface({
    super.key,
    required this.permissionLevel,
    this.retry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(BasicColors.tertiary),
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          greetingsBox(),
          countCards(),
          overview(context),
          salarySlips(),
        ],
      ),
    );
  }

  Widget countCards() {
    return Visibility(
      visible: permissionLevel != Constants.permissionLevelEmployee,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: SizedBox(
          height: 240,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Consumer<EmployeeListProvider>(
                      builder: (context, employeeListProvider, child) {
                        if (employeeListProvider.isLoading) {
                          return countCardLayout(
                              image: 'assets/images/image_employee_count.png',
                              label: 'Total Employees',
                              context: context,
                              child: const SpinKitCircle(
                                color: Color(BasicColors.primary),
                                size: 55.0,
                              ));
                        } else if (employeeListProvider.errorOccured) {
                          return countCardLayout(
                              image: 'assets/images/image_employee_count.png',
                              label: 'Total Employees',
                              context: context,
                              child: GestureDetector(
                                onTap: retry,
                                child: const Icon(
                                  Icons.refresh,
                                  color: Color(BasicColors.primary),
                                  size: 55,
                                ),
                              ));
                        } else {
                          return CountCard(
                            image: 'assets/images/image_employee_count.png',
                            label: 'Total Employees',
                            value: employeeListProvider.count,
                            color: const Color(BasicColors.primary),
                          );
                        }
                      },
                    ),
                    Consumer<AllPendingLeavesProvider>(
                      builder: (context, allPendingLeavesProvider, child) {
                        if (allPendingLeavesProvider.isLoading) {
                          return countCardLayout(
                              image:
                                  'assets/images/image_pending_leave_count.png',
                              label: 'Pending Leaves',
                              context: context,
                              child: const SpinKitCircle(
                                color: Colors.amber,
                                size: 55.0,
                              ));
                        } else if (allPendingLeavesProvider.errorOccured) {
                          return countCardLayout(
                              image:
                                  'assets/images/image_pending_leave_count.png',
                              label: 'Pending Leaves',
                              context: context,
                              child: GestureDetector(
                                onTap: retry,
                                child: const Icon(
                                  Icons.refresh,
                                  color: Colors.amber,
                                  size: 55,
                                ),
                              ));
                        } else {
                          return CountCard(
                            image:
                                'assets/images/image_pending_leave_count.png',
                            label: 'Pending Leaves',
                            value: allPendingLeavesProvider.count,
                            color: Colors.amber,
                          );
                        }
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    permissionLevel == Constants.permissionLevelSupervisor
                        ? const CountCard(
                            image: 'assets/images/image_staffing.png',
                            label: "Today's Staffing status",
                            value: 23,
                            color: Colors.green)
                        : const CountCard(
                            image:
                                'assets/images/image_upcoming_evaluations_count.png',
                            label: 'Upcoming Evaluations',
                            value: 23,
                            color: Colors.green),
                    const CountCard(
                      image: 'assets/images/image_incident_count.png',
                      label: 'Ongoing Incidents',
                      value: 14,
                      color: Color(0xffA30D0D),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget greetingsBox() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10.0,
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: const Color(BasicColors.primary),
              width: 1.5,
            ),
            color: Color(BasicColors.tertiary)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Hi ',
                        style: TextStyle(
                          color: Color(BasicColors.primary),
                          fontSize: 30.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Dimal!',
                        style: TextStyle(
                          color: Color(BasicColors.secondary),
                          fontSize: 30.0,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  Text(
                    _getGreeting(),
                    style: const TextStyle(
                      color: Color(BasicColors.primary),
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
            Container(
              padding: const EdgeInsets.only(right: 5.0),
              height: 85,
              child: Image.asset(
                'assets/images/image_dashboard.png',
                fit: BoxFit.fill,
              ),
            )
          ],
        ),
      ),
    );
  }

  String _getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning!';
    }
    if (hour < 17) {
      return 'Good Afternoon!';
    }
    if (hour < 21) {
      return 'Good Evening';
    }
    return 'Good Night!';
  }

  Widget overview(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Text(
            'Overview',
            style: TextStyle(
                color: Color(BasicColors.primary),
                fontWeight: FontWeight.bold,
                fontSize: 16.0),
          ),
        ),
        RemainingLeavesCard(
          retry: retry,
        ),
        notifications(),
        applyLeaveButton(context),
      ],
    );
  }

  Widget notifications() {
    return SizedBox(
      height: 140,
      child: ListView(
        children: [
          notificationCard(
              Colors.amber, 'You have 08 more pending leaves for now.'),
          notificationCard(Colors.green,
              'The leave you applied on 29th Aug 2024 was approved'),
        ],
      ),
    );
  }

  Widget notificationCard(color, message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Text(
              message,
              style: const TextStyle(
                color: Color(BasicColors.tertiary),
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )),
            const SizedBox(
              width: 50.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.cancel_outlined,
                    color: Color(BasicColors.tertiary),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget applyLeaveButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ApplyForLeaveScreen()),
          ).then((value) {
            retry();
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: const Color(BasicColors.secondary)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: 40,
                  child:
                      Image.asset('assets/icons/icon_apply_leave_button.png')),
              const SizedBox(
                width: 10.0,
              ),
              const Text(
                'Apply Leave',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color(BasicColors.tertiary),
                    fontWeight: FontWeight.w900,
                    fontSize: 18.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget salarySlips() {
    return Expanded(
      child: Visibility(
        visible: permissionLevel == Constants.permissionLevelEmployee,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(
                    child: Text(
                      'Salary Slips',
                      style: TextStyle(
                          color: Color(BasicColors.primary),
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  ),
                  GestureDetector(
                    child: Row(
                      children: [
                        Text(
                          'See All',
                          style: TextStyle(
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Icon(
                          Icons.double_arrow,
                          color: Colors.grey.shade400,
                          size: 15,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                salarySlipCard(DateTime(2024, 03, 10)),
                salarySlipCard(DateTime(2024, 02, 10)),
                salarySlipCard(DateTime(2024, 01, 10)),
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget salarySlipCard(DateTime date) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color(BasicColors.tertiary),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(0, 0),
              blurRadius: 7,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color(BasicColors.primary).withOpacity(0.2),
              ),
              child: Text(
                DateFormat.MMMM().format(date).substring(0, 1),
                style: const TextStyle(
                    color: Color(BasicColors.primary),
                    fontSize: 25.0,
                    fontWeight: FontWeight.w900),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('dd MMMM yyyy').format(date),
                  style: TextStyle(color: Colors.grey.shade400),
                ),
                Text(
                  DateFormat('MMMM').format(date),
                  style: const TextStyle(
                    color: Color(BasicColors.primary),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                child: const Icon(
                  Icons.visibility,
                  color: Color(BasicColors.primary),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                child: const Icon(
                  Icons.file_download_sharp,
                  color: Color(BasicColors.primary),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget countCardLayout(
      {required String label,
      required String image,
      required Widget child,
      required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.11,
        width: MediaQuery.of(context).size.width * 0.4,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color(BasicColors.tertiary),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(0, 0),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(right: 10.0), child: child),
                Expanded(child: Image.asset(image)),
                Icon(
                  Icons.more_vert,
                  color: Colors.grey.shade300,
                )
              ],
            ),
            Text(
              label,
              style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w800,
                  color: Color(BasicColors.primary)),
            ),
          ],
        ),
      ),
    );
  }
}
