import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:galaxyvisits/GlobalVaribales.dart';
import 'package:galaxyvisits/ViewModel/CustomerViewModel.dart';
import 'package:galaxyvisits/ViewModel/GlobalViewModel/HomeViewModel.dart';
import 'package:galaxyvisits/ViewModel/LoginViewModel.dart';
import 'package:galaxyvisits/ViewModel/VisitDetailViewModel.dart';
import 'package:galaxyvisits/ViewModel/VisitViewModel.dart';
import 'package:galaxyvisits/color/HexColor.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'Ui/Login/Login_Body.dart';
import 'ViewModel/SalesManViewModel.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (details) {
    FlutterError.dumpErrorToConsole(details);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    debugPrint('Uncaught error: $error\n$stack');
    return true; // لا يخرج التطبيق بصمت
  };

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()..startTimer()),
        ChangeNotifierProvider(
            create: (_) => CustomerViewModel()..startTimer()),
        ChangeNotifierProvider(create: (_) => VisitViewModel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => SalesManViewModel()),
        ChangeNotifierProvider(create: (_) => VisitDetailViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('en', 'US'),
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('ar', 'SA'), // Arabic
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      title: 'Galaxy Visits',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    try {
      final position = await _getLocationSafe();

      if (!mounted) return;
      final home = context.read<HomeViewModel>();
      final customers = context.read<CustomerViewModel>();
      home.setData(position.latitude.toString(), position.longitude.toString());
      customers.setdata(
          position.latitude.toString(), position.longitude.toString());
    } catch (e, st) {
      debugPrint('Location init failed: $e\n$st');
      // ممكن تعرض Toast أو تتجاهل وتكمل للّوجن
    } finally {
      // انتقل بعد 2-3 ثواني بدون كراش
      await Future.delayed(const Duration(seconds: 3));
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => Login_Body()),
      );
    }
  }

  Future<Position> _getLocationSafe() async {
    // تأكد من تفعيل الخدمة
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // بإمكانك فتح الإعدادات: await Geolocator.openLocationSettings();
      throw Exception('Location services are disabled.');
    }

    // تحقق من الإذونات
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      throw Exception('Location permission not granted.');
    }

    return Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    // ملاحظة: في بعض الأجهزة يلزم timeout:
    // return Geolocator.getCurrentPosition(timeLimit: const Duration(seconds: 10));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(Globalvireables.basecolor),
      body: Container(
        color: HexColor(Globalvireables.basecolor),
        margin: const EdgeInsets.only(top: 200),
        child: Column(
          children: [
            Center(
              child: Image.asset('assets/logo2.png', height: 250, width: 250),
            ),
            const Spacer(),
            Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(bottom: 16),
              child: Text(
                "Powered By galaxy International Group",
                style: TextStyle(
                  color: HexColor(Globalvireables.white),
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
