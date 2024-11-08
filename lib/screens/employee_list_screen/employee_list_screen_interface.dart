import 'package:flutter/material.dart';
import 'package:org_connect_pt/screens/employee_list_screen/employee_list_screen_widgets/employee_list.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';

class EmployeeListScreenInterface extends StatelessWidget {
  final refresh;
  const EmployeeListScreenInterface({
    super.key,
    this.refresh,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(BasicColors.tertiary),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: EmployeeList(
              refresh: refresh,
            ),
          ),
        ],
      ),
    );
  }
}
