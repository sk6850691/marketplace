import 'package:cloud_firestore/cloud_firestore.dart';

class HostingModel{

  static const NAME = 'name';
  static const IMAGE = 'images';
  static const DESCRIPTION = 'description';
  static const PRICE = 'price';
  static const FEATURES = 'Features';






  String _name;
  List _images = [];
  int _price;
  String _description;
  List _features = [];


  get name => _name;
  get features => _features;
  get images =>_images;
  get description =>_description;
  get price => _price;




  HostingModel.fromSnapshot(DocumentSnapshot snapshot){

    _name = snapshot.data()[NAME];
    _images = snapshot.data()[IMAGE];
    _description= snapshot.data()[DESCRIPTION];
    _price = snapshot.data()[PRICE];
    _features = snapshot.data()[FEATURES];





  }}


