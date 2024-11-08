import 'package:flutter/material.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen_providers/apply_for_leave_data_provider.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen_widgets/custom_background.dart';
import 'package:provider/provider.dart';

class ReasonTextField extends StatelessWidget {
  const ReasonTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: CustomBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 15.0,
          ),
          child: TextFormField(
            style: customTextStyle(),
            decoration: InputDecoration(
                //isCollapsed: true,
                border: InputBorder.none,
                hintText: 'Reason*',
                hintStyle: customTextStyle()),
            onChanged: (value) {
              setReason(value.trim(), context);
            },
          ),
        ),
      ),
    );
  }

  Widget buttonBackground({required Widget child}) {
    return CustomBackground(
        child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 17.0,
              horizontal: 15.0,
            ),
            child: child));
  }

  TextStyle customTextStyle() {
    return const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Color(0xff1C577D),
      overflow: TextOverflow.fade,
    );
  }

  Future<void> setReason(String reason, BuildContext context) async {
    Provider.of<ApplyForLeaveDataProvider>(
      context,
      listen: false,
    ).setReason(reason);
  }
}
