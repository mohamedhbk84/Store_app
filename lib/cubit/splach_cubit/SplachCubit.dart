
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/shared/component/utils.dart';
import 'package:store/shared/network/remote/dio_helper.dart';
import 'package:store/view/auth/login.dart';
import 'package:store/view/bottomNav/bottomNavagation.dart';

class splachCubit extends Cubit<splachStates>{
  splachCubit(): super(appSplachState());
  static splachCubit get(context) => BlocProvider.of(context);



  void firstStart(context){
    Timer(
      const  Duration(seconds: 5),
          () => Navigator.of (context).pushReplacement(
        MaterialPageRoute(
            builder: (BuildContext context) =>
                Utils.getToken() ==""?
                LoginScreen():const BottomNavigation()),
      ),
    );
  }
String? imageUrl;
  void getData(){
    DioHelper.getData(url: "settingapp").then((value) {
   print(value.data);
 imageUrl =value.data["Settingapp"][0]["splash"];

 print(imageUrl);
      emit(getScuessData());
    }).catchError((onError){
      print(onError.toString());
      emit(getErrorData());
    });
  }

}

abstract class splachStates {}
class appSplachState extends splachStates {}
class reloadscreen extends splachStates {}
class getScuessData extends splachStates{}
class getErrorData extends splachStates{}