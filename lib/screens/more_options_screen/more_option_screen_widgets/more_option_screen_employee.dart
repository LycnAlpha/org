import 'package:flutter/material.dart';
import 'package:org_connect_pt/screens/personal_leave_screen/personal_leave_screen.dart';
import 'package:org_connect_pt/screens/more_options_screen/more_option_screen_widgets/list_item.dart';
import 'package:org_connect_pt/screens/more_options_screen/more_option_screen_widgets/tile_item.dart';
import 'package:org_connect_pt/screens/more_options_screen/more_option_screen_widgets/toggle_button.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';

class MoreOptionScreenEmployee extends StatelessWidget {
  final bool isList;
  final onToggleButtonClicked;

  const MoreOptionScreenEmployee({
    super.key,
    required this.isList,
    this.onToggleButtonClicked,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(BasicColors.tertiary),
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            ToggleButton(
              isList: isList,
              onToggleButtonClicked: onToggleButtonClicked,
            ),
            generalTab(context),
            insightsTab(context),
          ],
        ),
      ),
    );
  }

  Widget generalTab(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              'General',
              style: TextStyle(
                  color: Color(BasicColors.primary),
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
          ),
          isList ? generalList(context) : generalTiles(context),
        ],
      ),
    );
  }

  Widget generalList(BuildContext context) {
    return Column(
      children: [
        const ListItem(
          image: 'assets/icons/icon_attendance.png',
          label: 'Attendance',
        ),
        ListItem(
          image: 'assets/icons/icon_leave.png',
          label: 'Leave',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PersonalLeaveScreen()),
            );
          },
        ),
        const ListItem(
          image: 'assets/icons/icon_incidents.png',
          label: 'Incidents',
        ),
        const ListItem(
          image: 'assets/icons/icon_pay_slips.png',
          label: 'Pay Slips',
        ),
        const ListItem(
          image: 'assets/icons/icon_loans.png',
          label: 'Loans',
        ),
        const ListItem(
          image: 'assets/icons/icon_performance.png',
          label: 'Performance',
        ),
      ],
    );
  }

  Widget generalTiles(BuildContext context) {
    return (MediaQuery.of(context).size.width / 130).floor() == 3
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  const TileItem(
                    image: 'assets/icons/icon_attendance.png',
                    label: 'Attendance',
                  ),
                  TileItem(
                    image: 'assets/icons/icon_leave.png',
                    label: 'Leave',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PersonalLeaveScreen()),
                      );
                    },
                  ),
                  const TileItem(
                    image: 'assets/icons/icon_incidents.png',
                    label: 'Incidents',
                  ),
                ],
              ),
              const Row(
                children: [
                  TileItem(
                    image: 'assets/icons/icon_pay_slips.png',
                    label: 'Pay Slips',
                  ),
                  TileItem(
                    image: 'assets/icons/icon_loans.png',
                    label: 'Loans',
                  ),
                  TileItem(
                    image: 'assets/icons/icon_performance.png',
                    label: 'Performance',
                  ),
                ],
              )
            ],
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const TileItem(
                    image: 'assets/icons/icon_attendance.png',
                    label: 'Attendance',
                  ),
                  TileItem(
                    image: 'assets/icons/icon_leave.png',
                    label: 'Leave',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PersonalLeaveScreen()),
                      );
                    },
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TileItem(
                    image: 'assets/icons/icon_incidents.png',
                    label: 'Incidents',
                  ),
                  TileItem(
                    image: 'assets/icons/icon_pay_slips.png',
                    label: 'Pay Slips',
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TileItem(
                    image: 'assets/icons/icon_loans.png',
                    label: 'Loans',
                  ),
                  TileItem(
                    image: 'assets/icons/icon_performance.png',
                    label: 'Performance',
                  ),
                ],
              )
            ],
          );
  }

  Widget insightsTab(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              'Insights',
              style: TextStyle(
                  color: Color(BasicColors.primary),
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
          ),
          isList ? insightsList() : insightsTiles(context),
        ],
      ),
    );
  }

  Widget insightsList() {
    return const Column(
      children: [
        ListItem(
          image: 'assets/icons/icon_training.png',
          label: 'Training',
        ),
        ListItem(
          image: 'assets/icons/icon_inquiries.png',
          label: 'Inquiries',
        ),
      ],
    );
  }

  Widget insightsTiles(BuildContext context) {
    return Column(
      children: [
        (MediaQuery.of(context).size.width / 130).floor() == 3
            ? const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TileItem(
                    image: 'assets/icons/icon_training.png',
                    label: 'Training',
                  ),
                  TileItem(
                    image: 'assets/icons/icon_inquiries.png',
                    label: 'Inquiries',
                  ),
                ],
              )
            : const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TileItem(
                    image: 'assets/icons/icon_training.png',
                    label: 'Training',
                  ),
                  TileItem(
                    image: 'assets/icons/icon_inquiries.png',
                    label: 'Inquiries',
                  ),
                ],
              )
      ],
    );
  }
}
