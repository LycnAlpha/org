import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:org_connect_pt/models/employee.dart';
import 'package:org_connect_pt/models/holiday.dart';
import 'package:org_connect_pt/models/leave_balance.dart';
import 'package:org_connect_pt/utils/constants.dart';
import 'package:table_calendar/table_calendar.dart';

class ApplyForLeaveDataProvider extends ChangeNotifier {
  LeaveBalance? selectedLeaveType;
  bool isShortLeave = false;

  DateTime? selectedFromDate, selectedToDate;
  String selectedFromSegment = Constants.segmentMorning;
  String selectedToSegment = Constants.segmentEvening;

  double calculatedLeaveCount = 0.0;
  bool errorCalculatingDates = false; //when user select to as a previous date

  bool isSelectedReasonOther = false;
  String reason = '';

  bool fromDateSelected = false;

  Employee? selectedActingArrangement;
  XFile? medicalRecordImage;

  String enteredContactNumber = '';

  List<Holiday> holidays = [];

  void setHolidayList(List<Holiday> holidayList) {
    holidays = holidayList;
    notifyListeners();
  }

  void setSelectedLeaveType(LeaveBalance selectedLeaveType) {
    this.selectedLeaveType = selectedLeaveType;

    calculateLeaveDays();
  }

  /* void setMedicalRecordImage(XFile image) {
    medicalRecordImage = image;
    notifyListeners();
  }

  void removeMedicalRecordImage() {
    medicalRecordImage = null;
    notifyListeners();
  }*/

  void setFromDate(DateTime selectedFromDate) {
    this.selectedFromDate = selectedFromDate;

    calculateLeaveDays();
  }

  void setFromDateSelected(bool value) {
    fromDateSelected = value;
    notifyListeners();
  }

  void setFromSegment(String selectedFromSegment) {
    this.selectedFromSegment = selectedFromSegment;

    calculateLeaveDays();
  }

  void setToDate(DateTime selectedToDate) {
    this.selectedToDate = selectedToDate;

    calculateLeaveDays();
  }

  void setToSegment(String selectedToSegment) {
    this.selectedToSegment = selectedToSegment;
    calculateLeaveDays();
  }

  void setReason(String customReason) {
    reason = customReason;
    notifyListeners();
  }

  void setActingArrangement(Employee selectedActingArrangement) {
    this.selectedActingArrangement = selectedActingArrangement;
    notifyListeners();
  }

  void setContactNumber(String enteredContactNumber) {
    this.enteredContactNumber = enteredContactNumber;
    notifyListeners();
  }

  void calculateLeaveDays() {
    if (isShortLeave) {
      selectedToDate = selectedFromDate;
      selectedToSegment = Constants.segmentEvening;
      calculatedLeaveCount = 1.0;
    } else if (selectedFromDate != null && selectedToDate != null) {
      double numberOfDays = 0.0;

      if (selectedFromDate == selectedToDate) {
        if (selectedFromSegment == selectedToSegment) {
          numberOfDays = 0.5;
        } else if (selectedFromSegment == Constants.segmentEvening) {
          selectedToSegment == Constants.segmentEvening;
          numberOfDays = 0.5;
        } else {
          numberOfDays = 1.0;
        }
      } else if (selectedToDate ==
          selectedFromDate!.add(const Duration(days: 1))) {
        if (selectedFromSegment == selectedToSegment) {
          numberOfDays = 1.5;
        } else if (selectedFromSegment == Constants.segmentEvening &&
            selectedToSegment == Constants.segmentMorning) {
          numberOfDays = 1.0;
        } else {
          numberOfDays = 2.0;
        }
      } else {
        DateTime currentDate = selectedFromDate!;

        do {
          if (_isWorkday(currentDate)) {
            numberOfDays++;
          }
          currentDate = currentDate.add(const Duration(days: 1));
        } while (currentDate.isBefore(selectedToDate!) ||
            isSameDay(currentDate, selectedToDate));

        if (selectedFromSegment == selectedToSegment) {
          numberOfDays = numberOfDays - 0.5;
        } else if (selectedFromSegment == Constants.segmentEvening &&
            selectedToSegment == Constants.segmentMorning) {
          numberOfDays = numberOfDays - 1.0;
        }
      }

      calculatedLeaveCount = numberOfDays;

      if (selectedFromDate!.isAfter(selectedToDate!)) {
        calculatedLeaveCount = 0.0;
        errorCalculatingDates = true;
      } else {
        errorCalculatingDates = false;
      }
    } else {
      calculatedLeaveCount = 0.0;
    }

    notifyListeners();
  }

  bool _isWorkday(DateTime date) {
    if (holidays.isNotEmpty) {
      for (Holiday holiday in holidays) {
        DateTime fromDate = DateTime.parse(holiday.fromDate);
        DateTime toDate = DateTime.parse(holiday.toDate);

        if ((date.isAfter(fromDate) && date.isBefore(toDate)) ||
            isSameDay(date, fromDate) ||
            isSameDay(date, toDate)) {
          return false;
        }
      }
    }

    return !(date.weekday == 6 || date.weekday == 7);
  }
}
