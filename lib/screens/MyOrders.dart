import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MyOrders extends StatefulWidget {
  const MyOrders({Key key}) : super(key: key);

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  String userId = '';

  getuserID()async{
    SharedPreferences prefs =await SharedPreferences.getInstance();
    userId = prefs.get('uid');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserID();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Bookings',style: GoogleFonts.lato(fontSize: 30),),
      ),
      body: SingleChildScrollView(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('orders').where('userId',isEqualTo: userId).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              return Container(
                height: MediaQuery.of(context).size.height,
                width: 600,
                child: new ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data()['cart'] as Map<String, dynamic>;
                    return Card(


                        child: Padding(
                          padding: EdgeInsets.only(left: 10,right: 10) ,

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [


                              Text('OrderId'+'  '+data['id'].toString(),style: GoogleFonts.lato(fontSize: 20,fontWeight: FontWeight.w900),),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Price'+''+data['price'].toString(),style: GoogleFonts.lato(fontSize: 20,fontWeight: FontWeight.w900),),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Quantity'+''+data['quantity'].toString(),style: GoogleFonts.lato(fontSize: 10,fontWeight: FontWeight.w900),),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Location'+''+data['location'].toString(),style: GoogleFonts.lato(fontSize: 10,fontWeight: FontWeight.w900),),
                              SizedBox(height: 30,)

                            ],

                          ),
                        ));
                  }).toList(),
                ),
              );
            },
          )
      ),
    );
  }
}
