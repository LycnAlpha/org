import 'package:flutter/cupertino.dart';
import 'package:org_connect_pt/utils/constants.dart';

class BottomNavigationProvider extends ChangeNotifier {
  int selectedScreen = Constants.dashboardScreen;

  void setSelectedScreen(int index) {
    selectedScreen = index;
    notifyListeners();
  }
}
