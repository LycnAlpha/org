import 'package:flutter/material.dart';
import 'package:org_connect_pt/common/toasts.dart';
import 'package:org_connect_pt/helpers/api_validation_helper.dart';
import 'package:org_connect_pt/helpers/shared_preference_helper.dart';
import 'package:org_connect_pt/models/api_response.dart';
import 'package:org_connect_pt/models/leave.dart';
import 'package:org_connect_pt/models/leave_type.dart';
import 'package:org_connect_pt/models/pagination.dart';
import 'package:org_connect_pt/screens/login_screen/login_screen.dart';
import 'package:org_connect_pt/services/leave_services.dart';
import 'package:org_connect_pt/utils/constants.dart';
import 'package:table_calendar/table_calendar.dart';

class EmployeeLeaveProvider extends ChangeNotifier {
  bool isLoading = true;
  bool errorOccured = false;
  bool isEmptyList = false;
  String message = '';

  String? keyword;
  bool isFiltered = false;

  int selectedLeavestatus = 0;

  bool hasMorePages = false;
  Pagination? paginationDetails;

  List<Leave> employeeLeaves = [];
  List<Leave> filteredList = [];

  LeaveType? leaveTypeFilter;
  DateTime? fromDateFilter;
  DateTime? toDateFilter;

  void setSelectedFromDate(DateTime? date, BuildContext context) {
    fromDateFilter = date;
    filter(context);
  }

  void setSelectedToDate(DateTime? date, BuildContext context) {
    toDateFilter = date;
    filter(context);
  }

  void setSelectedLeaveType(LeaveType? leaveType, BuildContext context) {
    leaveTypeFilter = leaveType;
    filter(context);
  }

  void setSelectedLeaveStatus(int status, BuildContext context) {
    selectedLeavestatus = status;
    filter(context);
  }

  void setKeyWord(String key, BuildContext context) {
    keyword = key.replaceAll(' ', '');
    filter(context);
  }

  void filter(BuildContext context) {
    filteredList = employeeLeaves;

    filterBystatus(context);
    if (filteredList.length < 10 && hasMorePages) {
      getMoreLeaves(context);
    }
  }

  void filterBystatus(BuildContext context) {
    List<Leave> temp = [];

    if (selectedLeavestatus != 0) {
      for (Leave leave in filteredList) {
        if (leave.statusId == selectedLeavestatus) {
          temp.add(leave);
        }
      }

      filteredList = temp;
    }

    filterByLeaveType();
  }

  void filterByLeaveType() {
    if (leaveTypeFilter != null && leaveTypeFilter!.typeId != 0) {
      List<Leave> temp = [];

      for (Leave leave in filteredList) {
        if (leave.leaveTypeId == leaveTypeFilter!.typeId) {
          temp.add(leave);
        }
      }

      filteredList = temp;
      isFiltered = true;
    }

    filterByDate();
  }

  void filterByName() {
    if (keyword != null && keyword!.isNotEmpty) {
      List<Leave> temp = [];

      for (Leave leave in filteredList) {
        if (leave.employeeName.toLowerCase().contains(keyword!.toLowerCase())) {
          temp.add(leave);
        }
      }

      filteredList = temp;
    }

    notifyListeners();
  }

  void filterByDate() {
    List<Leave> temp = [];
    if (fromDateFilter != null && toDateFilter != null) {
      for (Leave leave in filteredList) {
        if ((DateTime.parse(leave.startDate).isAfter(fromDateFilter!) &&
                DateTime.parse(leave.endDate).isBefore(toDateFilter!)) ||
            isSameDay(DateTime.parse(leave.startDate), fromDateFilter) ||
            isSameDay(DateTime.parse(leave.endDate), toDateFilter)) {
          temp.add(leave);
        }
      }
      filteredList = temp;
      isFiltered = true;
    } else if (fromDateFilter != null && toDateFilter == null) {
      for (Leave leave in filteredList) {
        if (DateTime.parse(leave.startDate).isAfter(fromDateFilter!) ||
            isSameDay(DateTime.parse(leave.startDate), fromDateFilter)) {
          temp.add(leave);
        }
      }
      filteredList = temp;
      isFiltered = true;
    } else if (toDateFilter != null) {
      for (Leave leave in filteredList) {
        if (DateTime.parse(leave.endDate).isBefore(toDateFilter!) ||
            isSameDay(DateTime.parse(leave.endDate), toDateFilter)) {
          temp.add(leave);
        }
      }
      filteredList = temp;
      isFiltered = true;
    }

    filterByName();
  }

  void getEmployeeLeaves(BuildContext context) {
    isLoading = true;
    errorOccured = false;
    isEmptyList = false;
    employeeLeaves = [];
    filteredList = [];
    hasMorePages = false;
    isFiltered = false;
    notifyListeners();

    _apiCall(context, 1);
  }

  void getMoreLeaves(BuildContext context) {
    if (hasMorePages) {
      _apiCall(context, paginationDetails!.currentPage + 1);
    }
  }

  Future<void> _apiCall(BuildContext context, int page) async {
    String authToken = await SharedPreferenceHelper.getAuthToken();

    await LeaveServices.getAllEmployeeLeaves(authToken, page, 1).then((result) {
      try {
        if (result != null) {
          if (result is String) {
            _onFailed(result);
          } else if (result is int) {
            _sessionExpired(context);
          } else {
            //success
            _onSuccess(result, context);
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

  _onSuccess(APIResponse result, BuildContext context) {
    try {
      final data = result.data['result'][0];
      List<Leave> employeeLeaveList =
          data.map((leave) => Leave.fromJson(leave)).toList().cast<Leave>();

      employeeLeaves.addAll(employeeLeaveList);
      paginationDetails = Pagination.fromJson(result.data['paginationInfo']);
      if (employeeLeaves.isNotEmpty) {
        isLoading = false;
        errorOccured = false;
        if (paginationDetails != null &&
            paginationDetails!.totalPages != paginationDetails!.currentPage) {
          hasMorePages = true;
        } else {
          hasMorePages = false;
        }
        filter(context);
      } else {
        isEmptyList = true;
        _onFailed('No records available');
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

  clearFilters(BuildContext context) {
    leaveTypeFilter = null;
    fromDateFilter = null;
    toDateFilter = null;
    isFiltered = false;
    notifyListeners();
    filter(context);
  }
}
