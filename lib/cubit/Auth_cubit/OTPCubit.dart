

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/shared/component/component.dart';
import 'package:store/view/auth/register.dart';
import 'package:store/view/bottomNav/bottomNavagation.dart';

class OTPCubit extends Cubit<OTPStates>{

  OTPCubit():super(AppInitOTPStates());
  static OTPCubit get(context) =>BlocProvider.of(context);
 bool check = false;
  verifyPhoneNumber({context,required String phone}) async{
        await FirebaseAuth.instance.verifyPhoneNumber(
            phoneNumber: phone,
            //"+201000533160",
            verificationCompleted: (PhoneAuthCredential credential) async{
              print('name${ credential.smsCode.toString()}');
              await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
                print('name${value.user}');
                 if(value.user != null){
                   navigateAndFinish(context, RegisterScreen(phone: phone.replaceAll("+2", ""),));
                  print("the otp Complete");
              }
              });
              emit(AppReloadState());

            },
            verificationFailed: (FirebaseAuthException e){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(e.message.toString()),
                duration:const Duration(seconds: 3),
              ));
            },
            codeSent: (String vID, int ?resentToken){
              verficationCode = vID;
              // check = true;
              print("------ 22222 $resentToken");
              emit(AppReloadDataStates());
            },
            codeAutoRetrievalTimeout: (String vID){
              verficationCode = vID;
              print("--------vvvvvvvv $vID");
              emit(AppReloadState());
            },
        timeout: Duration(seconds: 60),
        );
  }
  String? verficationCode;
}
abstract class OTPStates {}
class AppInitOTPStates extends OTPStates {}
class AppReloadState extends OTPStates {}
class AppReloadDataStates extends OTPStates {}
