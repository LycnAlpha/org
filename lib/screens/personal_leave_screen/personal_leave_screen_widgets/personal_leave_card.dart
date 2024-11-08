import 'package:flutter/material.dart';
import 'package:org_connect_pt/common/common_dialogs/cancel_leave_confirmation_dialog.dart';
import 'package:org_connect_pt/common/common_dialogs/rtc_leave_confirmation_dialog.dart';
import 'package:org_connect_pt/helpers/status_handle_helper.dart';
import 'package:org_connect_pt/models/leave.dart';
import 'package:org_connect_pt/screens/personal_leave_screen/personal_leave_provider.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';
import 'package:org_connect_pt/utils/constants.dart';
import 'package:provider/provider.dart';

class PersonalLeaveCard extends StatelessWidget {
  final Leave leave;
  const PersonalLeaveCard({
    super.key,
    required this.leave,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: leave.statusId == Constants.statusApproved ||
              leave.statusId == Constants.statusPending
          ? Dismissible(
              key: Key(leave.leaveId.toString()),
              background: dismissibleBackground(),
              onDismissed: (direction) {
                leave.statusId == Constants.statusApproved
                    ? showDialog(
                        context: context,
                        builder: (ctx) => RtcLeaveConfirmationDialog(
                          leave: leave,
                        ),
                      ).then((value) {
                        Provider.of<PersonalLeaveProvider>(
                          context,
                          listen: false,
                        ).getPersonalLeaves(context);
                      })
                    : showDialog(
                        context: context,
                        builder: (ctx) => CancelLeaveConfirmationDialog(
                          leave: leave,
                        ),
                      ).then((value) {
                        Provider.of<PersonalLeaveProvider>(
                          context,
                          listen: false,
                        ).getPersonalLeaves(context);
                      });
              },
              child: content(context),
            )
          : content(context),
    );
  }

  Widget dismissibleBackground() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: const Color(BasicColors.secondary).withOpacity(0.75),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            leave.statusId == Constants.statusApproved
                ? 'Request to cancel...'
                : 'Cancel...',
            style: const TextStyle(
              color: Color(BasicColors.tertiary),
              fontSize: 25.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          const Center(
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

  Widget content(BuildContext context) {
    return Container(
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
      child: Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: const EdgeInsets.all(2.0),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(BasicColors.primary),
                ),
                child: Center(
                  child: CircleAvatar(
                    radius: 40.0,
                    backgroundColor: const Color(BasicColors.tertiary),
                    child: Text(
                      leave.leavetypeName != null
                          ? leave.leavetypeName!.substring(0, 1)
                          : 'L',
                      style: const TextStyle(
                          color: Color(BasicColors.secondary), fontSize: 50.0),
                    ),
                  ),
                ),
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
                      leave.leavetypeName ?? 'Leave',
                      style: const TextStyle(
                          color: Color(BasicColors.primary),
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                    Text(
                      'From: ${leave.startDate} (${leave.startShiftName})',
                      style: const TextStyle(
                          color: Color(BasicColors.primary),
                          // fontWeight: FontWeight.w500,
                          fontSize: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'To: ${leave.endDate} (${leave.endShiftName})',
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
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color:
                    Color(StatusHandleHelper.getStatusColor(leave.statusId))),
            child: Text(
              leave.statusDescription,
              style: const TextStyle(
                  color: Color(BasicColors.tertiary),
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0),
            ),
          )
        ],
      ),
    );
  }
}
