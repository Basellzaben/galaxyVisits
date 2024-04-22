// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:galaxyvisits/color/HexColor.dart';

class CustomUserAccountsDrawerHeader extends StatefulWidget {
  const CustomUserAccountsDrawerHeader({
    Key? key,
  }) : super(key: key); 

  @override
  State<CustomUserAccountsDrawerHeader> createState() =>
      _CustomUserAccountsDrawerHeaderState();
}

class _CustomUserAccountsDrawerHeaderState
    extends State<CustomUserAccountsDrawerHeader> {

  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      decoration: 
       BoxDecoration(
        color:HexColor(Globalvireables.basecolor),
        image: const DecorationImage(
          image: AssetImage('assets/logo2.png'),
          fit: BoxFit.fitWidth,
        ),
      ),
      accountEmail: Text(
        Globalvireables.email,
        style: const TextStyle(color: Colors.white),
      ),
      accountName:Text(
          Globalvireables.username,
              style: const TextStyle(color: Colors.white),
            ),
      
      
    
    
         
      
      
    );
  }
}
