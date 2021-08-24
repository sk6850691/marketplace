import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketplace/models/AppPlanModel.dart';
class WebsitePlanWidget extends StatefulWidget {
  final AppPlanModel appPlanModel;
  const WebsitePlanWidget({Key key,this.appPlanModel}) : super(key: key);

  @override
  _WebsitePlanWidgetState createState() => _WebsitePlanWidgetState();
}

class _WebsitePlanWidgetState extends State<WebsitePlanWidget> {
  @override
  Widget build(BuildContext context) {
    return  Container(
        width: 200,
        child:    Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(widget.appPlanModel.name,style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,fontSize: 25),),

              SizedBox(
                height: 20,
              ),
              Text('Price'+' '+ '--'+' '+widget.appPlanModel.price.toString()),
              SizedBox(height: 10,),
              Container(
                height: 300,
                width: 500,

                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: ListView.separated(
                      separatorBuilder: (context,index)=>SizedBox(height: 10,),
                      itemCount: widget.appPlanModel.features.length,
                      shrinkWrap: true,
                      itemBuilder: (context,index){
                        return Text(widget.appPlanModel.features[index],style: GoogleFonts.montserrat(fontSize: 15,fontWeight: FontWeight.w500),);
                      }),
                ),
              )
            ],
          ),
        )

    );;
  }
}
