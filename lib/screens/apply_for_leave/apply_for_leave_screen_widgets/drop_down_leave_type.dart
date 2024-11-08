import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:org_connect_pt/common/common_providers/leave_balance_provider.dart';
import 'package:org_connect_pt/models/leave_balance.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen_providers/apply_for_leave_data_provider.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen_widgets/custom_background.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';
import 'package:provider/provider.dart';

class DropDownLeaveType extends StatefulWidget {
  const DropDownLeaveType({super.key});

  @override
  State<DropDownLeaveType> createState() => _DropDownLeaveTypeState();
}

class _DropDownLeaveTypeState extends State<DropDownLeaveType> {
  final String fieldName = 'Leave Type*';
  String? selectedType;
  LeaveBalance? selectedLeavetype;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Consumer<LeaveBalanceProvider>(
            builder: (context, backupEmployeesProvider, child) {
          if (backupEmployeesProvider.isLoading) {
            return buttonBackground(
                child: const SpinKitThreeBounce(
              color: Color(BasicColors.primary),
              size: 20.0,
            ));
          } else if (backupEmployeesProvider.errorOccured) {
            return buttonBackground(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  backupEmployeesProvider.message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.red,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                GestureDetector(
                  onTap: () {
                    backupEmployeesProvider.getLeaveBalances(context);
                  },
                  child: const Icon(
                    Icons.refresh,
                    color: Colors.red,
                    size: 20,
                  ),
                )
              ],
            ));
          } else {
            return buttonBackground(
              child: DropdownButtonFormField(
                value: selectedLeavetype,
                icon: const Icon(Icons.arrow_drop_down),
                iconEnabledColor: const Color(0xff1C577D),
                iconSize: 20.0,
                hint: Text(
                  fieldName,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff1C577D),
                    overflow: TextOverflow.clip,
                  ),
                ),
                decoration: const InputDecoration(
                    isCollapsed: true, border: InputBorder.none),
                onChanged: (leaveType) {
                  setState(() {
                    selectedLeavetype = leaveType;
                  });

                  setLeaveType(leaveType!);
                },
                items: backupEmployeesProvider.leaveBalances
                    .map<DropdownMenuItem<LeaveBalance>>(
                        (LeaveBalance leaveType) {
                  return DropdownMenuItem<LeaveBalance>(
                    value: leaveType,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          leaveType.leavetypeName,
                          style: customTextStyle(),
                        ),
                        Text(
                          leaveType.balanceCount % 1 == 0
                              ? (leaveType.balanceCount - leaveType.holdCount) <
                                      10
                                  ? '(0${(leaveType.balanceCount - leaveType.holdCount).toInt()})'
                                  : '(${(leaveType.balanceCount - leaveType.holdCount).toInt()})'
                              : (leaveType.balanceCount - leaveType.holdCount) <
                                      10
                                  ? '(0${(leaveType.balanceCount - leaveType.holdCount)})'
                                  : '(${(leaveType.balanceCount - leaveType.holdCount)})',
                          style: customTextStyle(),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          }
        }));
  }

  TextStyle customTextStyle() {
    return const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Color(0xff1C577D),
      overflow: TextOverflow.fade,
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

  Future<void> setLeaveType(LeaveBalance leaveType) async {
    Provider.of<ApplyForLeaveDataProvider>(
      context,
      listen: false,
    ).setSelectedLeaveType(leaveType);
  }
}
