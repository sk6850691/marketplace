import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel{

  static const NAME = 'name';
 static const IMAGES = 'images';







  String _name;
  List _images = [];

  get name => _name;
 get images => _images;


  BannerModel.fromSnapshot(DocumentSnapshot snapshot){
    _name = snapshot.data()[NAME];
    _images = snapshot.data()[IMAGES];
  }
}


