import 'package:flutter/material.dart';
import 'package:org_connect_pt/models/leave_balance.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';

class AvailableLeaveCard extends StatelessWidget {
  final LeaveBalance leaveBalance;

  const AvailableLeaveCard({
    super.key,
    required this.leaveBalance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(BasicColors.tertiary),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
              color: const Color(BasicColors.primary).withOpacity(0.4))),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  leaveBalance.leavetypeName,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(BasicColors.primary),
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.clip,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.elliptical(40.0, 80.0),
                      bottomLeft: Radius.elliptical(40.0, 80.0),
                    ),
                    color: Color(BasicColors.primary),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            leaveBalance.balanceCount % 1 == 0
                                ? (leaveBalance.balanceCount -
                                            leaveBalance.holdCount) <
                                        10
                                    ? '0${(leaveBalance.balanceCount - leaveBalance.holdCount).toInt()}'
                                    : '${(leaveBalance.balanceCount - leaveBalance.holdCount).toInt()}'
                                : (leaveBalance.balanceCount -
                                            leaveBalance.holdCount) <
                                        10
                                    ? '0${(leaveBalance.balanceCount - leaveBalance.holdCount)}'
                                    : '${(leaveBalance.balanceCount - leaveBalance.holdCount)}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25.0),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        //SizedBox(width: 10.0,),
                        Expanded(
                          child: Text(
                            leaveBalance.entitledCount % 1 == 0
                                ? '/${leaveBalance.entitledCount.toInt()}'
                                : '/${leaveBalance.entitledCount}',
                            // '/taken',
                            style: const TextStyle(
                              color: Colors.white54,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              overflow: TextOverflow.ellipsis,
                            ),
                            textAlign: TextAlign.left,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
