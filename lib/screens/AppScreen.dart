import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketplace/providers/appprovider.dart';
import 'package:marketplace/screens/CategoryProducts.dart';
import 'package:marketplace/widgets/AppWidget.dart';
import 'package:marketplace/widgets/BannerWidget.dart';
import 'package:marketplace/widgets/CategoryWidget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'AppDetails.dart';
class AppScreen extends StatefulWidget {
  const AppScreen({Key key}) : super(key: key);

  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  int len = 0;
  AppProvider appProvider;



  List l = ['https://www.spaceo.ca/wp-content/uploads/2020/08/food-delivery-app-development.png'];
  List categories = ['Ecommerce','Social','ERP','Productivity'];
  int _currentIndex = 0;
  List images = [];




  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
     appProvider = Provider.of<AppProvider>(context);

    return
          Scaffold(

              floatingActionButton: MaterialButton(


               color: Colors.blue,
                minWidth: 100,
                child: Text('Chat with our support '),

                onPressed: ()async{
                  await canLaunch('https://wa.link/sujli4') ? await launch('https://wa.link/sujli4') : throw 'Could not launch ';


                },

                shape: RoundedRectangleBorder(


                    borderRadius: BorderRadius.circular(20)
                ),
              ),
            body:




            SingleChildScrollView(
              child: Column(
              children:[

                
                Container(
                  height: 200,


                  child: Row(
                    children: appProvider.appBanners.map((e) => BannerWidget(bannerModel: e,)).toList(),
                  ),
                ),
                





                Text('Select an App from Below Categories',style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,fontSize: 25),)

                ,
                SizedBox(height: 10,),
                Container(
                  height: 130,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(

                    scrollDirection: Axis.horizontal,
                    itemCount: appProvider.categories.length,
                    itemBuilder: (context,index){
                      return GestureDetector(
                          onTap: (){
                            appProvider.getAppsFromCategories(name: appProvider.categories[index].name);

                            Navigator.push(context,MaterialPageRoute(builder: (context)=>CategoryProducts()));

                          },

                          child: CategoryWidget(categoryModel: appProvider.categories[index],));
                    },),
                ),
                SizedBox(
                  height: 10,
                ),



                Text('Our Best Selling Apps',style: GoogleFonts.montserrat(fontWeight: FontWeight.w800,fontSize: 25),),


                ListView.separated(
                physics: NeverScrollableScrollPhysics(),
               separatorBuilder: (context,index)=>SizedBox(height: 20,),
              shrinkWrap: true,
                itemCount:appProvider.apps.length,
                itemBuilder: (context,index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                AppDetails(
                                  appModel: appProvider.apps[index],
                                  description: appProvider.apps[index].description,
                                  price: appProvider.apps[index].price,
                                  image: appProvider.apps[index].images,
                                  name: appProvider.apps[index].name,
                                  demolink: appProvider.apps[index].demolink,
                                  features: appProvider.apps[index].features,)));
                      },
                      child: AppWidget(appModel: appProvider.apps[index],));
                }),
           ] ),
          ));

  }
}
