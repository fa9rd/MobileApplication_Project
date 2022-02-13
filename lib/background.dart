// import 'package:flutter/material.dart';
// import 'Animation/FadeAnimation.dart';
// import './screens/login_screen.dart';
// import '../animation/animations.dart';
// class background extends StatefulWidget {
//   const background({ Key key }) : super(key: key);

//   @override
//   _backgroundState createState() => _backgroundState();
// }

// class _backgroundState extends State<background> {

// final i = new LoginScreen();
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;

//     return Column(
//               children: <Widget>[
//                 Container(
//                   height: 150,
//                   decoration: BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage('assets/images/background.png'),
//                           fit: BoxFit.fill
//                       )
//                   ),
//                   child: Stack(
//                     children: <Widget>[
//                       Row(
//                         children: [
//                           Container(
//                                   height: height / 19,
//                                   width: width / 2,
//                                   child: TopAnime(
//                                     2,
//                                     5,
//                                     child: ListView.builder(
//                                       itemCount: feature.length,
//                                       scrollDirection: Axis.horizontal,
//                                       itemBuilder:
//                                           (BuildContext context, int index) {
//                                         return GestureDetector(
//                                           onTap: () {
//                                             setState(() {
//                                               i = index;
//                                             });
//                                           },
//                                           child: Column(
//                                             children: [
//                                               Padding(
//                                                 padding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 20),
//                                                 child: Text(
//                                                   feature[index],
//                                                   style: TextStyle(
//                                                     color: i == index
//                                                         ? Colors.black
//                                                         : Colors.grey,
//                                                     fontSize: 20,
//                                                     fontWeight: FontWeight.bold,
//                                                   ),
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 height: 8,
//                                               ),
//                                               i == index
//                                                   ? Container(
//                                                       height: 2.8,
//                                                       width: width / 6,
//                                                       color: Color.fromRGBO(143, 148, 251, 5),
//                                                     )
//                                                   : Container(),
                                            
                                            
//                                             ],
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(child: Container()),
//                                 RightAnime(
//                                   1,
//                                   15,
//                                   curve: Curves.easeInOutQuad,
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(20),
//                                     child: Container(
//                                       width: 60,
//                                       height: 60,
//                                       color: Colors.red[400],
//                                       child: i == 0
//                                           ? Image(
//                                               image: NetworkImage(
//                                                   "https://i.pinimg.com/564x/5d/a3/d2/5da3d22d08e353184ca357db7800e9f5.jpg"),
//                                             )
//                                           : Icon(
//                                               Icons.account_circle_outlined,
//                                               color: Colors.white,
//                                               size: 40,
//                                             ),
//                                     ),
//                                   ),
//                                 )     
//                         ],
//                       )
                      
//                     ],
//                   ),
//                 )


//       ],
//     );
//   }
// }