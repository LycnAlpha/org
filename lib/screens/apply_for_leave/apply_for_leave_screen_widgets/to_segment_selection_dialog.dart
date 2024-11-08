import 'package:flutter/material.dart';
import 'package:org_connect_pt/common/common_widgets/simple_action_button.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen_providers/apply_for_leave_data_provider.dart';
import 'package:org_connect_pt/utils/constants.dart';

class ToSegmentSelectionDialog extends StatelessWidget {
  final ApplyForLeaveDataProvider applyForLeaveDataProvider;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  final DateTime? focusedDay;

  const ToSegmentSelectionDialog({
    super.key,
    required this.applyForLeaveDataProvider,
    this.rangeStart,
    this.rangeEnd,
    this.focusedDay,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        backgroundColor: Colors.transparent,
        titlePadding: const EdgeInsets.all(15.0),
        contentPadding: const EdgeInsets.all(15.0),
        actionsPadding: const EdgeInsets.all(15.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SimpleActionButton(
                displayText: 'Morning',
                color: const Color(0xffFB9F2D),
                onPressed: () {
                  applyForLeaveDataProvider.setToDate(rangeEnd!);
                  applyForLeaveDataProvider
                      .setToSegment(Constants.segmentMorning);

                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                width: 10.0,
              ),
              SimpleActionButton(
                  displayText: 'Evening',
                  color: const Color(0xffFB9F2D),
                  onPressed: () {
                    applyForLeaveDataProvider.setToDate(rangeEnd!);
                    applyForLeaveDataProvider
                        .setToSegment(Constants.segmentEvening);

                    Navigator.pop(context);
                  }),
              const SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
