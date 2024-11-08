import 'package:flutter/material.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen_providers/apply_for_leave_data_provider.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';
import 'package:provider/provider.dart';

class CalculatedLeaveCount extends StatelessWidget {
  const CalculatedLeaveCount({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplyForLeaveDataProvider>(
      builder: (context, applyForLeaveDataProvider, _) {
        if (applyForLeaveDataProvider.errorCalculatingDates) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                padding: const EdgeInsets.all(15.0),
                color: Colors.red.withOpacity(0.60),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Invalid Dates !',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                        color: Color(BasicColors.tertiary),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Please review the selected form/to date.',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: Color(BasicColors.tertiary),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: Visibility(
              visible: applyForLeaveDataProvider.calculatedLeaveCount != 0.0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(BasicColors.secondary),
                        border: Border.all(
                            color: const Color(BasicColors.secondary))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'No. of Days: ',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700,
                            color: Color(BasicColors.tertiary),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Container(
                          padding: const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                              color: const Color(BasicColors.primary),
                              border: Border.all(
                                  color: const Color(BasicColors.primary)),
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0))),
                          child: Text(
                            '${applyForLeaveDataProvider.calculatedLeaveCount}',
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                              color: Color(BasicColors.tertiary),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
