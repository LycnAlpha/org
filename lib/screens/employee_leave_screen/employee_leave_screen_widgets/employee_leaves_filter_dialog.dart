import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:org_connect_pt/common/common_providers/leave_types_provider.dart';
import 'package:org_connect_pt/common/toasts.dart';
import 'package:org_connect_pt/models/leave_type.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen_widgets/custom_background.dart';
import 'package:org_connect_pt/screens/employee_leave_screen/employee_leave_provider.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';
import 'package:table_calendar/table_calendar.dart';

class EmployeeLeavesFilterDialog extends StatefulWidget {
  final EmployeeLeaveProvider employeeLeavesProvider;
  final LeaveTypesProvider leaveTypesProvider;
  const EmployeeLeavesFilterDialog({
    super.key,
    required this.employeeLeavesProvider,
    required this.leaveTypesProvider,
  });

  @override
  State<EmployeeLeavesFilterDialog> createState() =>
      _EmployeeLeavesFilterDialogState();
}

class _EmployeeLeavesFilterDialogState
    extends State<EmployeeLeavesFilterDialog> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: AlertDialog(
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              "Filters",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w600,
                color: Color(BasicColors.primary),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.cancel,
                color: Color(BasicColors.primary),
                size: 40.0,
              ),
            ),
          ],
        ),
        titlePadding: const EdgeInsets.all(15.0),
        contentPadding: const EdgeInsets.all(15.0),
        actionsPadding: const EdgeInsets.all(15.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            widget.leaveTypesProvider.isLoading
                ? const CustomBackground(
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Leave Type",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: Color(BasicColors.primary),
                        ),
                      )
                    ],
                  ))
                : widget.leaveTypesProvider.errorOccured
                    ? Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "Leave type filter error occurred",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: Color(BasicColors.primary),
                          ),
                        ),
                      )
                    : CustomBackground(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 17.0,
                            horizontal: 10.0,
                          ),
                          child: DropdownButtonFormField(
                            value:
                                widget.employeeLeavesProvider.leaveTypeFilter,
                            hint: const Text(
                              "Leave Type",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                color: Color(BasicColors.primary),
                              ),
                            ),
                            decoration: const InputDecoration(
                              isCollapsed: true,
                              border: InputBorder.none,
                            ),
                            onChanged: (newvalue) {
                              widget.employeeLeavesProvider
                                  .setSelectedLeaveType(newvalue, context);
                            },
                            items: widget.leaveTypesProvider.leaveTypesForFilter
                                .map<DropdownMenuItem<LeaveType>>(
                                    (LeaveType leaveType) {
                              return DropdownMenuItem<LeaveType>(
                                value: leaveType,
                                child: Text(
                                  leaveType.leaveTypeName,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                    color: Color(BasicColors.primary),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
            const SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => datePicker(false)).then((value) {
                  setState(() {});
                });
              },
              child: CustomBackground(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    bottom: 20.0,
                    left: 15.0,
                    right: 10.0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          widget.employeeLeavesProvider.fromDateFilter != null
                              ? 'From: ${DateFormat('yyyy-MM-dd').format(widget.employeeLeavesProvider.fromDateFilter!)}'
                              : 'From:',
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis,
                            color: Color(BasicColors.primary),
                          ),
                          maxLines: 2,
                        ),
                      ),
                      const Icon(
                        Icons.calendar_month,
                        size: 20,
                        color: Color(BasicColors.primary),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              onTap: () {
                /*  widget.employeeLeavesProvider.fromDateFilter != null
                    ? showDialog(
                        context: context,
                        builder: (context) => datePicker(true)).then((value) {
                        setState(() {});
                      })
                    : Toasts.showErrorToast('Please enter from date first');*/

                showDialog(
                    context: context,
                    builder: (context) => datePicker(true)).then((value) {
                  setState(() {});
                });
              },
              child: CustomBackground(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 20.0,
                    bottom: 20.0,
                    left: 15.0,
                    right: 10.0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          widget.employeeLeavesProvider.toDateFilter != null
                              ? 'To: ${DateFormat('yyyy-MM-dd').format(widget.employeeLeavesProvider.toDateFilter!)}'
                              : 'To:',
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.ellipsis,
                            color: Color(BasicColors.primary),
                          ),
                          maxLines: 2,
                        ),
                      ),
                      const Icon(
                        Icons.calendar_month,
                        size: 20,
                        color: Color(BasicColors.primary),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: GestureDetector(
              onTap: () {
                widget.employeeLeavesProvider.clearFilters(context);
                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 25.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: const Color(BasicColors.secondary),
                ),
                child: const Text(
                  'Clear Filters',
                  style: TextStyle(
                      color: Color(BasicColors.tertiary),
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget datePicker(bool isToDate) {
    return AlertDialog(
      content: SizedBox(
        height: 400,
        width: 350,
        child: TableCalendar(
          headerVisible: true,
          headerStyle: const HeaderStyle(
              titleCentered: true, formatButtonVisible: false),
          firstDay: DateTime.now().subtract(const Duration(days: 365 * 5)),
          lastDay: DateTime(DateTime.now().year, 13),
          focusedDay: DateTime.now(),
          selectedDayPredicate: (day) {
            return isSameDay(
                isToDate
                    ? widget.employeeLeavesProvider.toDateFilter
                    : widget.employeeLeavesProvider.fromDateFilter,
                day);
          },
          enabledDayPredicate: (day) {
            /* if (isToDate) {
              if (day.isBefore(widget.employeeLeavesProvider.fromDateFilter!)) {
                return false;
              }
            }*/
            return true;
          },
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(
                isToDate
                    ? widget.employeeLeavesProvider.toDateFilter
                    : widget.employeeLeavesProvider.fromDateFilter,
                selectedDay)) {
              setState(() {
                isToDate
                    ? widget.employeeLeavesProvider
                        .setSelectedToDate(selectedDay, context)
                    : widget.employeeLeavesProvider
                        .setSelectedFromDate(selectedDay, context);
              });
              if (widget.employeeLeavesProvider.toDateFilter != null &&
                  widget.employeeLeavesProvider.fromDateFilter != null) {
                if (widget.employeeLeavesProvider.toDateFilter!
                    .isBefore(widget.employeeLeavesProvider.fromDateFilter!)) {
                  Toasts.showErrorToast('To date must be after From date');
                }
              }

              Navigator.pop(context);
            }
          },
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: () {
              isToDate
                  ? widget.employeeLeavesProvider
                      .setSelectedToDate(null, context)
                  : widget.employeeLeavesProvider
                      .setSelectedFromDate(null, context);

              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.center,
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: const Color(BasicColors.secondary),
              ),
              child: const Text(
                'Clear Date',
                style: TextStyle(
                    color: Color(BasicColors.tertiary),
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
            ),
          ),
        )
      ],
    );
  }
}
