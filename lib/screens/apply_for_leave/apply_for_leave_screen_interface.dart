import 'package:flutter/material.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen_providers/apply_for_leave_data_provider.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen_widgets/calculated_leave_count.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen_widgets/contact_number_text_field.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen_widgets/date_selection_calendar.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen_widgets/drop_down_acting_arrangement.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen_widgets/drop_down_leave_type.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen_widgets/reason_text_field.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';
import 'package:provider/provider.dart';

class ApplyForLeaveScreenInterface extends StatelessWidget {
  final applyLeave;
  const ApplyForLeaveScreenInterface({
    super.key,
    this.applyLeave,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Consumer<ApplyForLeaveDataProvider>(
            builder: (context, applyForLeaveDataProvider, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DateSelectionCalendar(
                  applyForLeaveDataProvider: applyForLeaveDataProvider),
              const CalculatedLeaveCount(),
              const DropDownLeaveType(),
              const ReasonTextField(),
              const DropDownActingArrangement(),
              const ContactNumberTextField(),
              // const UploadImageField(),
              Visibility(
                visible: applyForLeaveDataProvider.selectedFromDate != null &&
                    applyForLeaveDataProvider.selectedToDate != null &&
                    applyForLeaveDataProvider.selectedLeaveType != null &&
                    applyForLeaveDataProvider.reason.isNotEmpty &&
                    applyForLeaveDataProvider.enteredContactNumber.isNotEmpty,
                child: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: submitButton(context)),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget submitButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onTap: applyLeave,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              color: const Color(BasicColors.secondary)),
          child: const Text(
            'Submit',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(BasicColors.tertiary),
                fontWeight: FontWeight.w900,
                fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}
