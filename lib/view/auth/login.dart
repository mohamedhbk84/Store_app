import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/cubit/Auth_cubit/LoginCubit.dart';
import 'package:store/cubit/BottomScreenCubit/ProfileCubit.dart';
import 'package:store/shared/component/component.dart';
import 'package:store/shared/component/utils.dart';
import 'package:store/shared/network/local/cache_helper.dart';
import 'package:store/view/auth/PhoneAuth.dart';
import 'package:store/view/auth/otp_controller.dart';
import 'package:store/view/auth/register.dart';
import 'package:store/view/bottomNav/bottomNavagation.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var widthSize = MediaQuery.of(context).size.width;
    var heightSize = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if(state is getScuessLogin){
           if(state.loginModel.status == "true"){
             Utils.getToken();
             navigateAndFinish(context, BottomNavigation());
             CacheHelper.saveData(key: 'password', value:passwordController.text);
             BlocProvider.of<ProfileCubit>(context).getDataShared();

           }
          }else if(state is getErrorLogin){
           // showToast(msg:state.error, state:ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: heightSize * .1,
                    ),
                    Text("signin".tr()),
                    SizedBox(
                      height: heightSize * .012,
                    ),
                    Center(
                      child: Container(
                        height: heightSize * .21,
                        width: widthSize * .44,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(100)),
                      ),
                    ),

                    SizedBox(
                      height: heightSize * .012,
                    ),    Text("matger".tr()),
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
                    SizedBox(
                      height: heightSize * .015,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        InkWell(
                          onTap: (){
                         // navigateTo(context, OTPControllerScreen(phone:"+201000533161"));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Text("ForgetPassWord".tr(),
                                style: Theme.of(context).textTheme.headline2),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: heightSize * .03,
                    ),
                    defButton(context: context ,text:"signin",onTap: (){
                      if (formKey.currentState!.validate()) {
                        cubit.userLogin(
                            phone: phoneController.text,
                            password: passwordController.text,
                          context: context,

                        );
                      }
                    } ),
                    SizedBox(
                      height: heightSize * .03,
                    ),
                    defButton(context: context ,text:"CreateAccount",onTap: (){
                      navigateTo(context, PhoneAuthScreen());
                    } ),

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
