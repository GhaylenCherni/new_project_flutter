import 'dart:ffi';

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.teal,
       leading: Icon(
         Icons.menu,
       ),
       title: Text(
           'First App',
       ),
       actions: [
         IconButton(
           icon:  Icon(
             Icons.notification_important,
           ),
           onPressed:(){
             print ('Hello Notification');
           },
           ),
         IconButton(
           icon: Text(
             'hello',
         ),
         onPressed:HelloPressed,
           ),

       ],
     ),
     body:Column(
       children: [
         Padding(
           padding: const EdgeInsets.all(50.0),
           child: Container(
             decoration: BoxDecoration(
               borderRadius: BorderRadiusDirectional.only(
                 topStart: Radius.circular(20.0),
               ),
             ),
             clipBehavior: Clip.antiAliasWithSaveLayer,
             child: Stack(
               alignment: Alignment.bottomCenter,
               children: [
                 Image(
                   image: NetworkImage(
                   'https://hips.hearstapps.com/hmg-prod/images/close-up-of-blossoming-rose-flower-royalty-free-image-1580853844.jpg',
                 ),
                   height:200.0 ,
                   width:200.0 ,
                   fit: BoxFit.cover,
                 ),
                 Container(
                   width: 200.0,
                   color: Colors.red.withOpacity(.7),
                   padding: const EdgeInsets.symmetric(
                     vertical: 10.0,
                   ),
                   child: Text(
                       'Flower',
                     textAlign: TextAlign.center,
                     style: TextStyle(
                       fontSize: 20.0,
                       color: Colors.white,
                     ),
                   ),
                 ),
               ],
             ),
           ),
         ),
       ],
     ),
   );
  }

  void HelloPressed(){
    print('Hello');
  }


}