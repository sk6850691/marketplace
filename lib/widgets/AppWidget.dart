import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketplace/models/appmodel.dart';
class AppWidget extends StatefulWidget {
  final AppModel appModel;
  const AppWidget({Key key,this.appModel}) : super(key: key);

  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
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
            Image.network(widget.appModel.images[0],fit: BoxFit.fitWidth,),
            Text(widget.appModel.name,style: GoogleFonts.montserrat(fontSize: 25,fontWeight: FontWeight.w600),),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
