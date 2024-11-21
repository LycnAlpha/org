import 'package:flutter/material.dart';
import 'package:org_connect_pt/screens/personal_leave_screen/personal_leave_provider.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';
import 'package:org_connect_pt/utils/constants.dart';
import 'package:provider/provider.dart';

class PersonalLeaveFilter extends StatelessWidget {
  const PersonalLeaveFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Consumer<PersonalLeaveProvider>(
          builder: (context, personalLeaveProvider, child) {
        return Container(
          padding: const EdgeInsets.all(2.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: const Color(BasicColors.secondary).withOpacity(0.75)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: GestureDetector(
                    onTap: () {
                      personalLeaveProvider.setSelectedLeaveStatus(
                          Constants.statusApproved, context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0),
                          ),
                          color: personalLeaveProvider.selectedLeavestatus !=
                                  Constants.statusApproved
                              ? const Color(BasicColors.primary)
                              : Colors.transparent),
                      child: const Text(
                        'Approved',
                        style: TextStyle(
                          color: Color(BasicColors.tertiary),
                          /* color: employeeLeavesProvider.selectedLeavestatus != 0
                                    ? const Color(BasicColors.primary)
                                    : const Color(BasicColors.secondary),*/
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: GestureDetector(
                    onTap: () {
                      personalLeaveProvider.setSelectedLeaveStatus(
                          Constants.statusPending, context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      decoration: BoxDecoration(
                          color: personalLeaveProvider.selectedLeavestatus !=
                                  Constants.statusPending
                              ? const Color(BasicColors.primary)
                              : Colors.transparent),
                      child: const Text(
                        'Pending',
                        style: TextStyle(
                          color: Color(BasicColors.tertiary),
                          /*  color: employeeLeavesProvider.selectedLeavestatus !=
                                        Constants.statusRequestToCancel
                                    ? const Color(BasicColors.primary)
                                    : const Color(BasicColors.secondary),*/
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: GestureDetector(
                    onTap: () {
                      personalLeaveProvider.setSelectedLeaveStatus(
                          Constants.statusRejected, context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      decoration: BoxDecoration(
                          color: personalLeaveProvider.selectedLeavestatus !=
                                  Constants.statusRejected
                              ? const Color(BasicColors.primary)
                              : Colors.transparent),
                      child: const Text(
                        'Rejected',
                        style: TextStyle(
                          color: Color(BasicColors.tertiary),
                          /*  color: employeeLeavesProvider.selectedLeavestatus !=
                                        Constants.statusApproved
                                    ? const Color(BasicColors.primary)
                                    : const Color(BasicColors.secondary),*/
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: GestureDetector(
                    onTap: () {
                      personalLeaveProvider.setSelectedLeaveStatus(
                          Constants.statusRequestToCancel, context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      decoration: BoxDecoration(
                          color: personalLeaveProvider.selectedLeavestatus !=
                                  Constants.statusRequestToCancel
                              ? const Color(BasicColors.primary)
                              : Colors.transparent),
                      child: const Text(
                        'RTC',
                        style: TextStyle(
                          color: Color(BasicColors.tertiary),
                          /*  color: employeeLeavesProvider.selectedLeavestatus !=
                                        Constants.statusApproved
                                    ? const Color(BasicColors.primary)
                                    : const Color(BasicColors.secondary),*/
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: GestureDetector(
                    onTap: () {
                      personalLeaveProvider.setSelectedLeaveStatus(
                          Constants.statusCanceled, context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          ),
                          color: personalLeaveProvider.selectedLeavestatus !=
                                  Constants.statusCanceled
                              ? const Color(BasicColors.primary)
                              : Colors.transparent),
                      child: const Text(
                        'Cancelled',
                        style: TextStyle(
                          color: Color(BasicColors.tertiary),
                          /* color: employeeLeavesProvider.selectedLeavestatus !=
                                        Constants.statusRejected
                                    ? const Color(BasicColors.primary)
                                    : const Color(BasicColors.secondary),*/
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
