import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pullman_mobile_app/Home/controller/emirate_id_controller.dart';
import 'package:pullman_mobile_app/Home/screen/home_screen.dart';
import 'package:pullman_mobile_app/Home/screen/pdf_generater_pdf_screen.dart';
import 'package:pullman_mobile_app/Home/screen/spalsh_screen.dart';
import 'package:pullman_mobile_app/const/app_typography.dart';
import 'package:pullman_mobile_app/const/dailog_widgets.dart';
import 'package:pullman_mobile_app/const/router/routes.dart';
import 'package:pullman_mobile_app/const/space_helpper.dart';
import 'package:pullman_mobile_app/housekeeper/controller/task_controller.dart';
import 'package:provider/provider.dart';


// import 'package:signature/signature.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AppText.init();
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        // DeviceOrientation.portraitDown,
      ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => EIDScannerProvider()),
                ChangeNotifierProvider(create: (_) => TaskController()),

      ],
      child: MaterialApp(debugShowCheckedModeBanner: false,
      
        
        home:  SplashScreen(),       
        navigatorKey: Routes.navigatorKey,
        scaffoldMessengerKey: AppDialogBoxes.rootScaffoldMessengerKey,

      ),
    );
  }
}


