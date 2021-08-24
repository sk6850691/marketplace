import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketplace/models/CategoryModel.dart';
class CategoryWidget extends StatefulWidget {
  final CategoryModel categoryModel;
  const CategoryWidget({Key key,this.categoryModel}) : super(key: key);

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(widget.categoryModel.image,cacheHeight: 100,cacheWidth: 150,),
          Text(widget.categoryModel.name,style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,fontSize: 15),)
        ],
      ),
    );
  }
}
