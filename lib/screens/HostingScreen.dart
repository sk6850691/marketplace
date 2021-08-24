import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketplace/providers/appprovider.dart';
import 'package:marketplace/screens/HosstingDetails.dart';
import 'package:marketplace/widgets/AppWidget.dart';
import 'package:marketplace/widgets/BannerWidget.dart';
import 'package:marketplace/widgets/CategoryWidget.dart';
import 'package:marketplace/widgets/HostingWidget.dart';
import 'package:provider/provider.dart';

import 'AppDetails.dart';
import 'CategoryProducts.dart';
class HostingScreen extends StatefulWidget {
  const HostingScreen({Key key}) : super(key: key);

  @override
  _HostingScreenState createState() => _HostingScreenState();
}


class _HostingScreenState extends State<HostingScreen> {

  List l = ['https://www.blogtyrant.com/wp-content/uploads/2012/03/choose-best-blog-hosting.png',
  'https://d1u4v6449fgzem.cloudfront.net/2020/03/What-Does-Hosting-Look-Like-at-Different-Traffic-Levels-1.png'
  ];

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(

            children:[


              Container(
                height: 200,


                child: Row(
                  children: appProvider.hostingBanners.map((e) => BannerWidget(bannerModel: e,)).toList(),
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
                  itemCount: appProvider.hostingCategories.length,
                  itemBuilder: (context,index){
                    return GestureDetector(
                        onTap: (){
                          appProvider.getHostingFromCategories(name: appProvider.hostingCategories[index].name);

                          Navigator.push(context,MaterialPageRoute(builder: (context)=>CategoryProducts()));

                        },
                        child: CategoryWidget(categoryModel: appProvider.hostingCategories[index],));
                  },),
              ),

              SizedBox(
                height: 10,
              ),
              Text('Trending Hosting Plans',style: GoogleFonts.montserrat(fontWeight: FontWeight.w600,fontSize: 25),),
              GestureDetector(

                onTap: (){

                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AppDetails()));
                },
                child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context,index)=>SizedBox(height: 20,),
                    shrinkWrap: true,
                    itemCount: appProvider.hosting.length,
                    itemBuilder: (context,index){
                      return GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                HostingDetails(

                                  description: appProvider.hosting[index].description,
                                  features: appProvider.hosting[index].features,
                                  name: appProvider.hosting[index].name,
                                  price: appProvider.hosting[index].price,
                                  image: appProvider.hosting[index].images,
                                hostingModel: appProvider.hosting[index],
                                )));
                          },
                          child: HostingWidget(hostingModel: appProvider.hosting[index],));
                    }),
              ),
            ]),
      ),
    );
  }
}
