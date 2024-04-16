import 'package:flutter/material.dart';
import 'package:my_profile/core/theme_app.dart';

class TextFormWidget extends StatelessWidget {
  late String phoneNumber;
  String generateCountryFlag() {
    String countryCode = "eg";

    return countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
              decoration: BoxDecoration(
                  border: Border.all(color: ThemeApp.lightGray),
                  borderRadius: const BorderRadius.all(Radius.circular(6))),
              child: Text("${generateCountryFlag()} +20"),
            )),
        const SizedBox(
          width: 16,
        ),
        Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                  border: Border.all(color: ThemeApp.mainColor),
                  borderRadius: const BorderRadius.all(Radius.circular(6))),
              child: TextFormField(
                autofocus: true,
                style: TextStyle(letterSpacing: 2.0, fontSize: 18),
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                cursorColor: Colors.black,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty || value.trim().isEmpty) {
                    return "please enter your phone";
                  } else if (value.length < 11) {
                    return "please enter 11 number";
                  }
                  return null;
                },
                onSaved: (value) {
                  phoneNumber = value!;
                },
              ),
            )),
      ],
    );
  }
}
