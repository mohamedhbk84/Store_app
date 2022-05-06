import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:store/shared/component/component.dart';
import 'package:store/view/auth/otp_controller.dart';
class PhoneAuthScreen extends StatelessWidget {
   PhoneAuthScreen({Key? key}) : super(key: key);
 var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var widthSize = MediaQuery.of(context).size.width;
    var heightSize = MediaQuery.of(context).size.height;
    return SafeArea(child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        SizedBox(
          height: heightSize * .012,
        ),    Text("Phone Verfication".tr()),
        SizedBox(
          height: heightSize * .012,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: defaultFormField(
              controller: phoneController,
              type: TextInputType.phone,
              validate: (value) {
                if (value!.isEmpty) {
                  return 'ادخل  التليفون';
                } else if (!value.toString().contains('01') ||
                    value.length > 12 ||
                    value.length < 10) {
                  return 'Ex:- 010 111 333 33 ';
                } else {
                  return null;
                }
              },
              label: 'Mobile Number',
              prefix: Icons.phone,
              onTap: () {
                print('phone taped');
              }),
        ),
          SizedBox(
            height: heightSize * .03,
          ),
          defButton(context: context ,text:"CreateAccount",onTap: (){
            navigateTo(context, OTPControllerScreen(phone: "+2${phoneController.text}"));
          } ),
      ],),
    ));
  }
}
