import 'package:flutter/material.dart';
import 'package:org_connect_pt/common/common_dialogs/approve_leave_confirmation_dialog.dart';
import 'package:org_connect_pt/common/common_dialogs/reject_leave_confirmation_dialog.dart';
import 'package:org_connect_pt/helpers/status_handle_helper.dart';
import 'package:org_connect_pt/models/leave.dart';
import 'package:org_connect_pt/screens/employee_leave_screen/employee_leave_provider.dart';
import 'package:org_connect_pt/screens/employee_leave_screen/employee_leave_screen_widgets/employee_leave_details.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';
import 'package:org_connect_pt/utils/constants.dart';
import 'package:provider/provider.dart';

class EmployeeLeaveCard extends StatelessWidget {
  final Leave leave;
  const EmployeeLeaveCard({
    super.key,
    required this.leave,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: leave.statusId == Constants.statusPending
          ? Dismissible(
              key: Key(leave.leaveId.toString()),
              background: dismissibleBackgroundReject(),
              secondaryBackground: dismissibleBackgroundApprove(),
              onDismissed: (direction) {
                if (direction == DismissDirection.endToStart) {
                  //approve flow
                  showDialog(
                    context: context,
                    builder: (ctx) => ApproveLeaveConfirmationDialog(
                      leave: leave,
                    ),
                  ).then((value) {
                    Provider.of<EmployeeLeaveProvider>(
                      context,
                      listen: false,
                    ).getEmployeeLeaves(context);
                  });
                } else if (direction == DismissDirection.startToEnd) {
                  //reject flow
                  showDialog(
                    context: context,
                    builder: (ctx) => RejectLeaveConfirmationDialog(
                      leave: leave,
                    ),
                  ).then((value) {
                    Provider.of<EmployeeLeaveProvider>(
                      context,
                      listen: false,
                    ).getEmployeeLeaves(context);
                  });
                }
              },
              child: content(context),
            )
          : content(context),
    );
  }

  Widget dismissibleBackgroundApprove() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: const Color(BasicColors.secondary).withOpacity(0.75),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Approve...',
            style: TextStyle(
              color: Color(BasicColors.tertiary),
              fontSize: 25.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Center(
            child: Icon(
              Icons.check_circle_outline,
              color: Color(BasicColors.tertiary),
              size: 35,
            ),
          ),
        ],
      ),
    );
  }

  Widget dismissibleBackgroundReject() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: const Color(BasicColors.primary).withOpacity(0.75),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Icon(
              Icons.cancel_outlined,
              color: Color(BasicColors.tertiary),
              size: 35,
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            'Reject...',
            style: TextStyle(
              color: Color(BasicColors.tertiary),
              fontSize: 25.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget content(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EmployeeLeaveDetails(
                    leave: leave,
                  )),
        ).then((value) {
          Provider.of<EmployeeLeaveProvider>(
            context,
            listen: false,
          ).getEmployeeLeaves(context);
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: const Color(BasicColors.tertiary),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(BasicColors.primary),
                        ),
                        child: CircleAvatar(
                          radius: 35.0,
                          backgroundColor: const Color(BasicColors.tertiary),
                          child: Center(
                            child: Text(
                              leave.leavetypeName != null
                                  ? leave.leavetypeName!.substring(0, 1)
                                  : 'L',
                              style: const TextStyle(
                                  color: Color(BasicColors.secondary),
                                  fontSize: 40.0),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2.0, horizontal: 15.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: const Color(BasicColors.primary)),
                        child: Text(
                          leave.leavetypeName != null
                              ? leave.leavetypeName!.split('Leave')[0]
                              : 'Leave',
                          style: const TextStyle(
                              color: Color(BasicColors.tertiary),
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${leave.employeeName} (${leave.leaveId})',
                          style: const TextStyle(
                              color: Color(BasicColors.primary),
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        ),
                        Text(
                          'From: ${leave.startDate} (${leave.startSegment})',
                          style: const TextStyle(
                              color: Color(BasicColors.primary),
                              // fontWeight: FontWeight.w500,
                              fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'To: ${leave.endDate} (${leave.endSegment})',
                          style: const TextStyle(
                              color: Color(BasicColors.primary),
                              // fontWeight: FontWeight.w500,
                              fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'Reason: ${leave.reason}',
                          style: const TextStyle(
                              color: Color(BasicColors.primary),
                              // fontWeight: FontWeight.w500,
                              fontSize: 14),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 2.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Color(
                          StatusHandleHelper.getStatusColor(leave.statusId))),
                  child: Text(
                    leave.statusDescription,
                    style: const TextStyle(
                        color: Color(BasicColors.tertiary),
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
