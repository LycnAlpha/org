import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen_providers/apply_for_leave_data_provider.dart';
import 'package:org_connect_pt/screens/apply_for_leave/apply_for_leave_screen_widgets/custom_background.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';
import 'package:provider/provider.dart';

class ContactNumberTextField extends StatefulWidget {
  const ContactNumberTextField({super.key});

  @override
  State<ContactNumberTextField> createState() => _ContactNumberTextFieldState();
}

class _ContactNumberTextFieldState extends State<ContactNumberTextField> {
  Country? selectedCountry;
  final String fieldName = 'Contact Number while on Leave*';

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _setDefaultCountry();
  }

  void _setDefaultCountry() {
    // Get device's locale country code

    Locale myLocale = Localizations.localeOf(context);
    final String deviceLocale = myLocale.countryCode ?? 'US';
    setState(() {
      selectedCountry = Country.tryParse(deviceLocale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: CustomBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 15.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  showCountryPicker(
                    context: context,
                    showPhoneCode: true,
                    favorite: <String>['LK'],
                    onSelect: (Country country) {
                      setState(() {
                        selectedCountry = country;
                      });
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border:
                          Border.all(color: const Color(BasicColors.primary))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        selectedCountry != null
                            ? '+${selectedCountry!.phoneCode}'
                            : '+94',
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff1C577D),
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_drop_down,
                        color: Color(BasicColors.primary),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: TextFormField(
                  maxLength: 15,
                  style: customTextStyle(),
                  decoration: InputDecoration(
                    hintText: fieldName,
                    counterText: "",
                    border: InputBorder.none,
                    hintStyle: customTextStyle(),
                  ),
                  onChanged: (value) {
                    _setContactNumber(
                        context, '+${selectedCountry!.phoneCode}$value');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _setContactNumber(BuildContext context, contactNumber) async {
    Provider.of<ApplyForLeaveDataProvider>(
      context,
      listen: false,
    ).setContactNumber(contactNumber.toString().trim());
  }

  TextStyle customTextStyle() {
    return const TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Color(0xff1C577D),
      overflow: TextOverflow.fade,
    );
  }
}
