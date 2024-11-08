import 'package:flutter/material.dart';
import 'package:org_connect_pt/common/common_dialogs/disable_user_interface_dialog.dart';
import 'package:org_connect_pt/common/common_widgets/simple_action_button.dart';
import 'package:org_connect_pt/common/text_objects.dart';
import 'package:org_connect_pt/common/toasts.dart';
import 'package:org_connect_pt/helpers/api_validation_helper.dart';
import 'package:org_connect_pt/helpers/shared_preference_helper.dart';
import 'package:org_connect_pt/models/api_response.dart';
import 'package:org_connect_pt/models/leave.dart';
import 'package:org_connect_pt/screens/login_screen/login_screen.dart';
import 'package:org_connect_pt/services/leave_services.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';
import 'package:org_connect_pt/utils/constants.dart';

class ApproveLeaveConfirmationDialog extends StatelessWidget {
  final Leave leave;
  const ApproveLeaveConfirmationDialog({
    super.key,
    required this.leave,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        title: dialogBoxTitle(
          'Approve Leave Request',
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
              context, 'Are You Sure You Want to approve this leave request?'),
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
                    //approve flow
                    approveLeave(context);
                  },
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  approveLeave(BuildContext context) async {
    showDialog(
      context: context,
      builder: (ctx) => const DisableUserInteractionDialog(),
    );

    String authToken = await SharedPreferenceHelper.getAuthToken();

    await LeaveServices.changeLeaveRequestStatus(
      authToken,
      leave.leaveId,
      Constants.statusApproved,
    ).then((result) {
      try {
        if (result != null) {
          if (result is String) {
            _onFailed(result, context);
          } else if (result is int) {
            _sessionExpired(context);
          } else {
            _onSuccess(result, context);
          }
        } else {
          _onFailed(getErrorMessage(Constants.nullException), context);
        }
      } catch (e) {
        _onFailed(getErrorMessage(Constants.unknownException), context);
      }
    });
  }

  _onFailed(String message, BuildContext context) {
    Navigator.pop(context);
    Navigator.pop(context);
    Toasts.showErrorToast(message);
  }

  _sessionExpired(BuildContext context) {
    Toasts.showErrorToast('Session Expired');
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  _onSuccess(APIResponse response, BuildContext context) {
    Toasts.showSuccessToast(response.message ?? 'Success');
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
