import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:org_connect_pt/models/employee.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen_providers/apply_for_leave_data_provider.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen_providers/backup_employees_provider.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen_widgets/custom_background.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';
import 'package:provider/provider.dart';

class DropDownActingArrangement extends StatefulWidget {
  final retry;
  const DropDownActingArrangement({
    super.key,
    this.retry,
  });

  @override
  State<DropDownActingArrangement> createState() =>
      _DropDownActingArrangementState();
}

class _DropDownActingArrangementState extends State<DropDownActingArrangement> {
  final String fieldName = 'Acting arrangment';
  final leaveTypes = {'Dimal', 'Shavinda'};

  String? selectedType;
  Employee? backupEmployee;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Consumer<BackupEmployeesProvider>(
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
                    backupEmployeesProvider.getBackupEmployees(context);
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
                value: backupEmployee,
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
                onChanged: (employee) {
                  setState(() {
                    backupEmployee = employee;
                  });
                  setBackupEmployee(employee!);
                },
                items: backupEmployeesProvider.backupEmployees
                    .map<DropdownMenuItem<Employee>>((Employee employee) {
                  return DropdownMenuItem<Employee>(
                    value: employee,
                    child: Text(
                      employee.fullName,
                      style: customTextStyle(),
                    ),
                  );
                }).toList(),
              ),
            );
          }
        }));
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

  TextStyle customTextStyle() {
    return const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Color(0xff1C577D),
      overflow: TextOverflow.fade,
    );
  }

  Future<void> setBackupEmployee(Employee employee) async {
    Provider.of<ApplyForLeaveDataProvider>(
      context,
      listen: false,
    ).setActingArrangement(employee);
  }
}
