import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CustomDialog {
  static Future<bool?> showDoneDialog({
    required String title,
    required BuildContext context,
    String? content,
    final Widget? body,
    final String? doneButtonText,
    final VoidCallback? onDonePressed,
    bool barrierDismissible = true,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 8.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    // color: ColorTheme(context),
                    width: 2.0,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      // style: TextFormFieldColor(context),
                    ),
                    const SizedBox(height: 35.0),
                    body ??
                        Text(content ?? 'content',
                            // style: TextFormFieldColor(context)
                            ),
                    const SizedBox(height: 35.0),
                  ],
                ),
              ),
              const SizedBox(height: 4.0),
              MaterialButton(
                minWidth: double.infinity,
                padding: const EdgeInsets.all(12.0),
                // color: ColorTheme(context),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(12.0),
                  ),
                ),
                onPressed: () {
                  onDonePressed?.call();
                },
                child: Text(
                  doneButtonText ?? 'done',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<bool?> showYesNoDialog({
    required BuildContext context,
    required String title,
    required String content,
    required BlendMode blendMode,
    IconData? icons,
    Color? iconsColor,
    required String yesButtonText,
    Color? yesbuttoncolorbackground,
    Color? nobuttoncolorbackground,
    required String noButtonText,
    VoidCallback? onYesPressed,
    VoidCallback? onNoPressed,
    Color? yesButtonColortext,
    Color? noButtonColortext,
    String Lottiepath = "",
    bool barrierDismissible = true,
    double? heightlottei =150,
    double? widthlottei =150,
    Color? colorlottei,
    BoxFit? fit,
    Widget? body,
  }) async {
    // var LanguageProvider = Provider.of<Language>(context, listen: false);
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return await showDialog<bool>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) => AlertDialog(
         titlePadding: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
          title: Column(
            children: [
              Container(
                      width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 8.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                
                // color: ColorTheme(context),
                width: 2.0,
        
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12.0),
                bottomRight: Radius.circular(12.0),
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
            ),
                      child: Column(
                        children: [
                          Lottiepath != ""
                  ? colorlottei !=null ?ColorFiltered(
                    colorFilter: ColorFilter.mode(colorlottei , blendMode),
                    child: Lottie.asset(Lottiepath,
                                height: heightlottei, width: widthlottei, fit: fit,
                              
                                ),
                  ):Lottie.asset(Lottiepath,
                                height: heightlottei, width: widthlottei, fit: fit,
                              
                                )
                          : SizedBox(),
                                Text(
                title,
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 8.0),
              body ??
                  Text(
                    content,
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
              const SizedBox(height: 10.0),
                        ],
                      ))
        ,                  const SizedBox(height: 4.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 MaterialButton(
            padding: const EdgeInsets.all(12.0),
            color: nobuttoncolorbackground,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(12.0),
              ),
            ),
                    onPressed: () {
                      Navigator.of(context).pop;
                      onNoPressed?.call();
                    },
                    child: Text(
                      noButtonText,
                      style:TextStyle(
                            color: noButtonColortext ?? Colors.white,
                            fontSize: 18.0,
        
                      )
                    ),
                  ),
                  const SizedBox(width: 15.0),
                  MaterialButton(
            padding: const EdgeInsets.all(12.0),
            color: yesbuttoncolorbackground,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(12.0),
              ),
            ),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                      onYesPressed?.call();
                    },
                    child: Text(
                      yesButtonText,
                     style:TextStyle(
                            color: yesButtonColortext ?? Colors.white,
                            fontSize: 18.0,
                            
                      )
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

}