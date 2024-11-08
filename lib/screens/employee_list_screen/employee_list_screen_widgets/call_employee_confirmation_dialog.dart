import 'package:flutter/material.dart';
import 'package:org_connect_pt/common/common_widgets/simple_action_button.dart';
import 'package:org_connect_pt/common/text_objects.dart';
import 'package:org_connect_pt/models/employee.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';

class CallEmployeeConfirmationDialog extends StatelessWidget {
  final Employee employee;
  const CallEmployeeConfirmationDialog({
    super.key,
    required this.employee,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        title: dialogBoxTitle(
          'Call ${employee.firstName}',
        ),
        backgroundColor: Color(BasicColors.tertiary),
        titlePadding: const EdgeInsets.all(15.0),
        contentPadding: const EdgeInsets.all(15.0),
        actionsPadding: const EdgeInsets.all(15.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: dialogBoxContent(
              context, 'Are you sure you want to call ${employee.firstName} ?'),
        ),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SimpleActionButton(
                  displayText: 'No',
                  color: const Color(BasicColors.primary),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: SimpleActionButton(
                  displayText: 'Yes',
                  color: const Color(BasicColors.secondary),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
