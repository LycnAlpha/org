import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:org_connect_pt/common/common_providers/leave_balance_provider.dart';
import 'package:org_connect_pt/screens/personal_leave_screen/personal_leave_screen_widgets/available_leave_card.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';
import 'package:provider/provider.dart';

class AvailableLeaveCardGrid extends StatelessWidget {
  final retry;
  const AvailableLeaveCardGrid({
    super.key,
    this.retry,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Container(
        height: 200,
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: const Color(BasicColors.tertiary),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 7.0,
              offset: const Offset(0, 3.0),
            ),
          ],
        ),
        child: Consumer<LeaveBalanceProvider>(
            builder: (context, leavebalanceProvider, child) {
          if (leavebalanceProvider.isLoading) {
            return const Center(
              child: SpinKitThreeBounce(
                color: Color(BasicColors.primary),
              ),
            );
          } else if (leavebalanceProvider.errorOccured) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  leavebalanceProvider.message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.red,
                      fontWeight: FontWeight.w400),
                ),
                GestureDetector(
                  onTap: retry,
                  child: IconButton(
                      onPressed: retry,
                      icon: const Icon(
                        Icons.refresh,
                        color: Colors.red,
                        size: 30,
                      )),
                )
              ],
            );
          } else {
            return GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                childAspectRatio: 0.5,
                mainAxisSpacing: 10,
              ),
              itemCount: leavebalanceProvider.leaveBalances.length,
              itemBuilder: (context, index) {
                return AvailableLeaveCard(
                  leaveBalance: leavebalanceProvider.leaveBalances[index],
                );
              },
            );
          }
        }),
      ),
    );
  }
}
