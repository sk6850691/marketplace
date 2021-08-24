import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marketplace/models/AppPlanModel.dart';
import 'package:marketplace/models/BannerModel.dart';
import 'package:marketplace/models/CategoryModel.dart';
import 'package:marketplace/models/appmodel.dart';
import 'package:marketplace/models/hostingmodel.dart';
import 'package:marketplace/models/websitemodel.dart';

class FirebaseService{
FirebaseFirestore firestore = FirebaseFirestore.instance;


Future<List<AppModel>>getApps(){
  return firestore.collection('Apps').get().then((value) {
    List<AppModel> apps = [];
    for(DocumentSnapshot snapshot in  value.docs){
      apps.add(AppModel.fromSnapshot(snapshot));
    }
    return apps;
  });

}

Future<List<AppModel>>getAppsFromCategories(name){
  return firestore.collection('Apps').where('Category',isEqualTo: name).get().then((value) {
    List<AppModel> apps = [];
    for(DocumentSnapshot snapshot in  value.docs){
      apps.add(AppModel.fromSnapshot(snapshot));
    }
    return apps;
  });

}


Future<List<WebsiteModel>>getWebsiteFromCategories(name){
  return firestore.collection('WebsiteCategories').where('Category',isEqualTo: name).get().then((value) {
    List<WebsiteModel> websites = [];
    for(DocumentSnapshot snapshot in  value.docs){
      websites.add(WebsiteModel.fromSnapshot(snapshot));
    }
    return websites;
  });

}


Future<List<HostingModel>>getHostingFromCategories(name){
  return firestore.collection('HostingCategories').where('Category',isEqualTo: name).get().then((value) {
    List<HostingModel> hosting = [];
    for(DocumentSnapshot snapshot in  value.docs){
      hosting.add(HostingModel.fromSnapshot(snapshot));
    }
    return hosting;
  });

}




Future<List<AppPlanModel>>getAppPlans(){
  return firestore.collection('Plans').get().then((value) {
    List<AppPlanModel> appplans = [];
    for(DocumentSnapshot snapshot in  value.docs){
      appplans.add(AppPlanModel.fromSnapshot(snapshot));
    }
    return appplans;
  });

}

Future<List<AppPlanModel>>getWebsitePlans(){
  return firestore.collection('WebsitePlans').get().then((value) {
    List<AppPlanModel> websitePlans = [];
    for(DocumentSnapshot snapshot in  value.docs){
      websitePlans.add(AppPlanModel.fromSnapshot(snapshot));
    }
    return websitePlans;
  });

}

Future<List<AppPlanModel>>getHostingPlans(){
  return firestore.collection('HostingPlans').get().then((value) {
    List<AppPlanModel> hostingPlans = [];
    for(DocumentSnapshot snapshot in  value.docs){
      hostingPlans.add(AppPlanModel.fromSnapshot(snapshot));
    }
    return hostingPlans;
  });

}




Future<List<BannerModel>>getAppBanner(){
  return firestore.collection('Banners').where('description',isEqualTo: "AppBanner").get().then((value) {
    List<BannerModel> appbanners = [];
    for(DocumentSnapshot snapshot in  value.docs){
      appbanners.add(BannerModel.fromSnapshot(snapshot));
    }
    return appbanners;
  });

}

Future<List<BannerModel>>getWebsiteBanner(){
  return firestore.collection('Banners').where("description",isEqualTo: "websiteBanner").get().then((value) {
    List<BannerModel> websitebanners = [];
    for(DocumentSnapshot snapshot in  value.docs){
      websitebanners.add(BannerModel.fromSnapshot(snapshot));
    }
    return websitebanners;
  });

}
Future<List<BannerModel>>getHostingBanner(){
  return firestore.collection('Banners').where("description",isEqualTo: "hostingBanner").get().then((value) {
    List<BannerModel> hostingbanners = [];
    for(DocumentSnapshot snapshot in  value.docs){
      hostingbanners.add(BannerModel.fromSnapshot(snapshot));
    }
    return hostingbanners;
  });

}



Future<List<CategoryModel>>getCategories(){
  return firestore.collection('AppCategories').get().then((value) {
    List<CategoryModel> categories  = [];
    for(DocumentSnapshot snapshot in  value.docs){
      categories.add(CategoryModel.fromSnapshot(snapshot));
    }
    return categories;
  });

}

Future<List<CategoryModel>>getWebsitecategories(){
  return firestore.collection('WebsiteCategories').get().then((value) {
    List<CategoryModel> categories  = [];
    for(DocumentSnapshot snapshot in  value.docs){
      categories.add(CategoryModel.fromSnapshot(snapshot));
    }
    return categories;
  });

}


Future<List<CategoryModel>>getHostingCategories(){
  return firestore.collection('HostingCategories').get().then((value) {
    List<CategoryModel> hostingCategories  = [];
    for(DocumentSnapshot snapshot in  value.docs){
      hostingCategories.add(CategoryModel.fromSnapshot(snapshot));
    }
    return hostingCategories;
  });

}




Future<List<HostingModel>>getHosting()async{
  return await firestore.collection('Hosting').get().then((value) {
    List<HostingModel> hosting = [];
    for(DocumentSnapshot snapshot in  value.docs){
      hosting.add(HostingModel.fromSnapshot(snapshot));
    }
    return hosting;
  });

}

Future<List<WebsiteModel>>getWebsites()async {
  return await firestore.collection('Websites').get().then((value) {
    List<WebsiteModel> websites = [];
    for (DocumentSnapshot snapshot in value.docs) {
      websites.add(WebsiteModel.fromSnapshot(snapshot));
    }
    return websites;
  });
}


  String collections = "orders";


addToCart({ cartitem,userId})async{

  await firestore.collection('orders').doc().update({

    "cart":FieldValue.arrayUnion([cartitem])
  });


}



void createOrder(
    {Map cart, int price,String userid,String appIcon,String appName, }){



  firestore.collection(collections).doc().set(



      {"cart":cart,
        "price":price,
        "userId":userid,
        "image":appIcon,
        "appName":appName


      });}


}