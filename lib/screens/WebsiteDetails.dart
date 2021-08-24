import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketplace/models/websitemodel.dart';
import 'package:marketplace/providers/appprovider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'WebsiteCartScreen.dart';
class WebsiteDetails extends StatefulWidget {
  final name;
  final image;
  final description;
  final price;

  final List features;
  final String demolink;
  final WebsiteModel websiteModel;


  const WebsiteDetails({Key key,this.name,this.price,this.image,this.demolink,this.description,this.websiteModel, this.features,}) : super(key: key);

  @override
  _WebsiteDetailsState createState() => _WebsiteDetailsState();
}

class _WebsiteDetailsState extends State<WebsiteDetails> {


  String _url = "http://food.codingmonksolutions.com";
  int _currentIndex = 0;

  void _launchURL() async =>
      await canLaunch(widget.demolink) ? await launch(widget.demolink) : throw 'Could not launch $_url';
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      floatingActionButton: MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
        color: Colors.red,
        child: Text('Finalize Website'),
        onPressed: (){


          appProvider.addWebsiteToCart(websiteModel: widget.websiteModel);


          Navigator.push(context, MaterialPageRoute(builder: (context)=>WebsiteCartScreen(cartItem: appProvider.cartitem,price: widget.price,description: widget.description,)
          )
          );


        },
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: EdgeInsets.only(top: 40),
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  // enlargeCenterPage: true,
                  //scrollDirection: Axis.vertical,
                  onPageChanged: (index, reason) {
                    setState(
                          () {
                        _currentIndex = index;
                      },
                    );
                  },
                ),
                items: widget.image
                    .map<Widget>(
                      (item) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      margin: EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                      ),
                      elevation: 6.0,
                      shadowColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                        child: Stack(
                          children: [
                            Image.network(
                              item,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                )
                    .toList(),
              ),
            ),






            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.name,style: GoogleFonts.montserrat(fontSize: 25,fontWeight: FontWeight.w600),),
                  SizedBox(
                    height: 10,
                  ),
                  Text(widget.description,style: GoogleFonts.montserrat(fontWeight: FontWeight.w600,fontSize: 20),),
                  SizedBox(height: 10,),
                  Container(
                      height: 200,
                      width: 200,
                      child:

                      Column(
                        children: widget.features.map((e) => Text(e,style: GoogleFonts.montserrat(fontSize: 15,fontWeight: FontWeight.w500),)).toList(),
                      )


                    /* ListView.builder(

                    itemBuilder: (context,index){
                   return Text(widget.features[index],style: GoogleFonts.montserrat(fontSize: 15,fontWeight: FontWeight.w600),);
                  },

                  itemCount:widget.features.length,

                  ),*/
                  ),

                  MaterialButton(
                      child: Text('See Demo',style: GoogleFonts.montserrat(fontSize: 25,fontWeight: FontWeight.w900),



                      ),

                      onPressed: _launchURL),





                ],
              ),
            )
          ],

        ),
      ),
    );
  }
}
