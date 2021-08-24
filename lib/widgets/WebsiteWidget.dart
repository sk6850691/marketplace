import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketplace/models/websitemodel.dart';
class WebsiteWidget extends StatefulWidget {
  final WebsiteModel websiteModel;
  const WebsiteWidget({Key key,this.websiteModel}) : super(key: key);

  @override
  _WebsiteWidgetState createState() => _WebsiteWidgetState();
}

class _WebsiteWidgetState extends State<WebsiteWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            //Text(widget.appModel.price),
            Image.network(widget.websiteModel.images[0],fit: BoxFit.fitWidth,),
            Text(widget.websiteModel.name,style: GoogleFonts.montserrat(fontSize: 25,fontWeight: FontWeight.w600),),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
