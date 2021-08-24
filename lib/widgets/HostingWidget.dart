import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketplace/models/appmodel.dart';
import 'package:marketplace/models/hostingmodel.dart';
class HostingWidget extends StatefulWidget {
  final HostingModel hostingModel;
  const HostingWidget({Key key,this.hostingModel}) : super(key: key);

  @override
  _HostingWidgetState createState() => _HostingWidgetState();
}

class _HostingWidgetState extends State<HostingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      child: Card(
        child: Column(
          children: [


            //Text(widget.appModel.price),
            Image.network(widget.hostingModel.images[0],fit: BoxFit.fitWidth,),
            Text(widget.hostingModel.name,style: GoogleFonts.montserrat(fontSize: 25,fontWeight: FontWeight.w600),),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
