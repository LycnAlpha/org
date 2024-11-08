import 'package:flutter/material.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';

class MyProfileScreenInterface extends StatelessWidget {
  const MyProfileScreenInterface({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(BasicColors.tertiary),
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            profileHeader(),
            generalTab(),
            insightsTab(),
          ],
        ),
      ),
    );
  }

  Widget profileHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 180,
            width: 180,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
            ),
            child: Stack(
              children: [
                Center(
                  child: Container(
                      height: 150,
                      width: 150,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(BasicColors.secondary)),
                      child: ClipOval(
                        child: Image.network(
                          'https://img.freepik.com/free-photo/portrait-handsome-young-european-man-looks-directly-camera-with-serious-expression-feels-self-confident-wears-round-transparent-glasses-casual-sweater-isolated-beige-background_273609-56727.jpg?t=st=1723718144~exp=1723721744~hmac=2150d51be9d16f0fdc8f4e7d1156a31772360c4aaa14210cd58bac51216558ca&w=1380',
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            final totalBytes =
                                loadingProgress?.expectedTotalBytes;
                            final bytesLoaded =
                                loadingProgress?.cumulativeBytesLoaded;
                            if (totalBytes != null && bytesLoaded != null) {
                              return Center(
                                child: Image.asset(
                                  'assets/icons/icon_user.png',
                                  color: Color(BasicColors.tertiary),
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
                              child: Image.asset(
                                'assets/icons/icon_user.png',
                                color: Color(BasicColors.tertiary),
                              ),
                            );
                          },
                        ),
                      )),
                ),
                Positioned(
                  bottom: 30,
                  right: 10,
                  child: GestureDetector(
                    child: Container(
                      height: 40,
                      width: 40,
                      padding: const EdgeInsets.all(3.0),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(BasicColors.tertiary),
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xff4168E7),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          color: Color(BasicColors.tertiary),
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const Text(
            'Shashith Dimal',
            style: TextStyle(
                fontSize: 25.0,
                color: Color(BasicColors.primary),
                fontWeight: FontWeight.w900),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: const Color(0xff4168E7).withOpacity(0.15),
            ),
            child: const Text(
              'dperera@icptechno.com',
              style: TextStyle(
                color: Color(0xff4168E7),
                fontSize: 12.0,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget generalTab() {
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
          itemButton(
            Icons.account_circle_outlined,
            'Your Profile',
          ),
          itemButton(
            Icons.history,
            'Leave History',
          ),
        ],
      ),
    );
  }

  Widget insightsTab() {
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
          itemButton(
            Icons.groups_2_outlined,
            'Community',
          ),
          itemButton(
            Icons.notifications_active_outlined,
            'Notifications',
          ),
          itemButton(
            Icons.settings_outlined,
            'Settings',
          ),
          itemButton(
            Icons.logout,
            'Logout',
          ),
        ],
      ),
    );
  }

  Widget itemButton(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, left: 2.0, right: 2.0),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Color(BasicColors.tertiary),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(0, 1),
              blurRadius: 1,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: const Color(BasicColors.primary),
              size: 30,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Text(
              label,
              style: const TextStyle(
                  color: Color(BasicColors.primary),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600),
            ),
            const Expanded(child: SizedBox()),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(BasicColors.primary),
            )
          ],
        ),
      ),
    );
  }
}
