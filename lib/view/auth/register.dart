import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/cubit/Auth_cubit/RegisterCubit.dart';
import 'package:store/cubit/BottomScreenCubit/ProfileCubit.dart';
import 'package:store/model/getCity.dart';
import 'package:store/model/getRegion.dart';
import 'package:store/shared/component/component.dart';
import 'package:store/shared/component/utils.dart';
import 'package:store/shared/network/local/cache_helper.dart';
import 'package:store/view/auth/otp_controller.dart';
import 'package:store/view/bottomNav/bottomNavagation.dart';

import '../../model/LoginModel.dart';

class RegisterScreen extends StatelessWidget {
  final String phone;
  RegisterScreen({Key? key,  required this.phone}) : super(key: key);
  var nameController = TextEditingController();

  var passwordController = TextEditingController();
  var passwordConfirmController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {


    var widthSize = MediaQuery.of(context).size.width;
    var heightSize = MediaQuery.of(context).size.height;
    return BlocProvider(create: (BuildContext context)=>RegisterCubit()..getDataCity()..getDataRegion(idCity: 0)..getPhone(phone: phone)
    ,child: BlocConsumer<RegisterCubit,RegisterStates>(
 listener: (context, state) {
     if(state is AppUserScuessRegister){
       print("registerr ------------------ ");
       BlocProvider.of<ProfileCubit>(context).getDataShared();
        navigateTo(context,const BottomNavigation());
     }
 },
        builder: (context,state){
   var cubit = RegisterCubit.get(context);
   // if(cubit.boolCity) {
     return Scaffold(
       body: SingleChildScrollView(
         child: Form(
           key: formKey,
           child: Column(
             children: [
               SizedBox(
                 height: heightSize * .07,
               ),
               Text("CreateAccount".tr()),
               SizedBox(
                 height: heightSize * .012,
               ),
               SizedBox(
                 height: heightSize * .18,
                 width: widthSize * .36,
                 child: Stack(
                   children: [

                     cubit.image!=null?    Center(
                       child: Container(
                         height: heightSize * .16,
                         width: widthSize * .34,
                         decoration: BoxDecoration(
                             color: Colors.grey,
                             borderRadius: BorderRadius.circular(100),image: DecorationImage(image: FileImage(cubit.image!, ),fit: BoxFit.fill))

                       ),
                     ):Center(
                       child: Container(
                           height: heightSize * .16,
                           width: widthSize * .34,
                           decoration: BoxDecoration(
                               color: Colors.grey,
                               borderRadius: BorderRadius.circular(100),)

                       ),
                     ),

                         GestureDetector(
                        onTap: (){
                          cubit.openImagePicker();
                        },
                           child: Container(height: 50,width: 50,

                             decoration: BoxDecoration(
                              color: Colors.indigo,
                                 borderRadius: BorderRadius.circular(50)
                             ),
                             child: Icon(Icons.add_a_photo,color: Colors.white,),
                                                              ),
                         ),


                   ],
                 ),
               ),

               SizedBox(
                 height: heightSize * .012,
               ),
               Text("matger".tr()),
               SizedBox(
                 height: heightSize * .012,
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   Radio<changeGender>(
                       value: changeGender.male,
                       groupValue: cubit.gender,
                       onChanged: (changeGender? value) {
                         cubit.changeRadio(value);
                       }),
                   Text("male".tr()),
                   SizedBox(
                     width: 10,
                   ),
                   Radio<changeGender>(
                       value: changeGender.female,
                       groupValue: cubit.gender,
                       onChanged: (changeGender? value) {
                         cubit.changeRadio(value);
                       }),
                   Text("female".tr()),
                 ],
               ),
//////// text Form //
               Padding(
                 padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                 child: defaultFormField(
                     controller: nameController,
                     type: TextInputType.name,
                     validate: (value) {
                       if (value!.isEmpty) {
                         return 'ادخل  الاسم';
                       }
                       return null;
                     },
                     label: 'Name',
                     prefix: Icons.person,
                     onTap: () {
                       print('Name taped');
                     }),
               ),

               Padding(
                 padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                 child: defaultFormField(
                     controller: cubit.phoneController,
                     type: TextInputType.phone,
                     readOnly: true,
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
               Padding(
                 padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                 child: defaultFormField(
                   controller: passwordController,
                   validate: (String? value) {
                     if (value!.isEmpty || value.length < 8) {
                       return 'password is too short';
                     }

                     return value.length < 8
                         ? 'Password must be greater 8'
                         : null;
                   },
                   type: TextInputType.visiblePassword,
                   suffix: cubit.suffix,
                   onSubmit: (value) {},
                   isPassword: cubit.isPassword,
                   suffixPressed: () {
                     cubit.changePasswordVisibility();
                   },
                   label: 'password',
                   prefix: Icons.lock_outline,
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                 child: defaultFormField(
                   controller: passwordConfirmController,
                   validate: (String? value) {
                     if (value!.isEmpty && value.length < 8) {
                       return 'password is too short at least 8 characters';
                     }
                     if (value != passwordController.text) {
                       return 'password is not the same confirmation';
                     }
                     return value.length < 8
                         ? 'Password must be greater 8'
                         : null;
                   },
                   type: TextInputType.visiblePassword,
                   suffix: cubit.suffix,
                   onSubmit: (value) {},
                   isPassword: cubit.isPassword,
                   suffixPressed: () {
                     cubit.changePasswordVisibility();
                   },
                   label: 'confirm password',
                   prefix: Icons.lock_outline,
                 ),
               ),

               cubit.boolCity?  Container(
                 height: 50,
                 width: widthSize * .95,
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(30)),
                 child: InputDecorator(
                   decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(6),

                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
                   ),
                   child: DropdownButtonHideUnderline(
                     child: DropdownButton(
                       hint: Text('Please choose a City'),
                       // Not necessary for Option 1
                       value: cubit.city ?? null,
                       onChanged: (newValue) {
                         cubit.changeCity(newValue);
                       },
                       items: cubit.getCity!.city.map((city) {
                         return DropdownMenuItem<City>(
                           child: Text(city.cityName),
                           value: city,
                         );
                       }).toList(),
                     ),
                   ),
                 ),
               ):Center(child: CircularProgressIndicator(),),
//// / region //////////
               SizedBox(height: heightSize *.02,),
                     cubit.boolRegion?  Container(
                 height: 50,
                 width: widthSize * .95,
                 decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(30)),
                 child:  InputDecorator(
                   decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(6),

                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
                   ),
                   child: DropdownButtonHideUnderline(
                     child: DropdownButton(
                       hint: Text('Please choose a Region'),
                       // Not necessary for Option 1
                       value: cubit.regions ?? null,
                       onChanged: (newValue) {
                         cubit.changeRegion(newValue);
                       },
                       items: cubit.getRegion!.regions.map((region) {
                         return DropdownMenuItem<Regions>(
                           child: Text(region.regionName),
                           value: region,
                         );
                       }).toList(),
                     ),
                   ),
                 ),
               ):Center(child: CircularProgressIndicator(),),
 SizedBox(height: heightSize *.02,),

               defButton(
                   context: context,
                   text: "CreateAccount",
                   onTap: () async{
    if (formKey.currentState!.validate()   ) {
      print("--------------");
      print( cubit.idcity);
      print( cubit.image!.path.split("/").last.toString());
      if(cubit.city !=null && cubit.regions !=null &&cubit.image !=null){
          FormData form = FormData.fromMap({
          "mobile":cubit.phoneController.text,
          "password":passwordController.text,
          "password_confirmation":passwordConfirmController.text,
          "name":nameController.text,
          "gender":cubit.gender ==changeGender.male? 0:1,
          "city_id": cubit.idcity,
          "region_id":cubit.id_region,
          "image":await MultipartFile.fromFile(cubit.image!.path,filename:cubit.image!.path.split("/").last) ,
          "device_token":firebaseToken,
            //"device_token":"TOKEN Firebase",
          // "ip_address":"34.24.52.67",
          });
          cubit.userRegister(formData: form);
          dummyUser.name = nameController.text;
          dummyUser.city = cubit.cityname;
          dummyUser.city_id = cubit.idcity.toString();
          dummyUser.region =cubit.regionname;
          dummyUser.region_id = cubit.id_region.toString();
          dummyUser.mobile = cubit.phoneController.text;
          dummyUser.gender = cubit.gender ==changeGender.male? 'male':'female';
          CacheHelper.saveData(key: 'name', value: nameController.text);
          CacheHelper.saveData(key: 'city', value: cubit.cityname );
          CacheHelper.saveData(key: 'city_id', value:cubit.idcity );
          CacheHelper.saveData(key: 'region', value:cubit.regionname );
          CacheHelper.saveData(key: 'region_id', value: cubit.id_region);
          CacheHelper.saveData(key: 'password', value:passwordController.text);
          CacheHelper.saveData(key: 'mobile', value: cubit.phoneController.text);
          CacheHelper.saveData(key: 'gender', value:cubit.gender ==changeGender.male? 'male':'female' );
          // navigateTo(context, RegisterScreen());

          }else {
      showToast(msg:"يرجى اكمال البيانات ومحاولة التسجيل مرة اخري", state:ToastStates.ERROR);
          }
    }
                   }),

SizedBox(height: heightSize * .03,),
             ],
           ),
         ),
       ),
     );
   // }else{
   //   return Scaffold();
   // }
        },
      ),

    );


  }
}
