import 'package:flutter/material.dart';
import 'package:org_connect_pt/screens/employee_list_screen/employee_list_provider.dart';
import 'package:org_connect_pt/screens/employee_list_screen/employee_list_screen_content.dart';
import 'package:provider/provider.dart';

class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => EmployeeListProvider(),
        ),
      ],
      child: const EmployeeListScreenContent(),
    );
  }
}
