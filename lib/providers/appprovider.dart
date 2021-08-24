import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:marketplace/models/AppPlanModel.dart';
import 'package:marketplace/models/BannerModel.dart';
import 'package:marketplace/models/CategoryModel.dart';
import 'package:marketplace/models/appmodel.dart';
import 'package:marketplace/models/hostingmodel.dart';
import 'package:marketplace/models/websitemodel.dart';
import 'package:marketplace/services/firebaseservice.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
enum Status{Uninitialised,Unauthenticated, Authenticated,Authenticating}
class AppProvider with ChangeNotifier{


  FirebaseService service = FirebaseService();
  User user ;
  List<AppModel> apps = [];
  List<HostingModel> hosting = [];
  Status status = Status.Unauthenticated;
  List<WebsiteModel> websites = [];
  List<CategoryModel> categories = [];
  List<CategoryModel> websiteCategories = [];
  List<CategoryModel> hostingCategories = [];
  List<AppPlanModel> appplans = [];
  List<BannerModel> appBanners = [];
  List<BannerModel> websiteBanners = [];
  List<BannerModel> hostingBanners = [];
  List<AppPlanModel> websitePlans = [];
  List<AppPlanModel> hostingPlans = [];
  List<AppModel> appcategories = [];
  List<HostingModel> hostingfromcategories = [];
  List<WebsiteModel> websitefromCategories = [];
  Map cartitem;
  FirebaseAuth auth = FirebaseAuth.instance;
  String cartItemId = Uuid().v4().substring(0,5);

  AppProvider.initialize():auth = FirebaseAuth.instance{
    auth.authStateChanges().listen(onAuthStateChanged);

    getapps();
    getHosting();
    getWebsite();
    getCategories();
    getAppPlans();
    getAppBAnner();
    getHostingBanners();
    getWebsiteBanners();
    getWebsitePlans();
    getHostingPlans();
    getWebsiteCategories();
    getHostingCategories();

  }

  onAuthStateChanged(User user){

    if(user==null){
      status = Status.Unauthenticated;
      notifyListeners();
    }else{
      user = user;
      status = Status.Authenticated;
      notifyListeners();
    }


  }

  void signOut(){

    auth.signOut();
    status = Status.Unauthenticated;
  }


  void savedetails({value})async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('uid', value.toString() );

  }
  Future<String>getDetails()async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.getString('uid');
  }

  getCategories()async{
    categories = await service.getCategories();
    notifyListeners();
  }

  getWebsiteCategories()async{
    websiteCategories= await service.getWebsitecategories();
    notifyListeners();
  }

  getHostingCategories()async{
    hostingCategories = await service.getHostingCategories();
    notifyListeners();
  }


  getapps()async{
    apps = await service.getApps();
    notifyListeners();


  }

  getAppsFromCategories({String name})async{
    appcategories = await service.getAppsFromCategories(name);
    notifyListeners();

  }

  getHostingFromCategories({String name})async{
    hostingfromcategories = await service.getHostingFromCategories(name);
    notifyListeners();

}

getWebsitesFromCategories({String name})async{
    websitefromCategories = await service.getWebsiteFromCategories(name);
    notifyListeners();
}
  getWebsite()async{
    websites = await service.getWebsites();
  }

  getAppBAnner()async{
    appBanners = await service.getAppBanner();
  }
  getWebsiteBanners()async{

    websiteBanners = await service.getWebsiteBanner();
    notifyListeners();
  }

  getHostingBanners()async{
    hostingBanners = await service.getHostingBanner();
  }


  addAppToCart({AppModel appModel}){

    cartitem = {




     "description":appModel.description,



      "id": cartItemId,
    };
    service.addToCart(userId:getDetails(),cartitem: cartitem);
  }
  addWebsiteToCart({WebsiteModel websiteModel}){

    cartitem = {



      "price": websiteModel.price,
      "id": cartItemId,
    };
    service.addToCart(userId:getDetails(),cartitem: cartitem);
  }

  addHostingToToCart({HostingModel hostingModel}){

    cartitem = {



      "price": hostingModel.price,
      "id": cartItemId,
      "description":hostingModel.description.toString()
    };

  }



  getHosting()async{
    hosting = await service.getHosting();
    notifyListeners();


  }
  getAppPlans()async{
    appplans = await service.getAppPlans();
    notifyListeners();


  }
  getWebsitePlans()async{
    websitePlans = await service.getWebsitePlans();
    notifyListeners();


  }
  getHostingPlans()async{
    hostingPlans = await service.getHostingPlans();
    notifyListeners();


  }

  Future<UserCredential> signInWithGoogle()async{
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,

    );

    // ignore: missing_return
    return await auth.signInWithCredential(credential).then((value) {
      savedetails(value: value.user.uid);
      FirebaseFirestore.instance.collection('users').doc(value.user.uid).set({
        "id":value.user.uid,
        "name":value.user.displayName,
        "email":value.user.email


      });
    });

  }


}