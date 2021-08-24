import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketplace/providers/appprovider.dart';
import 'package:marketplace/screens/WebsiteDetails.dart';
import 'package:marketplace/widgets/AppWidget.dart';
import 'package:marketplace/widgets/BannerWidget.dart';
import 'package:marketplace/widgets/CategoryWidget.dart';
import 'package:marketplace/widgets/WebsiteWidget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'AppDetails.dart';
import 'CategoryProducts.dart';
class WebsiteScreen extends StatefulWidget {
  const WebsiteScreen({Key key}) : super(key: key);

  @override
  _WebsiteScreenState createState() => _WebsiteScreenState();
}

class _WebsiteScreenState extends State<WebsiteScreen> {
  int len = 0;
  AppProvider appProvider;



  List l = ['https://www.spaceo.ca/wp-content/uploads/2020/08/food-delivery-app-development.png'];
  List categories = ['Ecommerce','Social','ERP','Productivity'];
  int _currentIndex = 0;




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
            child: Text('Chat with our support'),

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
                  SizedBox(height: 20,),


                  Container(
                    height: 200,


                    child: Row(
                      children: appProvider.websiteBanners.map((e) => BannerWidget(bannerModel: e,)).toList(),
                    ),
                  ),



                  Text('Select an Website from Below Categories',style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,fontSize: 25),)

                  ,
                  SizedBox(height: 10,),
                  Container(
                    height: 130,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(

                      scrollDirection: Axis.horizontal,
                      itemCount: appProvider.websiteCategories.length,
                      itemBuilder: (context,index){
                        return GestureDetector(
                            onTap: (){
                              appProvider.getWebsitesFromCategories(name: appProvider.websiteCategories[index].name);

                              Navigator.push(context,MaterialPageRoute(builder: (context)=>CategoryProducts()));

                            },
                            child: CategoryWidget(categoryModel: appProvider.websiteCategories[index],));
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
                      itemCount:appProvider.websites.length,
                      itemBuilder: (context,index) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>
                                      WebsiteDetails(
                                        websiteModel: appProvider.websites[index],
                                        description: appProvider.websites[index].description,
                                        price: appProvider.websites[index].price,
                                        image: appProvider.websites[index].images,
                                        name: appProvider.websites[index].name,
                                        demolink: appProvider.websites[index].demolink,
                                        features: appProvider.websites[index].features,)));
                            },
                            child: WebsiteWidget(websiteModel: appProvider.websites[index],));
                      }),
                ] ),
          ));

  }
}
