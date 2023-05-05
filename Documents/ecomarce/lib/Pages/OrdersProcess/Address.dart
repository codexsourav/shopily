import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../../Widgets/MyAppbar.dart';
import '../../Widgets/fileds/FormInputBox.dart';
import '../../Widgets/fileds/bottamNavBtn.dart';
import '../../constents/statesList.dart';
import 'ConfirmOrder.dart';

class AddressPage extends StatelessWidget {
  AddressPage({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppbar(context, title: 'Address'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                formInputBox(
                  hint: 'Your Full Name',
                  keybordtype: TextInputType.name,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                formInputBox(
                  hint: 'Mobile Number',
                  keybordtype: TextInputType.phone,
                ),
                formInputBox(
                  hint: 'Adress Line 1',
                  keybordtype: TextInputType.text,
                ),
                formInputBox(
                  hint: 'Adress Line 2 (optional)',
                  keybordtype: TextInputType.text,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 25,
                      child: formInputBox(
                        hint: 'City',
                        keybordtype: TextInputType.text,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - 25,
                      child: formInputBox(
                        hint: 'Pincode',
                        keybordtype: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    'State',
                    style: TextStyle(
                      color: Color.fromARGB(255, 70, 70, 70),
                      fontSize: 12,
                    ),
                  ),
                ),
                CustomDropdownButton2(
                  buttonWidth: MediaQuery.of(context).size.width - 30,
                  dropdownWidth: MediaQuery.of(context).size.width - 30,
                  buttonHeight: 50,
                  buttonDecoration: BoxDecoration(
                    color: Color.fromARGB(255, 247, 247, 247),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  hint: stateName[0],
                  dropdownItems: stateName,
                  value: stateName[3],
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: bottamBtn(
          title: 'Confirm Address',
          ontap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ConfirmOrder(),
            ));
          }),
    );
  }
}
