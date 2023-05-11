import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:ecomarce/helpers/apihelper.dart';
import 'package:ecomarce/provider/order/orderProvider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../Widgets/MyAppbar.dart';
import '../../Widgets/fileds/FormInputBox.dart';
import '../../Widgets/fileds/bottamNavBtn.dart';
import '../../constents/statesList.dart';
import 'ConfirmOrder.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController pincode = TextEditingController();
  String state = stateName[0];

  var address = {};
  bool loading = false;
  bool setloading = false;

  getAddress() async {
    setState(() {
      loading = true;
    });
    Map data = await ApiHelper.callapi(path: '/address');
    print(data);
    if (!data.containsKey('error')) {
      name.text = data['name'] ?? "";
      mobile.text = (data['mobile'] ?? "").toString();
      address1.text = data['addr1'] ?? "";
      address2.text = data['addr2'] ?? "";
      city.text = data['city'] ?? "";
      pincode.text = (data['pincode'] ?? "").toString();
      state = data['state'];
    }
    setState(() {
      address = data;
      loading = false;
    });
  }

  updateAddress() async {
    setState(() {
      setloading = true;
    });

    Map data = await ApiHelper.callapi(path: '/address', method: "PUT", body: {
      "name": name.text,
      "mobile": mobile.text,
      "addr1": address1.text,
      "addr2": address2.text,
      "city": city.text,
      "pincode": pincode.text,
      "state": state,
    });

    setState(() {
      setloading = false;
    });
    if (data.containsKey('success')) {
      context.read<OrderProvider>().setAddress(address: data['response']);
      GoRouter.of(context).push(Uri(path: '/user/invoic').toString());
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppbar(context, title: 'Address'),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      formInputBox(
                        controller: name,
                        hint: 'Your Full Name',
                        keybordtype: TextInputType.name,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Your Name';
                          }
                          return null;
                        },
                      ),
                      formInputBox(
                        controller: mobile,
                        hint: 'Mobile Number',
                        keybordtype: TextInputType.phone,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Your Phone';
                          } else if (value.length != 10) {
                            return 'Invalid Mobile Number';
                          }
                          return null;
                        },
                      ),
                      formInputBox(
                        controller: address1,
                        hint: 'Adress Line 1',
                        keybordtype: TextInputType.text,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Adress Line 1';
                          }
                          return null;
                        },
                      ),
                      formInputBox(
                        controller: address2,
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
                              controller: city,
                              hint: 'City',
                              keybordtype: TextInputType.text,
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter City';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2 - 25,
                            child: formInputBox(
                              controller: pincode,
                              hint: 'Pincode',
                              keybordtype: TextInputType.number,
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Pincode';
                                }
                                return null;
                              },
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
                        hint: state,
                        dropdownItems: stateName,
                        value: state,
                        onChanged: (value) {
                          setState(() {
                            state = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
      bottomNavigationBar: loading
          ? null
          : bottamBtn(
              title: setloading ? "Loading..." : 'Confirm Address',
              ontap: setloading
                  ? null
                  : () {
                      if (_formKey.currentState!.validate()) {
                        updateAddress();
                      }
                    }),
    );
  }
}
