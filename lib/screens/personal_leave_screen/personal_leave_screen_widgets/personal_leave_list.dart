import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:org_connect_pt/screens/personal_leave_screen/personal_leave_screen_widgets/personal_leave_card.dart';
import 'package:org_connect_pt/screens/personal_leave_screen/personal_leave_provider.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';
import 'package:provider/provider.dart';

class PersonalLeaveList extends StatefulWidget {
  final retry;
  const PersonalLeaveList({
    super.key,
    this.retry,
  });

  @override
  State<PersonalLeaveList> createState() => _PersonalLeaveListState();
}

class _PersonalLeaveListState extends State<PersonalLeaveList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.95) {
      Provider.of<PersonalLeaveProvider>(
        context,
        listen: false,
      ).getMoreLeaves(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 5.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text(
                'My Leaves',
                style: TextStyle(
                    color: Color(BasicColors.primary),
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0),
              ),
            ),
            Expanded(child: Consumer<PersonalLeaveProvider>(
                builder: (context, personalLeaveProvider, child) {
              if (personalLeaveProvider.isLoading) {
                return const Center(
                  child: SpinKitThreeBounce(
                    color: Color(BasicColors.primary),
                  ),
                );
              } else if (personalLeaveProvider.errorOccured &&
                  personalLeaveProvider.personalLeaves.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      personalLeaveProvider.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.red,
                          fontWeight: FontWeight.w400),
                    ),
                    IconButton(
                        onPressed: widget.retry,
                        icon: const Icon(
                          Icons.refresh,
                          color: Colors.red,
                          size: 30,
                        ))
                  ],
                );
              } else {
                return RefreshIndicator(
                  onRefresh: widget.retry,
                  child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(5.0),
                      itemCount: personalLeaveProvider.hasMorePages
                          ? personalLeaveProvider.personalLeaves.length + 1
                          : personalLeaveProvider.personalLeaves.length,
                      itemBuilder: (context, index) {
                        if (index ==
                            personalLeaveProvider.personalLeaves.length) {
                          if (personalLeaveProvider.errorOccured) {
                            return Text(
                              'List loading error: ${personalLeaveProvider.message}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontWeight: FontWeight.bold),
                            );
                          } else {
                            return GestureDetector(
                              onTap: () {
                                personalLeaveProvider.getMoreLeaves(context);
                              },
                              child: const Text(
                                'Load More',
                                textAlign: TextAlign.center,
                              ),
                            );
                            /*return const SpinKitCircle(
                              color: Color(BasicColors.primary),
                            );*/
                          }
                        } else {
                          return PersonalLeaveCard(
                            leave: personalLeaveProvider.personalLeaves[index],
                          );
                        }
                      }),
                );
              }
            }))
          ],
        ),
      ),
    );
  }
}
