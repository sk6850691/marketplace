import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketplace/models/appmodel.dart';
import 'package:marketplace/models/hostingmodel.dart';
import 'package:marketplace/providers/appprovider.dart';
import 'package:marketplace/screens/HostingCartScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HostingDetails extends StatefulWidget {
  final name;
  final image;
  final description;
  final price;
  final List features;
final HostingModel hostingModel;


  const HostingDetails({Key key,this.image,this.features,this.description,this.price, this.name, this.hostingModel}) : super(key: key);

  @override
  _HostingDetailsState createState() => _HostingDetailsState();
}

class _HostingDetailsState extends State<HostingDetails> {
  String uid = '';



  getDetails()async{

    SharedPreferences prefs =await SharedPreferences.getInstance();
   uid =  prefs.get('uid');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
  }
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider.builder(itemCount: widget.image.length,
                itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex){
                  return Image.network(widget.image[itemIndex],cacheWidth: 200,cacheHeight: 200,);

                },
                options: CarouselOptions(
                    autoPlay: true
                )),

            Text('Our Best Sellinh hosting',style: GoogleFonts.montserrat(fontSize: 25,fontWeight: FontWeight.w900),),

            SizedBox(height: 10,),
            Column(
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
                  child: ListView.separated(
                    separatorBuilder: (context,index)=>SizedBox(height: 10,),
                    itemBuilder: (context,index){
                    return Text(widget.features[index],style: GoogleFonts.montserrat(fontSize: 15,fontWeight: FontWeight.w600),);
                  },

                    itemCount:widget.features.length,),
                ),




                Padding(
                  padding: EdgeInsets.only(left: 100),
                  child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),

                      ),
                      child: Text('Order'),
                      minWidth: 120,
                      color: Colors.red,
                      onPressed: (){

                        appProvider.addHostingToToCart(hostingModel: widget.hostingModel);

                        Navigator.push(context, MaterialPageRoute(builder: (context)=>HostingCartScreen(cartItem: appProvider.cartitem,price: widget.price,description: widget.description,)
                        )
                        );


                      }),
                ),
                // Text(widget.appModel.features)
              ],
            )
          ],

        ),
      ),
    );
  }
}
