import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:marketplace/models/BannerModel.dart';
class BannerWidget extends StatefulWidget {
  final BannerModel bannerModel;
  const BannerWidget({Key key,this.bannerModel}) : super(key: key);

  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int _currentIndex = 0 ;
  @override
  Widget build(BuildContext context) {
   return CarouselSlider(
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
     items: widget.bannerModel.images
         .map<Widget>(
           (item) => Padding(
         padding: const EdgeInsets.all(8),
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
                   fit: BoxFit.fitWidth,
                   width: double.infinity,
                 ),

               ],
             ),
           ),
         ),
       ),
     )
         .toList(),
   );



}}
