import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel{

  static const NAME = 'name';
  static const IMAGE = 'image';







  String _name;
  String _image;


  get name => _name;
 get image =>_image;


 CategoryModel.fromSnapshot(DocumentSnapshot snapshot){
   _name = snapshot.data()[NAME];
   _image = snapshot.data()[IMAGE];
 }
  }


