import 'package:flutter/material.dart';
import 'package:org_connect_pt/common/common_widgets/simple_action_button.dart';
import 'package:org_connect_pt/models/employee.dart';
import 'package:org_connect_pt/screens/employee_list_screen/employee_list_screen_widgets/call_employee_confirmation_dialog.dart';
import 'package:org_connect_pt/screens/employee_list_screen/employee_list_screen_widgets/email_employee_confirmation_dialog.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';

class EmployeeDetailsPage extends StatelessWidget {
  final Employee employee;
  const EmployeeDetailsPage({
    super.key,
    required this.employee,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(BasicColors.primary),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Color(BasicColors.tertiary),
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Employee Details',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            color: Color(BasicColors.tertiary),
          ),
        ),
      ),
      body: SafeArea(
          child: Container(
              //  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              color: Color(BasicColors.tertiary),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height / 2.7,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(40.0),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.elliptical(200, 120),
                              bottomRight: Radius.elliptical(200, 120)),
                          color: Color(BasicColors.primary),
                        ),
                        child: Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width * 0.58,
                            padding: const EdgeInsets.all(8.0),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(BasicColors.secondary)),
                            child: employee.profileImage != null
                                ? ClipOval(
                                    child: Image.network(
                                      employee.profileImage!,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        final totalBytes =
                                            loadingProgress?.expectedTotalBytes;
                                        final bytesLoaded = loadingProgress
                                            ?.cumulativeBytesLoaded;
                                        if (totalBytes != null &&
                                            bytesLoaded != null) {
                                          return Center(
                                            child: Image.asset(
                                              'assets/icons/icon_user.png',
                                              color:
                                                  Color(BasicColors.tertiary),
                                            ),
                                          );
                                        } else {
                                          return child;
                                        }
                                      },
                                      fit: BoxFit.cover,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return Center(
                                          child: Image.asset(
                                            'assets/icons/icon_user.png',
                                            color: Color(BasicColors.tertiary),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : ClipOval(
                                    child: Center(
                                      child: Image.asset(
                                        'assets/icons/icon_user.png',
                                        color: Color(BasicColors.tertiary),
                                      ),
                                    ),
                                  ),
                            /*  Image.asset(
                        'assets/icons/icon_user.png',
                        color: Color(BasicColors.tertiary),
                      ),*/
                          ),
                        )),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                              color: const Color(BasicColors.secondary),
                              width: 2.0),
                          color: Color(BasicColors.tertiary),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${employee.firstName} ${employee.lastName}',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.w900,
                                color: const Color(BasicColors.primary),
                                height: 1.0,
                                letterSpacing: 2.0,
                                // wordSpacing: 0.20,
                                shadows: textShadows(),
                              ),
                            ),
                            Text(employee.designationName,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(BasicColors.primary),
                                  shadows: textShadows(),
                                )),
                            const SizedBox(
                              height: 10.0,
                            ),
                            profileAttribute(
                                'Team', '${employee.departmentName} Team'),
                            profileAttribute('Email', employee.email),
                            profileAttribute(
                                'Contact Number', employee.mobileNumber),
                            profileAttribute('Address',
                                '${employee.addressLine1}, ${employee.addressLine2}, ${employee.addressLine3},'),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: SimpleActionButton(
                              displayText: 'Email',
                              color: const Color(BasicColors.primary),
                              icon: Icons.email,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) =>
                                      EmailEmployeeConfirmationDialog(
                                          employee: employee),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            child: SimpleActionButton(
                              displayText: 'Call',
                              color: const Color(BasicColors.secondary),
                              icon: Icons.call,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (ctx) =>
                                      CallEmployeeConfirmationDialog(
                                          employee: employee),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ))),
    );
  }

  List<Shadow> textShadows() {
    return <Shadow>[
      const Shadow(
        offset: Offset(2.0, 2.0),
        color: Color(BasicColors.tertiary),
      ),
      const Shadow(
        offset: Offset(2.0, -2.0),
        color: Color(BasicColors.tertiary),
      ),
      const Shadow(
        offset: Offset(-2.0, 2.0),
        color: Color(BasicColors.tertiary),
      ),
      const Shadow(
        offset: Offset(-2.0, -2.0),
        color: Color(BasicColors.tertiary),
      ),
    ];
  }

  Widget profileAttribute(String label, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(BasicColors.primary)),
              ),
              const SizedBox(
                width: 20.0,
              ),
              const Expanded(
                child: Divider(
                  color: Color(BasicColors.secondary),
                ),
              ),
            ],
          ),
          Text(
            description,
            style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
                color: Color(BasicColors.primary)),
          ),
        ],
      ),
    );
  }
}
