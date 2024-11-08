import 'package:flutter/material.dart';
import 'package:org_connect_pt/models/event.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final int index;
  const EventCard({
    super.key,
    required this.event,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
            decoration: BoxDecoration(
              //  border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10.0),
              color: index % 2 == 0
                  ? const Color(BasicColors.primary)
                  : const Color(BasicColors.secondary),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0.5,
                  blurRadius: 7.0,
                  offset: const Offset(0, 3.0),
                ),
              ],
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  const SizedBox(
                    width: 10.0,
                  ),
                  const VerticalDivider(
                    color: Colors.white38,
                    thickness: 3.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.alarm,
                              color: Color(BasicColors.tertiary),
                              size: 15,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              '16.00 pm - 19.00 pm',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                color: Color(BasicColors.tertiary),
                                overflow: TextOverflow.fade,
                              ),
                            )
                          ],
                        ),
                        Text(
                          event.employeeDetails != null
                              ? '${event.employeeFirstName} ${event.employeeLastName}'
                              : event.eventName ?? '',
                          style: customTextStyle(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Text(
                          'At Office, In the Evening',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400,
                            color: Color(BasicColors.tertiary),
                            overflow: TextOverflow.fade,
                          ),
                        )
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.more_vert,
                          color: Color(BasicColors.tertiary),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Visibility(
            visible: event.status != null && event.status!.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 20.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: const Color(BasicColors.tertiary)),
                child: Text(
                  event.status ?? '',
                  style: TextStyle(
                      fontSize: 12.0,
                      color: index % 2 == 0
                          ? const Color(BasicColors.primary)
                          : const Color(BasicColors.secondary),
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget image() {
    return Container(
      height: 50.0,
      width: 50.0,
      padding: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(BasicColors.secondary)),
          color: const Color(BasicColors.secondary).withOpacity(0.5)),
      child: event.employeeDetails != null
          ? event.employeeDetails!.profileImage != null
              ? ClipOval(
                  child: Image.network(
                    event.employeeDetails!.profileImage!,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      final totalBytes = loadingProgress?.expectedTotalBytes;
                      final bytesLoaded =
                          loadingProgress?.cumulativeBytesLoaded;
                      if (totalBytes != null && bytesLoaded != null) {
                        return Center(
                          child: Text(
                            '${event.employeeDetails!.firstName[0]}${event.employeeDetails!.lastName[0]}',
                            style: const TextStyle(
                                color: Color(BasicColors.primary),
                                fontSize: 25.0,
                                fontWeight: FontWeight.w500),
                          ),
                        );
                      } else {
                        return child;
                      }
                    },
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return Center(
                        child: Text(
                          '${event.employeeDetails!.firstName[0]}${event.employeeDetails!.lastName[0]}',
                          style: const TextStyle(
                              color: Color(BasicColors.primary),
                              fontSize: 25.0,
                              fontWeight: FontWeight.w500),
                        ),
                      );
                    },
                  ),
                )
              : Center(
                  child: Text(
                    '${event.employeeDetails!.firstName[0]}${event.employeeDetails!.lastName[0]}',
                    style: const TextStyle(
                        color: Color(BasicColors.primary),
                        fontSize: 25.0,
                        fontWeight: FontWeight.w500),
                  ),
                )
          : ClipOval(
              child: Image.asset('assets/icons/icon_holiday.png'),
            ),
    );
  }

  TextStyle customTextStyle() {
    return const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Color(BasicColors.tertiary),
      overflow: TextOverflow.fade,
    );
  }
}
