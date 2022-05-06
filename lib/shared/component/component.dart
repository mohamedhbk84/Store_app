

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  required String? Function(String? value) validate,
  required String label,
  required IconData prefix,
  bool isPassword = false,
  bool readOnly = false,
  IconData? suffix,
  Function? suffixPressed,
  Function? onTap,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        child: TextFormField(
          obscureText: isPassword,
          controller: controller,
          keyboardType: type,
          readOnly: readOnly,
          onFieldSubmitted: (s) {
            onSubmit!(s);
          },
          validator: validate,
          // onTap: () {
          //   onTap!();
          // },
          // onChanged: (s) {
          //   onChange!(s);
          // },
          decoration: InputDecoration(
            labelText: label,
            
            prefixIcon: Icon(prefix),
            suffixIcon: suffix != null
                ? IconButton(
                onPressed: () {
                  suffixPressed!();
                },
                icon: Icon(suffix))
                : null,
            contentPadding: EdgeInsets.all(6),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
          ),
        ),
      ),
    );

Widget editTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  required String? Function(String? value) validate,
  required String label,
}){
  return  Padding(
    padding: const EdgeInsets.only(left: 25,right: 25, top: 10,bottom: 10),
    child: Container(

      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
      child: TextFormField(
          controller: controller,
          keyboardType: type,
          onFieldSubmitted: (s) {
            onSubmit!(s);
          },
          validator: validate,
          decoration: InputDecoration(
              labelText: label,

              border:const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                borderSide: BorderSide(color: Colors.white),
              ),
              contentPadding: EdgeInsets.all(10),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                borderSide: BorderSide(color: Colors.black),
              )
          )
      ),
    ),
  );
}

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) =>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ), (route) {
      return false;
    });

Widget defButton({required BuildContext context,required Function () onTap, required String text}){
  return GestureDetector(
    onTap:onTap,
    child: Container(
      height: 50,
      width: MediaQuery.of(context).size.width * .7,
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(40)),
      child: Center(
        child: Text(
          "$text".tr(),
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    ),
  );
}

// Widget customDropdownMenu(
//     {String ?label,
//      required dynamic value,
//       String? hintText,
//       required List<DropdownMenuItem<dynamic>> ?itemList,
//       Function (dynamic value)? onChanged}) =>
//     Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: InputDecorator(
//           decoration: InputDecoration(
//             labelText: label,
//             // labelStyle: const TextStyle(
//             //     color: kPrimaryColor, fontWeight: FontWeight.bold),
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//           ),
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton(
//               value: value,
//               hint: Text(
//                 hintText!,
//                // style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//               ),
//               isExpanded: true,
//               items: itemList,
//               isDense: true,
//               onChanged: (value){
//                 onChanged!(value);
//               },
//             ),
//           )),
//     );




void showToast({required String msg, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}