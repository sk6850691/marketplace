import 'package:cloud_firestore/cloud_firestore.dart';

class AppPlanModel{

  static const NAME = 'name';
  static const Features = 'Features';
  static const PRICE = 'price';







  String _name;
  List _features;
  int _price;


  get name => _name;
  get features => _features;
  get price => _price;


  AppPlanModel.fromSnapshot(DocumentSnapshot snapshot){
    _name = snapshot.data()[NAME];
    _features = snapshot.data()[Features];
    _price = snapshot.data()[PRICE];
  }
}


