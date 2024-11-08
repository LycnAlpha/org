import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:org_connect_pt/screens/employee_list_screen/employee_list_provider.dart';
import 'package:org_connect_pt/screens/employee_list_screen/employee_list_screen_widgets/employee_list_card.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';
import 'package:provider/provider.dart';

class EmployeeList extends StatefulWidget {
  final refresh;
  const EmployeeList({
    super.key,
    this.refresh,
  });

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  final TextEditingController _search = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _search.addListener(() {
      _searchEmployees();
    });

    // _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.95) {
      Provider.of<EmployeeListProvider>(
        context,
        listen: false,
      ).getMoreEmployees(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            'Employees',
            style: TextStyle(
                color: Color(BasicColors.secondary),
                fontWeight: FontWeight.bold),
          ),
        ),
        searchBar(),
        Expanded(
          child: Consumer<EmployeeListProvider>(
              builder: (context, employeeListProvider, child) {
            if (employeeListProvider.isLoading) {
              return const Center(
                child: SpinKitCircle(
                  color: Color(BasicColors.primary),
                ),
              );
            } else if (employeeListProvider.errorOccured &&
                employeeListProvider.filteredList.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    employeeListProvider.message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.red,
                        fontWeight: FontWeight.w400),
                  ),
                  IconButton(
                      onPressed: widget.refresh,
                      icon: const Icon(
                        Icons.refresh,
                        color: Colors.red,
                        size: 30,
                      ))
                ],
              );
            } else if (employeeListProvider.filteredList.isEmpty &&
                employeeListProvider.isfiltered) {
              return const Center(
                child: Text(
                  'No result available',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.red,
                      fontWeight: FontWeight.w400),
                ),
              );
            } else {
              return RefreshIndicator(
                onRefresh: widget.refresh,
                child: ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(5.0),
                    itemCount: employeeListProvider.hasMorePages
                        ? employeeListProvider.filteredList.length + 1
                        : employeeListProvider.filteredList.length,
                    itemBuilder: (context, index) {
                      if (index == employeeListProvider.filteredList.length) {
                        if (employeeListProvider.errorOccured) {
                          return Text(
                            'List loading error: ${employeeListProvider.message}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.bold),
                          );
                        } else {
                          return GestureDetector(
                            onTap: () {
                              employeeListProvider.getMoreEmployees(context);
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
                        return EmployeeListCard(
                            employee: employeeListProvider.filteredList[index]);
                      }
                    }),
              );
            }
          }),
        ),
      ],
    );
  }

  _searchEmployees() {
    Provider.of<EmployeeListProvider>(
      context,
      listen: false,
    ).setKeyWord(_search.text.trim(), context);
  }

  Widget searchBar() {
    return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: const Color(BasicColors.primary)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              color: Color(BasicColors.tertiary),
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.search,
                    color: Color(BasicColors.secondary),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _search,
                      style:
                          const TextStyle(color: Color(BasicColors.secondary)),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        fillColor: Color(BasicColors.tertiary),
                        filled: true,
                        hintText: 'Search',
                        hintStyle:
                            TextStyle(color: Color(BasicColors.secondary)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
