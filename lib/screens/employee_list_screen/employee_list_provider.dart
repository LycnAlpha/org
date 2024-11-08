import 'package:flutter/material.dart';
import 'package:org_connect_pt/common/toasts.dart';
import 'package:org_connect_pt/helpers/api_validation_helper.dart';
import 'package:org_connect_pt/helpers/shared_preference_helper.dart';
import 'package:org_connect_pt/models/api_response.dart';
import 'package:org_connect_pt/models/employee.dart';
import 'package:org_connect_pt/models/pagination.dart';
import 'package:org_connect_pt/screens/login_screen/login_screen.dart';
import 'package:org_connect_pt/services/employee_services.dart';
import 'package:org_connect_pt/utils/constants.dart';

class EmployeeListProvider extends ChangeNotifier {
  bool isLoading = true;
  bool errorOccured = false;
  bool isEmptyList = false;
  bool hasMorePages = false;
  String message = '';
  Pagination? paginationDetails;

  List<Employee> employees = [];
  List<Employee> filteredList = [];

  String? keyword;
  bool isfiltered = false;

  int pageNumber = 1;
  int count = 0;

  void setKeyWord(String key, BuildContext context) {
    keyword = key;
    isfiltered = false;
    getEmployees(context);
  }

  void getEmployees(BuildContext context) {
    isLoading = true;
    errorOccured = false;
    isEmptyList = false;
    employees = [];
    filteredList = [];
    isfiltered = false;
    hasMorePages = false;
    notifyListeners();

    _apiCall(context, 1);
  }

  void getMoreEmployees(BuildContext context) {
    if (hasMorePages) {
      _apiCall(context, paginationDetails!.currentPage + 1);
    }
  }

  Future<void> _apiCall(BuildContext context, int page) async {
    String authToken = await SharedPreferenceHelper.getAuthToken();

    await EmployeeServices.getAllEmployeesList(authToken, page).then((result) {
      try {
        if (result != null) {
          if (result is String) {
            _onFailed(result);
          } else if (result is int) {
            _sessionExpired(context);
          } else {
            //success
            _onSuccess(result);
          }
        } else {
          _onFailed(getErrorMessage(Constants.nullException));
        }
      } catch (e) {
        _onFailed(getErrorMessage(Constants.unknownException));
      }
    }, onError: (errorCode) {
      _onFailed(getErrorMessage(errorCode));
    });
  }

  filter(String keyWord) {
    List<Employee> temp = [];
    String empNameWithSpace = '';
    String empNameWithoutSpace = '';
    for (Employee employee in employees) {
      empNameWithSpace = '${employee.firstName} ${employee.lastName}';
      empNameWithoutSpace = '${employee.firstName}${employee.lastName}';
      if (empNameWithSpace.toLowerCase().contains(keyWord.toLowerCase()) ||
          empNameWithoutSpace.toLowerCase().contains(keyWord.toLowerCase())) {
        temp.add(employee);
      }
    }
    filteredList = temp;
    isfiltered = true;
    notifyListeners();
  }

  _onSuccess(APIResponse result) {
    try {
      List<Employee> employeeList = result.data['result']
          .map((employee) => Employee.fromJson(employee))
          .toList()
          .cast<Employee>();

      employees.addAll(employeeList);

      paginationDetails = Pagination.fromJson(result.data['paginationInfo']);

      if (employees.isNotEmpty) {
        isLoading = false;
        errorOccured = false;
        if (keyword != null && !isfiltered) {
          filter(keyword!);
        }
        if (filteredList.isEmpty && !isfiltered) {
          filteredList = employees;
        }
        if (paginationDetails != null) {
          if (paginationDetails!.totalPages != paginationDetails!.currentPage) {
            hasMorePages = true;
          } else {
            hasMorePages = false;
          }

          count = paginationDetails!.totalResults;
        }

        notifyListeners();
      } else {
        isEmptyList = true;
        _onFailed('No records available');
        notifyListeners();
      }
    } catch (e) {
      _onFailed(getErrorMessage(Constants.unknownException));
    }
  }

  _onFailed(String message) {
    isLoading = false;

    this.message = message;
    errorOccured = true;

    notifyListeners();
  }

  _sessionExpired(BuildContext context) {
    _onFailed('Session Expired');
    Toasts.showErrorToast('Session Expired');
    openLoginScreen(context);
  }

  openLoginScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }
}
