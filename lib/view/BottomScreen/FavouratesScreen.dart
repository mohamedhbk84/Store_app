import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/cubit/BottomScreenCubit/ProfileCubit.dart';
class FavourateScreen extends StatelessWidget {
  const FavourateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Text("المفضلة"),
          Divider(),
          BlocProvider.of<ProfileCubit>(context).favouriteList.length >0?
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.1,
                children: List.generate(BlocProvider
                    .of<ProfileCubit>(context)
                    .favouriteList
                    .length, (index) =>
                    Padding(
                      padding: EdgeInsets.only(left: 4, right: 4),
                      child: Card(
                        elevation: 7,
                        child: Container(
                          // color: Colors.white,
                          height: 135,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                alignment: AlignmentDirectional.bottomStart,
                                children: [
                                  Column(
                                    children: [
                                      Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          Center(
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 10),
                                              height: 128,
                                              width: 135,

                                              decoration: BoxDecoration(

                                                  borderRadius: BorderRadius
                                                      .circular(80),
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        BlocProvider
                                                            .of<ProfileCubit>(
                                                            context)
                                                            .favouriteList[index]
                                                            .image),)),
                                              //"https://image.freepik.com/free-psd/hand-holding-smartphone-connect-bluetooth-speaker_53876-115875.jpg",),fit: BoxFit.fill)),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {},
                                                iconSize: 12,
                                                icon: CircleAvatar(
                                                  backgroundColor:
                                                  Colors.grey.shade300
                                                      .withOpacity(.9),
                                                  child: Icon(
                                                    Icons.favorite_border,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                              // Icon(
                                              //   Icons.star,
                                              //   color: Colors.yellow,
                                              // ),
                                            ],
                                          ),


                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          mainAxisAlignment: MainAxisAlignment
                                              .start,
                                          children: [
                                            Center(
                                              child: Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Text(
                                                  BlocProvider
                                                      .of<ProfileCubit>(context)
                                                      .favouriteList[index].name,
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style:const TextStyle(
                                                    fontSize: 16.0,
                                                    height: 1.1,
                                                  ),
                                                ),
                                              ),
                                            ),


                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ),
              ),):Expanded(child: Center(child:Text("No Favourite"))),
          
        ],),
      ),
    );
  }
  // Widget featuredItem() =>
  //     Padding(
  //   padding: EdgeInsets.only(left: 4,right: 4),
  //   child: Card(
  //     elevation: 7,
  //     child: Container(
  //       // color: Colors.white,
  //       height: 135,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Stack(
  //             alignment: AlignmentDirectional.bottomStart,
  //             children: [
  //               Column(
  //                 children: [
  //                   Stack(
  //                     alignment: Alignment.topRight,
  //                     children: [
  //                       Center(
  //                         child: Container(
  //                           margin:const EdgeInsets.only(top: 10),
  //                           height: 128,
  //                           width: 135,
  //
  //                           decoration: BoxDecoration(
  //
  //                               borderRadius: BorderRadius.circular(80),
  //                               image: DecorationImage(image: NetworkImage("https://image.freepik.com/free-psd/hand-holding-smartphone-connect-bluetooth-speaker_53876-115875.jpg",),fit: BoxFit.fill)),
  //                         ),
  //                       ),
  //                       Row(
  //                         children: [
  //                           IconButton(
  //                             onPressed: () {},
  //                             iconSize: 12,
  //                             icon: CircleAvatar(
  //                               backgroundColor:
  //                               Colors.grey.shade300.withOpacity(.9),
  //                               child: Icon(
  //                                 Icons.favorite_border,
  //                                 color: Colors.white,
  //                               ),
  //                             ),
  //                           ),
  //                           Spacer(),
  //                           // Icon(
  //                           //   Icons.star,
  //                           //   color: Colors.yellow,
  //                           // ),
  //                         ],
  //                       ),
  //
  //
  //                     ],
  //                   ),
  //                   Padding(
  //                     padding: EdgeInsets.all(0),
  //                     child: Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           "VIVo",
  //                           maxLines: 2,
  //                           overflow: TextOverflow.ellipsis,
  //                           style: TextStyle(
  //                             fontSize: 13.0,
  //                             height: 1.1,
  //                           ),
  //                         ),
  //                         // Row(
  //                         //   children: [
  //                         //     CircleAvatar(
  //                         //       backgroundColor: Colors.grey,
  //                         //       radius: 15,
  //                         //       child: Image.network(""),
  //                         //     ),
  //                         //     Text(
  //                         //       'MobileShip',
  //                         //       style: TextStyle(
  //                         //         fontSize: 12.0,
  //                         //         color: Colors.orange,
  //                         //       ),
  //                         //     ),
  //                         //     Spacer(),
  //                         //     Icon(
  //                         //       Icons.star,
  //                         //       color: Colors.yellow,
  //                         //     ),
  //                         //     SizedBox(
  //                         //       width: 3,
  //                         //     ),
  //                         //     Text(".5"),
  //                         //   ],
  //                         // ),
  //                         // Text(
  //                         //   "Find Your best Phone",
  //                         //   maxLines: 2,
  //                         // ),
  //                         Row(
  //                           children: [
  //                             Text(
  //                               "LE 3000",
  //                             ),
  //                             Spacer(),
  //                             Container(
  //                               width: 60,
  //                               height: 30,
  //                               decoration: BoxDecoration(
  //                                   borderRadius: BorderRadius.only(
  //                                       topLeft: Radius.circular(20))),
  //                               child: Center(
  //                                 child: Text(
  //                                   "+Add",
  //                                 ),
  //                               ),
  //                             )
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   ),
  // );
}
