import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:org_connect_pt/common/common_providers/leave_balance_provider.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';
import 'package:provider/provider.dart';

class RemainingLeavesCard extends StatelessWidget {
  final retry;
  const RemainingLeavesCard({
    super.key,
    this.retry,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<LeaveBalanceProvider>(
        builder: (context, leaveBalanceProvider, child) {
      if (leaveBalanceProvider.isLoading) {
        return cardLayout(
          child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.5),
                  child: SpinKitCircle(
                    color: Color(BasicColors.primary),
                    size: 40,
                  ),
                ),
              ]),
        );
      } else if (leaveBalanceProvider.errorOccured) {
        return cardLayout(
            child: GestureDetector(
          onTap: retry,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 1.5),
                child: Icon(
                  Icons.refresh,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
          ),
        ));
      } else {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Container(
            height: 100,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Color(BasicColors.tertiary),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  offset: const Offset(0, 0),
                  blurRadius: 7,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      const Text(
                        'Remaining \nLeaves',
                        style: TextStyle(
                            color: Color(BasicColors.primary),
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Image.asset('assets/icons/icon_remaining_leaves.png')
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 5.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  color: const Color(BasicColors.primary)),
                              color: const Color(BasicColors.primary)
                                  .withOpacity(0.1)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Row(
                                  children: [
                                    const Expanded(child: SizedBox()),
                                    Text(
                                      leaveBalanceProvider
                                                      .getTotalEntitledLeaveCount() %
                                                  1 ==
                                              0
                                          ? '${leaveBalanceProvider.getTotalEntitledLeaveCount().toInt()}'
                                          : '${leaveBalanceProvider.getTotalEntitledLeaveCount()}',
                                      style: const TextStyle(
                                          fontSize: 30.0,
                                          color: Color(BasicColors.primary),
                                          fontWeight: FontWeight.w800),
                                    ),
                                    const Expanded(child: SizedBox()),
                                  ],
                                ),
                              ),
                              const Flexible(flex: 1, child: SizedBox()),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 5.0),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        bottomLeft: Radius.circular(10.0)),
                                    border: Border.all(
                                        color:
                                            const Color(BasicColors.secondary)),
                                    color: const Color.fromARGB(
                                        255, 255, 248, 238)),
                                child: Row(
                                  children: [
                                    const Expanded(child: SizedBox()),
                                    Text(
                                      leaveBalanceProvider
                                                      .getTotalLeaveBalance() %
                                                  1 ==
                                              0
                                          ? '${leaveBalanceProvider.getTotalLeaveBalance().toInt()}'
                                          : '${leaveBalanceProvider.getTotalLeaveBalance()}',
                                      style: const TextStyle(
                                          fontSize: 30.0,
                                          color: Color(BasicColors.secondary),
                                          fontWeight: FontWeight.w800),
                                    ),
                                    const Expanded(child: SizedBox()),
                                  ],
                                ),
                              ),
                            ),
                            const Flexible(flex: 1, child: SizedBox()),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    });
  }

  Widget cardLayout({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: const Color(BasicColors.tertiary),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: const Offset(0, 0),
              blurRadius: 7,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  const Text(
                    'Remaining \nLeaves',
                    style: TextStyle(
                        color: Color(BasicColors.primary),
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Image.asset('assets/icons/icon_remaining_leaves.png')
                ],
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 5.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                              color: const Color(BasicColors.primary)),
                          color: const Color(BasicColors.primary)
                              .withOpacity(0.1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Row(
                              children: [
                                const Expanded(child: SizedBox()),
                                child,
                                const Expanded(child: SizedBox()),
                              ],
                            ),
                          ),
                          const Flexible(flex: 1, child: SizedBox()),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 5.0),
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(10.0)),
                                border: Border.all(
                                    color: const Color(BasicColors.secondary)),
                                color:
                                    const Color.fromARGB(255, 255, 248, 238)),
                            child: Row(
                              children: [
                                const Expanded(child: SizedBox()),
                                child,
                                const Expanded(child: SizedBox()),
                              ],
                            ),
                          ),
                        ),
                        const Flexible(flex: 1, child: SizedBox()),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
