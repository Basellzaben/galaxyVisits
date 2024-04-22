import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LoadingWidget extends StatelessWidget {
  final bool isLoading;
  final String text;
  final Widget child;
  const LoadingWidget({Key? key, this.isLoading = false, required this.child, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        return !isLoading;
      },
      child: Stack(
        children: [
          child,
          if (isLoading)
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.black.withOpacity(.5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    "assets/loading.json",
                    width:MediaQuery.of(context).size.width * .35,
                    height:MediaQuery.of(context).size.height * .2,
                  ),
                  Text(
                   text ,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                        decoration: TextDecoration.none, // Remove underline

                    ),
                  )
                ],
              ),
            )
        ],
      ),
    );
  }
}