// ignore_for_file: use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:galaxyvisits/color/HexColor.dart';

import '../../GlobalVaribales.dart';

class NavDrawer extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(

            child: const Text(
              'Galaxy group systems',
              style: TextStyle(color: Colors.white, fontSize: 25,fontWeight: FontWeight.w300),
            ),
            decoration: BoxDecoration(
                color: HexColor(Globalvireables.basecolor),
                image: const DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/draw.jpg'))),
          ),
          //https://play.google.com/store/apps/details?id=com.baselalzaben99.myapplicationmaps&hl=ar&gl=US
          ListTile(

            leading: const Icon(Icons.share,color: Colors.lightGreen,),
            title: Container(child: const Text("تحديث البيانات")),
            onTap: () => {

            /*  Share.share( "https://play.google.com/store/apps/details?id=com.galaxyinternational.cards&hl=ar&gl=US", subject:''),
              //  Share.share('https://play.google.com/store/apps/details?id=com.baselalzaben99.myapplicationmaps&hl=ar&gl=US', subject: 'Look what I made!')
*/
            },
          ),
          /*        ListTile(
            leading: Icon(Icons.verified_user),
            title: Container(alignment:LanguageProvider.Align(),child: Text(LanguageProvider.getTexts('profile').toString())),

            onTap: () => {

            Navigator.push(context,
            MaterialPageRoute(builder:
            (context) =>
            Body_profile()
            )
            )


          },
          )*/

          /*ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Container(alignment:LanguageProvider.Align(),child: Text(LanguageProvider.getTexts('logout').toString())),

            onTap: () async => {
              SystemChannels.platform.invokeMethod('SystemNavigator.pop')

*//*
     prefs = await SharedPreferences.getInstance(),

    prefs.setString("Login","0"),


    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Login_Body()),)
*//*

            },
          ),
          ListTile(
              leading: Icon(Icons.settings),
              title: Container(alignment:LanguageProvider.Align(),child: Container(margin: EdgeInsets.only(left: 10,right: 10),child: Text(LanguageProvider.getTexts('setting').toString()))),

              onTap: () async => {
                Navigator.push(context,
                    MaterialPageRoute(builder:
                        (context) =>
                        Setting_Home()
                    ))}),

*/


          Container(
            height: 280,
            alignment: Alignment.bottomCenter,
            child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text("version 1.0 - 2021",style: TextStyle(color: Colors.black26,fontWeight: FontWeight.w300),)),
          ),

        ],
      ),
    );
  }
}