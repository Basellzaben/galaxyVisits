
import 'package:flutter/material.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
//nbnbnbnmbnn




class ImageDialog extends StatefulWidget {
  const ImageDialog({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LogoutOverlayStatecard();
}

class LogoutOverlayStatecard extends State<ImageDialog>
    with SingleTickerProviderStateMixin {
   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  

  }

  @override
  Widget build(BuildContext context) {
return Center(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        body: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Image.network("http://"+Globalvireables.connectIP+""+Globalvireables.imageselected))
      ),
    );
  }


}


///////////////////////////////////////////////////////////////////////////////

