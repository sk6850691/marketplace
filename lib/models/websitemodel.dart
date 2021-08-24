import 'package:cloud_firestore/cloud_firestore.dart';

class WebsiteModel{

  static const NAME = 'name';
  static const IMAGE = 'images';
  static const PRICE ='price';
  static const DEMOLINK = 'demolink';
  static const DESCRIPTION = 'description';
  static const FEATURES = 'Features';






  String _name;
  List _images = [];
  int _price;
  List _features = [];
  String _description;
  String _demolink;


  get name => _name;
  get images =>_images;
  get price => _price;
  get description => _description;
  get features => _features;
  get demolink => _demolink;




  WebsiteModel.fromSnapshot(DocumentSnapshot snapshot){

    _name = snapshot.data()[NAME];
    _images = snapshot.data()[IMAGE];
    _price = snapshot.data()[PRICE];
    _description = snapshot.data()[DESCRIPTION];
    _demolink = snapshot.data()[DEMOLINK];
    _features = snapshot.data()[FEATURES];





  }}


