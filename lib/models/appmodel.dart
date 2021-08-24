import 'package:cloud_firestore/cloud_firestore.dart';

class AppModel{

  static const NAME = 'name';
  static const IMAGE = 'images';
  static const DESCRIPTION = 'description';
  static const PRICE = 'price';
  static const FEATURES= 'Features';
  static const DEMOLINK = 'demolink';






  String _name;
  List _images = [];
  String _description;
  int _price;
  List _feaures = [];
  String _demolink;


  get name => _name;
  List get features => _feaures;
  get images =>_images;
  get description => _description;
  get price => _price;
  get demolink => _demolink;



  AppModel.fromSnapshot(DocumentSnapshot snapshot){

    _name = snapshot.data()[NAME];
    _images = snapshot.data()[IMAGE];
    _price = snapshot.data()[PRICE];
    _description = snapshot.data()[DESCRIPTION];
    _feaures = snapshot.data()[FEATURES];
    _demolink = snapshot.data()[DEMOLINK];





  }


}