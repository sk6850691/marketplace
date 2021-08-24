import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:marketplace/providers/appprovider.dart';
import 'package:marketplace/services/firebaseservice.dart';
import 'package:marketplace/widgets/AppPlanWidget.dart';
import 'package:marketplace/widgets/changeColor.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as Path;
import 'dart:io';

import 'package:uuid/uuid.dart';
class WebsiteCartScreen extends StatefulWidget {
  final description;
  final int  price;
  final cartItem;

  const WebsiteCartScreen({Key key,this.cartItem,this.description,this.price}) : super(key: key);

  @override
  _WebsiteCartScreenState createState() => _WebsiteCartScreenState();
}

class _WebsiteCartScreenState extends State<WebsiteCartScreen> {

  Future<String>getDetails()async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.getString('uid');
  }

  Razorpay _razorpay;


  FirebaseService service = FirebaseService();
  String textfield = '';
  bool selected1 = false;
  bool selected2 = false;
  bool selected3 = false;
  double twenty = 0.2;
  String uid = '';
  String appname = '';
  File image;
  int Price = 0;
  String userId = '';
  String _downloadUrl = '';
  String uuid = Uuid().v4();


  uploadImage()async{

    await ImagePicker().getImage(source: ImageSource.gallery).then((result){
      setState(() {
        image = File(result.path);
      });
    });

    // FirebaseFirestore.instance.collection('orders').where(field).

  }void openCheckout(price) async {
    var options = {
      'key': 'rzp_live_nMM16kyBQikwGY',
      'amount': price,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '+917527910117', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };


    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  getUserId()async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    userId = prefs.getString('uid');
  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _paymentSuccess);
    getUserId();

  }
  _paymentSuccess(PaymentSuccessResponse response){

    if(response!=null) {
      service.createOrder(cart: widget.cartItem,appName:appname,price: Price,userid: userId,appIcon: _downloadUrl);
    }
  }



  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      floatingActionButton: MaterialButton(
        color: Colors.red,
        onPressed: (){



          showModalBottomSheet(
              context: context,
              builder: (context){
                return StatefulBuilder(builder: (BuildContext context,StateSetter setState){
                  return
                    Container(

                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Container(


                                  width: MediaQuery.of(context).size.width,
                                  child:



                                  ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: appProvider.appplans.length,
                                      itemBuilder: (context,index){
                                        return GestureDetector(
                                          onTap: (){


                                            openCheckout(appProvider.websitePlans[index].price);
                                            Price = appProvider.websitePlans[index].price;

                                            //  service.createOrder(cart: widget.cartItem,price:appProvider.appplans[index].price );
                                          },
                                          child: Column(

                                            children: [
                                              AppPlanWidget(appPlanModel: appProvider.websitePlans[index],)
                                            ],),
                                        );


                                        AppPlanWidget(appPlanModel: appProvider.appplans[index],);
                                      }

                                  ),



                                )],
                            )
                        )
                    );




                  /* Card(



                              child: ListView(

                                children: [

                                  Text('Choose a Hosting Plan'),
                                  Text('Apps are completely free you have to pay only for Hosting'),



                                  ChangeColor(

                                      listTile: ListTile(

                                        title: Text('1 month',style: GoogleFonts.lato(fontWeight: FontWeight.w600,color: Colors.white),),


                                        selected: selected1,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                        minLeadingWidth: MediaQuery.of(context).size.width,
                                        tileColor: Colors.grey.withOpacity(0.8),
                                        onTap: (){

                                          service.createOrder(cart: widget.cartItem);
                                          setState(() {
                                            selected1 = true;
                                            selected2 = false;
                                            selected3 = false;
                                            Price = 200 ;
                                          });
                                          print(Price);
                                        },
                                      )),
                                  ChangeColor(listTile:ListTile(
                                    tileColor:Colors.grey.withOpacity(0.8),
                                    title: Text('6 Months',style: GoogleFonts.lato(fontWeight: FontWeight.w600,color: Colors.white),),

                                    selected: selected2,
                                    onTap: (){
                                      setState(() {
                                        selected2 = true;
                                        selected1 = false;
                                        selected3 = false;
                                        Price = ( widget.price* twenty).toInt() ;

                                      });

                                    },
                                  )),

                                  ChangeColor(

                                      listTile: ListTile(

                                        tileColor:Colors.grey.withOpacity(0.8),

                                        title: Text('1 Year',style: GoogleFonts.lato(fontWeight: FontWeight.w600,color: Colors.white),),


                                        selected: selected3,
                                        onTap: (){
                                          setState(() {
                                            selected3 = true;
                                            selected1 = false;
                                            selected2 = false;

                                            Price = widget.price ;
                                          });

                                          print(Price);
                                        },
                                      )),

                                  SizedBox(
                                    height: 50,
                                  ),

                                  MaterialButton(onPressed:(){
                                    Navigator.pop(context);

                                    var options = {
                                      'key': 'rzp_live_nMM16kyBQikwGY',
                                      'amount': Price *100,
                                      'name': 'Acme Corp.',
                                      'description': 'Fine T-Shirt',
                                      'prefill': {'contact': '+917527910117', 'email': 'test@razorpay.com'},
                                      'external': {
                                        'wallets': ['paytm']
                                      }
                                    };


                                    try {
                                      _razorpay.open(options);
                                    } catch (e) {
                                      debugPrint('Error: e');
                                    }
                                  } ,
                                    color: Colors.red,

                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    minWidth: MediaQuery.of(context).size.width-20,
                                    height: 50,
                                    child: Text('Pay Now'),
                                  )



                                ],
                              ),
                            );*/
                });
              }

          );


        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
        child: Text('Place order'),
      ),
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            appProvider.signOut();
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.height,
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: [

              Text(widget.description,style: GoogleFonts.montserrat(fontSize: 25,fontWeight: FontWeight.w500),),

              Container(
                width: 10,
                height: 50,
                child: TextFormField(


                  decoration: InputDecoration(

                      hintText: 'Enter App Name'
                  ),
                  onChanged: (val){
                    setState(() {
                      appname = val;

                    });
                  },
                ),
              ),

              SizedBox(
                height: 20,
              ),

              ListTile(leading: Column(children: [

                Icon(Icons.image),
                GestureDetector(
                  onTap: (){

                    uploadImage();
                    Reference reference = FirebaseStorage.instance.ref().child('images/').child(uuid.toString());
                    UploadTask task = reference.putFile(image);
                    task.whenComplete(() {
                      reference.getDownloadURL().then((url){

                        setState(() {
                          _downloadUrl = url;
                          print(_downloadUrl);

                        });

                      });

                    });



                  },
                  child: Text('Pick Image'),

                )

              ],),

                  trailing: image!=null?Image.file(image,cacheHeight: 100,cacheWidth: 100,):null


              )],
          ),
        ),
      ),
    );
  }
}
