import 'package:flutter/material.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen.dart';
import 'package:org_connect_pt/screens/personal_leave_screen/personal_leave_screen_widgets/available_leave_card_grid.dart';
import 'package:org_connect_pt/screens/personal_leave_screen/personal_leave_screen_widgets/personal_leave_list.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';

class PersonalLeaveScreenInterface extends StatelessWidget {
  final retry;
  const PersonalLeaveScreenInterface({
    super.key,
    this.retry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      color: const Color(BasicColors.tertiary),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          AvailableLeaveCardGrid(
            retry: retry,
          ),
          applyLeaveButton(context),
          PersonalLeaveList(
            retry: retry,
          ),
        ],
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
          );
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
}
