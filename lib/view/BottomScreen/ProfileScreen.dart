import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/cubit/Auth_cubit/RegisterCubit.dart';
import 'package:store/cubit/BottomScreenCubit/ProfileCubit.dart';
import 'package:store/model/LoginModel.dart';
import 'package:store/model/getCity.dart';
import 'package:store/model/getRegion.dart';
import 'package:store/shared/component/component.dart';
class ProfileScreen extends StatelessWidget {
   ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var widthSize = MediaQuery.of(context).size.width;
    var heightSize = MediaQuery.of(context).size.height;
    return BlocConsumer<ProfileCubit,ProfileStates>(
      listener: (context, state) {

      },
      builder: (context,state){
        var cubit = ProfileCubit.get(context);

        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(children: [
                SizedBox( height: heightSize * .07),
                Text("Account".tr()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Radio<language>(

                        value:language.ar , groupValue: cubit.lang, onChanged: ( language? value)async{
                      cubit.changeLanguage(value);
                      await context.setLocale(Locale('ar'));
                    }),
                    Text("Arabic".tr()),
                    SizedBox(width: 10,),
                    Radio<language>(value:language.en , groupValue: cubit.lang, onChanged: (language? value)async{
                      cubit.changeLanguage(value);
                      await context.setLocale(Locale('en'));
                    }),
                    Text("English".tr()),
                  ],),
                //////////////////  follow  ///////////////
                SizedBox(
                  height: heightSize * .012,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Radio<themeLight>(

                        value:themeLight.dark , groupValue: cubit.theme, onChanged: ( themeLight? value){
                         cubit.isDark = true;
                      cubit.changetheme(value);
                      cubit.first();
                    }),
                    Text("dark".tr()),
                    SizedBox(width: 10,),
                    Radio<themeLight>(value:themeLight.light , groupValue: cubit.theme, onChanged: (themeLight? value){
                      cubit.changetheme(value);
                    }),

                    Text("light".tr()),
                  ],),
//////// text Form //
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: defaultFormField(
                      controller: cubit.nameController,
                      type: TextInputType.phone,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'ادخل  الاسم';
                        }
                        return null;
                      },

                      label: 'Name',
                      prefix: Icons.phone,
                      onTap: () {
                        print('Name taped');
                      }),
                ),


                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: defaultFormField(
                      controller: cubit.phoneController,
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
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: defaultFormField(
                    controller: cubit.passwordController,
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
                    controller: cubit.passwordConfirmController,
                    validate: (String? value) {
                      if (value!.isEmpty && value.length < 8) {
                        return 'password is too short at least 8 characters';
                      }
                      if (value != cubit.passwordController.text) {
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
                            child:city.cityName==null?Text(dummyUser.city):Text(city.cityName),
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
                            child:region.regionName==null?Text(dummyUser.region): Text(region.regionName),
                            value: region,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ):Center(child: CircularProgressIndicator(),),
                SizedBox(height: heightSize *.02,),
                defButton(context: context ,text:"EditAccount",onTap: (){
                  // navigateTo(context, RegisterScreen());
                } ),

              ],),
            ),
          ),
        );
      },
    );

  }
}
