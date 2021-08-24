
import 'package:custom_clippers/Clippers/directional_wave_clipper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketplace/providers/appprovider.dart';

import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';


import 'HomeScreen.dart';
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  RoundedLoadingButtonController controller1 = RoundedLoadingButtonController();
  RoundedLoadingButtonController controller2 = RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return Scaffold(

      body: Column(
          children:[

            Container(
              //width: MediaQuery.of(context).size.width,
             // height: MediaQuery.of(context).size.height-300,

              child: ClipPath(


                clipper: DirectionalWaveClipper(

                ),
                child: Image.network('https://1z1euk35x7oy36s8we4dr6lo-wpengine.netdna-ssl.com/wp-content/uploads/2020/08/zymr8_steps_the_mobile_app_dev_lifecycle_cover.jpg',fit: BoxFit.fitHeight,),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text('Welcome To AppGun ',style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,fontSize: 25),),

            SizedBox(height: 50,),

            RoundedLoadingButton(

              color: Colors.redAccent[700],
              child: Text('Login With Google'),
              controller: controller1 ,
              onPressed: (){
                appProvider.signInWithGoogle().then((value) {
                  controller1.success();
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreen()));
                });
              },
            ),
            SizedBox(
              height: 10,
            ),

          /*  RoundedLoadingButton(
                controller: controller2,
                color: Colors.redAccent[700],



                child: Text('Login with Phone'),
                onPressed: (){
                //  Navigator.push(context,MaterialPageRoute(builder: (context)=>enterphonenumber()));
                })*/
          ]),
    );

  }
}
