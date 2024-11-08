import 'package:flutter/material.dart';
import 'package:org_connect_pt/models/employee.dart';
import 'package:org_connect_pt/screens/employee_list_screen/employee_list_screen_widgets/call_employee_confirmation_dialog.dart';
import 'package:org_connect_pt/screens/employee_list_screen/employee_list_screen_widgets/email_employee_confirmation_dialog.dart';
import 'package:org_connect_pt/screens/employee_list_screen/employee_list_screen_widgets/employee_details_page.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';

class EmployeeListCard extends StatelessWidget {
  final Employee employee;
  const EmployeeListCard({
    super.key,
    required this.employee,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Dismissible(
        key: Key(employee.id.toString()),
        background: dismissibleBackgroundEmail(),
        secondaryBackground: dismissibleBackgroundCall(),
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
            showDialog(
              context: context,
              builder: (ctx) =>
                  CallEmployeeConfirmationDialog(employee: employee),
            );
          } else if (direction == DismissDirection.startToEnd) {
            showDialog(
              context: context,
              builder: (ctx) =>
                  EmailEmployeeConfirmationDialog(employee: employee),
            );
          }
        },
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EmployeeDetailsPage(
                        employee: employee,
                      )),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: const Color(BasicColors.tertiary),
              borderRadius: BorderRadius.circular(20.0),
              //border: Border.all(color: Colors.grey.shade300),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0.5,
                  blurRadius: 7.0,
                  offset: const Offset(0, 3.0),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 75.0,
                  width: 75.0,
                  padding: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: const Color(BasicColors.secondary)),
                      color:
                          const Color(BasicColors.secondary).withOpacity(0.5)),
                  child: employee.profileImage != null
                      ? ClipOval(
                          child: Image.network(
                            employee.profileImage!,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              final totalBytes =
                                  loadingProgress?.expectedTotalBytes;
                              final bytesLoaded =
                                  loadingProgress?.cumulativeBytesLoaded;
                              if (totalBytes != null && bytesLoaded != null) {
                                return Center(
                                  child: Text(
                                    '${employee.firstName[0].toUpperCase()}${employee.lastName[0].toUpperCase()}',
                                    style: const TextStyle(
                                        color: Color(BasicColors.primary),
                                        fontSize: 30.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                );
                              } else {
                                return child;
                              }
                            },
                            fit: BoxFit.cover,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return Center(
                                child: Text(
                                  '${employee.firstName[0].toUpperCase()}${employee.lastName[0].toUpperCase()}',
                                  style: const TextStyle(
                                      color: Color(BasicColors.primary),
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              );
                            },
                          ),
                        )
                      : Center(
                          child: Text(
                            '${employee.firstName[0].toUpperCase()}${employee.lastName[0].toUpperCase()}',
                            style: const TextStyle(
                                color: Color(BasicColors.primary),
                                fontSize: 30.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${employee.firstName} ${employee.lastName}',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Color(BasicColors.primary),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        employee.designationName,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: Color(BasicColors.primary),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${employee.departmentName} Team',
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: Color(BasicColors.primary),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dismissibleBackgroundCall() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: const Color(BasicColors.secondary).withOpacity(0.75),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Call...',
            style:
                TextStyle(color: Color(BasicColors.tertiary), fontSize: 25.0),
          ),
          SizedBox(
            width: 20.0,
          ),
          CircleAvatar(
            backgroundColor: Color(BasicColors.tertiary),
            radius: 35.0,
            child: Center(
              child: Icon(
                Icons.call,
                color: Color(BasicColors.secondary),
                size: 35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dismissibleBackgroundEmail() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: const Color(BasicColors.primary).withOpacity(0.75),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Color(BasicColors.tertiary),
            radius: 35.0,
            child: Center(
              child: Icon(
                Icons.email,
                color: Color(BasicColors.primary),
                size: 35,
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Text(
            'Email...',
            style:
                TextStyle(color: Color(BasicColors.tertiary), fontSize: 25.0),
          ),
        ],
      ),
    );
  }
}
