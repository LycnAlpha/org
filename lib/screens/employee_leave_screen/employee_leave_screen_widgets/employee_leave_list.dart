import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:org_connect_pt/screens/employee_leave_screen/employee_leave_provider.dart';
import 'package:org_connect_pt/screens/employee_leave_screen/employee_leave_screen_widgets/employee_leave_card.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';
import 'package:provider/provider.dart';

class EmployeeLeaveList extends StatefulWidget {
  final retry;
  const EmployeeLeaveList({
    super.key,
    this.retry,
  });

  @override
  State<EmployeeLeaveList> createState() => _EmployeeLeaveListState();
}

class _EmployeeLeaveListState extends State<EmployeeLeaveList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.95) {
      Provider.of<EmployeeLeaveProvider>(
        context,
        listen: false,
      ).getMoreLeaves(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 5.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                'Leave Requests',
                style: TextStyle(
                    color: Color(BasicColors.primary),
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),
              ),
            ),
            Expanded(child: Consumer<EmployeeLeaveProvider>(
                builder: (context, employeeLeavesProvider, child) {
              if (employeeLeavesProvider.isLoading) {
                return const Center(
                  child: SpinKitThreeBounce(
                    color: Color(BasicColors.primary),
                  ),
                );
              } else if (employeeLeavesProvider.errorOccured &&
                  employeeLeavesProvider.filteredList.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      employeeLeavesProvider.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.red,
                          fontWeight: FontWeight.w400),
                    ),
                    IconButton(
                        onPressed: widget.retry,
                        icon: const Icon(
                          Icons.refresh,
                          color: Colors.red,
                          size: 30,
                        ))
                  ],
                );
              } else if (employeeLeavesProvider.filteredList.isEmpty &&
                  employeeLeavesProvider.isFiltered) {
                return const Center(
                  child: Text(
                    'No Results available',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.red,
                        fontWeight: FontWeight.w400),
                  ),
                );
              } else {
                return RefreshIndicator(
                  onRefresh: widget.retry,
                  child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(5.0),
                      itemCount: employeeLeavesProvider.hasMorePages
                          ? employeeLeavesProvider.filteredList.length + 1
                          : employeeLeavesProvider.filteredList.length,
                      itemBuilder: (context, index) {
                        if (index ==
                            employeeLeavesProvider.filteredList.length) {
                          if (employeeLeavesProvider.errorOccured) {
                            return Text(
                              'List loading error: ${employeeLeavesProvider.message}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontWeight: FontWeight.bold),
                            );
                          } else {
                            return GestureDetector(
                              onTap: () {
                                employeeLeavesProvider.getMoreLeaves(context);
                              },
                              child: const Text(
                                'Load More',
                                textAlign: TextAlign.center,
                              ),
                            );
                            /* return const SpinKitCircle(
                              color: Color(BasicColors.primary),
                            );*/
                          }
                        } else {
                          return EmployeeLeaveCard(
                            leave: employeeLeavesProvider.filteredList[index],
                          );
                        }
                      }),
                );
              }
            }))
          ],
        ),
      ),
    );
  }
}
