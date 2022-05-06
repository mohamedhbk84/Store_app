import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:store/cubit/Auth_cubit/OTPCubit.dart';
import 'package:store/cubit/Auth_cubit/RegisterCubit.dart';
import 'package:store/shared/component/component.dart';
import 'package:store/view/auth/register.dart';
import 'package:store/view/bottomNav/bottomNavagation.dart';

class OTPControllerScreen extends StatelessWidget {
  final String phone;
  OTPControllerScreen({Key? key,required this.phone}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  var PinOTPController = TextEditingController();
  final FocusNode pinCodeFocus = FocusNode();


  @override
  Widget build(BuildContext context) {
    var widthSize = MediaQuery.of(context).size.width;
    var heightSize = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (BuildContext context) => OTPCubit()..verifyPhoneNumber(context:context,phone: phone,),
      child: BlocConsumer<OTPCubit, OTPStates>(
        listener: (context, state) {
          if(state is AppReloadDataStates){
            navigateAndFinish(context, RegisterScreen(phone: phone.replaceAll("+2", ""),));
          }
        },
        builder: (context, state) {
          var cubit = OTPCubit.get(context);
          return SafeArea(
            child: Scaffold(
              key: scaffoldKey,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.all(8),
                  child: Image.asset("assets/otp.png"),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                            "Verification  : $phone"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Pinput(
                        length:6,
                        // fieldsCount: 6,
                        // textstyle: TextStyle(fontSize: 25, color: Colors.white),
                        // eachFieldWidth: 40.0,
                        // eachFieldHeight: 50.0,
                        focusNode: pinCodeFocus,
                        controller: PinOTPController,
                        pinAnimationType: PinAnimationType.rotation,

                        androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
                        listenForMultipleSmsOnAndroid: true,
                        onCompleted: (value){
                          print(value);
                        },
                        onSubmitted: (pin) async {

                          try {
                            await FirebaseAuth.instance
                                .signInWithCredential(
                                    PhoneAuthProvider.credential(
                                        verificationId: cubit.verficationCode!,
                                        smsCode: pin))
                                .then((value) {
                              // if (value.user != null) {
                              navigateAndFinish(context, RegisterScreen(phone: phone.replaceAll("+2", ""),));

                             // }
                            });
                          } catch (e) {
                            FocusScope.of(context).unfocus();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Invaild OTP"),
                              duration: Duration(seconds: 3),
                            ));
                          }
                        }),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
