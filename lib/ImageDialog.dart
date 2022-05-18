import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:http/http.dart' as http;
//nbnbnbnmbnn
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'dart:io' as io;

class ImageDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LogoutOverlayStatecard();
}

class LogoutOverlayStatecard extends State<ImageDialog>
    with SingleTickerProviderStateMixin {
   GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
return Center(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        body: Container(
         child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Image.network("http://10.0.1.60:5323"+Globalvireables.imageselected))
        )
      ),
    );
  }


}


///////////////////////////////////////////////////////////////////////////////

