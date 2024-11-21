import 'package:flutter/material.dart';
import 'package:org_connect_pt/common/common_dialogs/cancel_leave_confirmation_dialog.dart';
import 'package:org_connect_pt/common/common_dialogs/rtc_leave_confirmation_dialog.dart';
import 'package:org_connect_pt/helpers/status_handle_helper.dart';
import 'package:org_connect_pt/models/leave.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';
import 'package:org_connect_pt/utils/constants.dart';

class PersonalLeaveDetails extends StatelessWidget {
  final Leave leave;
  const PersonalLeaveDetails({
    super.key,
    required this.leave,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Leave Details',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: Color(0xff1C577D),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(BasicColors.tertiary),
      ),
      backgroundColor: const Color(BasicColors.tertiary),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 25.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Color(
                            StatusHandleHelper.getStatusColor(leave.statusId))),
                    child: Text(
                      leave.statusDescription,
                      style: const TextStyle(
                          color: Color(BasicColors.tertiary),
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ),
                ],
              ),
              const Expanded(
                child: SizedBox(),
              ),
              Text(
                '${leave.employeeName} ${leave.leaveId}',
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Color(BasicColors.primary),
                    fontWeight: FontWeight.w500,
                    fontSize: 25),
              ),
              Text(
                '${leave.leavetypeName ?? 'Leave'} Request',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Color(BasicColors.secondary),
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Expanded(
                child: SizedBox(),
              ),
              Container(
                // height: MediaQuery.of(context).size.height * 0.4,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(BasicColors.tertiary),
                  border: Border.all(
                    color: const Color(BasicColors.secondary),
                    width: 2.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3.0,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'From: ${leave.startDate} (${leave.startSegment})',
                      style: const TextStyle(
                          color: Color(BasicColors.primary),
                          // fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                    Divider(
                      color: Colors.grey.shade200,
                      thickness: 2,
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
                    Divider(
                      color: Colors.grey.shade200,
                      thickness: 2,
                    ),
                    Text(
                      'Number of Days: ${leave.dayCount}',
                      style: const TextStyle(
                          color: Color(BasicColors.primary),
                          // fontWeight: FontWeight.w500,
                          fontSize: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Divider(
                      color: Colors.grey.shade200,
                      thickness: 2,
                    ),
                    SingleChildScrollView(
                      child: Text(
                        'Reason: ${leave.reason}',
                        style: const TextStyle(
                            color: Color(BasicColors.primary),
                            // fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                    ),
                    Divider(
                      color: Colors.grey.shade200,
                      thickness: 2,
                    ),
                    Text(
                      'Contact No: ${leave.contactNumber}',
                      style: const TextStyle(
                          color: Color(BasicColors.primary),
                          // fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                    Divider(
                      color: Colors.grey.shade200,
                      thickness: 2,
                    ),
                    Text(
                      'Backup Employee: ${leave.backupEmployeeName}',
                      style: const TextStyle(
                          color: Color(BasicColors.primary),
                          // fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                    Visibility(
                      visible: leave.leaveRejectionReason != null &&
                          leave.leaveRejectionReason!.isNotEmpty,
                      child: Divider(
                        color: Colors.grey.shade200,
                        thickness: 2,
                      ),
                    ),
                    Visibility(
                      visible: leave.leaveRejectionReason != null &&
                          leave.leaveRejectionReason!.isNotEmpty,
                      child: Text(
                        'Rejected reason: ${leave.leaveRejectionReason}',
                        style: const TextStyle(
                            color: Color(BasicColors.primary),
                            // fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              actionButtonArea(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget actionButtonArea(BuildContext context) {
    return Visibility(
        visible: leave.statusId == Constants.statusPending ||
            leave.statusId == Constants.statusApproved,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: leave.statusId == Constants.statusPending
                  ? actionButton(
                      label: 'Cancel Leave Request',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => CancelLeaveConfirmationDialog(
                            leave: leave,
                          ),
                        ).then((value) {
                          Navigator.pop(context);
                        });
                      },
                      color: const Color(BasicColors.secondary),
                    )
                  : actionButton(
                      label: 'Request to cancel',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (ctx) => RtcLeaveConfirmationDialog(
                            leave: leave,
                          ),
                        ).then((value) {
                          Navigator.pop(context);
                        });
                      },
                      color: const Color(BasicColors.secondary),
                    ),
            ),
          ],
        ));
  }

  Widget actionButton({
    required String label,
    required onPressed,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: color,
          ),
          child: Text(
            label,
            style: const TextStyle(
                color: Color(BasicColors.tertiary),
                fontWeight: FontWeight.bold,
                fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}
