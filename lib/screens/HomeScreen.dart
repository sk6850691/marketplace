import 'dart:async';
import 'dart:ui';


import 'package:flutter/material.dart';
import 'package:marketplace/providers/appprovider.dart';
import 'package:marketplace/screens/AppScreen.dart';
import 'package:marketplace/screens/HostingScreen.dart';
import 'package:marketplace/screens/MyOrders.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:preload_page_view/preload_page_view.dart';

import 'package:provider/provider.dart';

import 'WebsiteScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  AppScreen screen ;

  showhomescreen(){

    screen = AppScreen();


  }





  int _currentIndex = 0;
  PreloadPageController pageController;

  onTap({index}){

    setState(() {
      pageController.animateToPage(index, duration: Duration(milliseconds: 10), curve: Curves.bounceOut);
    });

  }









  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          currentIndex: _currentIndex,
          onTap: (index){

            setState(() {
              onTap(index: index);
            });

          },
          items: [
            BottomNavigationBarItem(

                title:Text('Apps'),icon: Icon(MdiIcons.application)),
            BottomNavigationBarItem(
                title: Text('Websites'),
                icon: Icon(MdiIcons.web)),
            BottomNavigationBarItem(

                title: Text('Servers & Hosting'),
                icon: Icon(MdiIcons.server)),
            BottomNavigationBarItem(

              title: Text('My Orders'),
              icon: Icon(MdiIcons.cart)
            )

          ],
        ),

        body:PreloadPageView(
          controller: pageController,

          onPageChanged: (index){
            setState(() {
              _currentIndex = index;
            });

          },
          children: [

          AppScreen(),
            WebsiteScreen(),
            HostingScreen(),
            MyOrders()


          ],)
      /* ListView(
        shrinkWrap: true,
        children: [
         Card(
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(10)
           ),



             child:Image.network(
             'https://firebasestorage.googleapis.com/v0/b/shine-of-coins-601fb.appspot.com/o/Hills-near-Chennai.jpg?alt=media&token=ebf63e79-0644-4f05-8918-fdaed1705fcb',
               fit: BoxFit.cover,
             )
           ),
          SizedBox(
            height: 10,
          ),
         Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
    const SizedBox(width: 10, height: 100.0),
    const Text(

    'DISCOVER',
    style: TextStyle(fontSize: 43.0,fontStyle: FontStyle.italic),
    ),
    const SizedBox(width: 20.0, height: 100.0),
    DefaultTextStyle(

    style: const TextStyle(
      color: Colors.black,
    fontSize: 40.0,
    fontFamily: 'Horizon',
    ),
    child: AnimatedTextKit(
    animatedTexts: [
    RotateAnimatedText('TREKS'),
    RotateAnimatedText('BIKES'),
    RotateAnimatedText('HOTELS'),
    ],
    onTap: () {
    print("Tap Event");
    },
    ),
    ),
    ],
         ),



          Container(
      height: 300,
            width: 100,

            child: GestureDetector(
              onTap:(){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>Experiences()));
              },

              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 20,),

                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                  itemCount: locationProvider.locations.length ,
                  itemBuilder: (context,index){
                    return LocationWidget(locationModel: locationProvider.locations[index],);
                  }),
            ),
          )
        ],
      )*/
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PreloadPageController();
    setState(() {
      showhomescreen();

    });

  }
}
