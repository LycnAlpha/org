import 'package:flutter/material.dart';
import 'package:org_connect_pt/common/common_providers/leave_types_provider.dart';
import 'package:org_connect_pt/screens/employee_leave_screen/employee_leave_provider.dart';
import 'package:org_connect_pt/screens/employee_leave_screen/employee_leave_screen_widgets/employee_leaves_filter_dialog.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';
import 'package:org_connect_pt/utils/constants.dart';
import 'package:provider/provider.dart';

class EmployeeLeavesFilter extends StatefulWidget {
  final LeaveTypesProvider leaveTypesProvider;
  const EmployeeLeavesFilter({
    super.key,
    required this.leaveTypesProvider,
  });

  @override
  State<EmployeeLeavesFilter> createState() => _EmployeeLeavesFilterState();
}

class _EmployeeLeavesFilterState extends State<EmployeeLeavesFilter> {
  final TextEditingController _search = TextEditingController();

  @override
  void initState() {
    super.initState();

    _search.addListener(() {
      _searchCareGivers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EmployeeLeaveProvider>(
        builder: (context, employeeLeavesProvider, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: const Color(BasicColors.primary)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    color: const Color(BasicColors.tertiary),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _search,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: Colors.white,
                              isCollapsed: false,
                              filled: true,
                              hintText: 'Search employee leave requests',
                              hintStyle: TextStyle(
                                  color: const Color(BasicColors.primary)
                                      .withOpacity(0.5)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return EmployeeLeavesFilterDialog(
                                      employeeLeavesProvider:
                                          employeeLeavesProvider,
                                      leaveTypesProvider:
                                          widget.leaveTypesProvider);
                                },
                              );
                            },
                            child: Icon(
                              Icons.filter_list,
                              color: employeeLeavesProvider.isFiltered
                                  ? const Color(BasicColors.secondary)
                                  : const Color(BasicColors.primary),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
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
                          employeeLeavesProvider.setSelectedLeaveStatus(
                              0, context);
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
                              color:
                                  employeeLeavesProvider.selectedLeavestatus !=
                                          0
                                      ? const Color(BasicColors.primary)
                                      : Colors.transparent),
                          child: const Text(
                            'All',
                            style: TextStyle(
                              color: Color(BasicColors.tertiary),
                              /* color: employeeLeavesProvider.selectedLeavestatus != 0
                                  ? const Color(BasicColors.primary)
                                  : const Color(BasicColors.secondary),*/
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
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
                          employeeLeavesProvider.setSelectedLeaveStatus(
                              Constants.statusPending, context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          decoration: BoxDecoration(
                              color:
                                  employeeLeavesProvider.selectedLeavestatus !=
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
                              fontSize: 12,
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
                          employeeLeavesProvider.setSelectedLeaveStatus(
                              Constants.statusApproved, context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          decoration: BoxDecoration(
                              color:
                                  employeeLeavesProvider.selectedLeavestatus !=
                                          Constants.statusApproved
                                      ? const Color(BasicColors.primary)
                                      : Colors.transparent),
                          child: const Text(
                            'Approved',
                            style: TextStyle(
                              color: Color(BasicColors.tertiary),
                              /*  color: employeeLeavesProvider.selectedLeavestatus !=
                                      Constants.statusApproved
                                  ? const Color(BasicColors.primary)
                                  : const Color(BasicColors.secondary),*/
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
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
                          employeeLeavesProvider.setSelectedLeaveStatus(
                              Constants.statusRequestToCancel, context);
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
                              color:
                                  employeeLeavesProvider.selectedLeavestatus !=
                                          Constants.statusRequestToCancel
                                      ? const Color(BasicColors.primary)
                                      : Colors.transparent),
                          child: const Text(
                            'RTC',
                            style: TextStyle(
                              color: Color(BasicColors.tertiary),
                              /* color: employeeLeavesProvider.selectedLeavestatus !=
                                      Constants.statusRejected
                                  ? const Color(BasicColors.primary)
                                  : const Color(BasicColors.secondary),*/
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  _searchCareGivers() {
    Provider.of<EmployeeLeaveProvider>(
      context,
      listen: false,
    ).setKeyWord(_search.text.trim(), context);
  }
}
