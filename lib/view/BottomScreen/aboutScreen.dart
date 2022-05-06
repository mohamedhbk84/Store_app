import 'package:flutter/material.dart';
import 'package:store/shared/component/component.dart';
class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var widthSize = MediaQuery.of(context).size.width;
    var heightSize = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
 SizedBox(height: heightSize*.08,),
          Text("نحن"),
          SizedBox(height: heightSize*.06,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            // controller: controller,
            keyboardType: TextInputType.name,
            minLines: 7,
           maxLines: 10,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(6),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ),

         Spacer(),
          defButton(context: context ,text:"سياسية الخصوصية",onTap: (){
            // navigateTo(context, RegisterScreen());
          } ),
          SizedBox(height: heightSize*.04,),
Row(
   mainAxisAlignment: MainAxisAlignment.spaceAround,
  children: [
   // SizedBox(width: 10,),
  IconButton(onPressed: (){}, icon: Icon(Icons.share,size: 50,)),
  // Spacer(),
  IconButton(onPressed: (){}, icon: Icon(Icons.whatsapp,size: 50,)),
    // SizedBox(width: 15,),

  ],),
          SizedBox(height: heightSize*.08,),
        ],),
      ),
    );
  }
}
