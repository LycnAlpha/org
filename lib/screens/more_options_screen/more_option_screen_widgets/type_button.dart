import 'package:flutter/material.dart';
import 'package:org_connect_pt/utils/basic_colors.dart';

class TypeButton extends StatelessWidget {
  final bool isPersonal;
  final onTypeChanged;
  const TypeButton({
    super.key,
    required this.isPersonal,
    this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: isPersonal ? personalTypeButton() : companyTypeButton(),
    );
  }

  Widget companyTypeButton() {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 7.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.grey.shade200,
              border: Border.all(color: Colors.grey.shade400)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                  child: GestureDetector(
                onTap: () {
                  if (!isPersonal) {
                    onTypeChanged();
                  }
                },
                child: const Row(
                  children: [
                    Expanded(child: SizedBox()),
                    Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'Personal',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0),
                    ),
                    Expanded(child: SizedBox()),
                  ],
                ),
              )),
              const Flexible(flex: 1, child: SizedBox()),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
                child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 7.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.orange,
                border: Border.all(color: Colors.orange),
              ),
              child: const Row(
                children: [
                  Expanded(child: SizedBox()),
                  Icon(
                    Icons.house,
                    color: Color(BasicColors.tertiary),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    'Company',
                    style: TextStyle(
                        color: Color(BasicColors.tertiary),
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0),
                  ),
                  Expanded(child: SizedBox()),
                ],
              ),
            )),
            const Flexible(flex: 1, child: SizedBox()),
          ],
        )
      ],
    );
  }

  Widget personalTypeButton() {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 7.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.grey.shade200,
              border: Border.all(color: Colors.grey.shade400)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Flexible(flex: 1, child: SizedBox()),
              Flexible(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    if (isPersonal) {
                      onTypeChanged();
                    }
                  },
                  child: const Row(
                    children: [
                      Expanded(child: SizedBox()),
                      Icon(
                        Icons.house,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        'Company',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0),
                      ),
                      Expanded(child: SizedBox()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
                child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 7.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.orange,
                border: Border.all(color: Colors.orange),
              ),
              child: const Row(
                children: [
                  Expanded(child: SizedBox()),
                  Icon(
                    Icons.person,
                    color: Color(BasicColors.tertiary),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    'Personal',
                    style: TextStyle(
                        color: Color(BasicColors.tertiary),
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0),
                  ),
                  Expanded(child: SizedBox()),
                ],
              ),
            )),
            const Flexible(flex: 1, child: SizedBox()),
          ],
        )
      ],
    );
  }
}
