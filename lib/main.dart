//import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:idepronet/src/models/user.dart';
import 'package:idepronet/src/pages/home/Inicio/menu_principal.dart';
import 'package:idepronet/src/pages/login/auth/login_page.dart';
import 'package:idepronet/src/pages/login/updateUser/user_update_page.dart';
import 'package:idepronet/src/pages/negocio/Formulario/F01_credito_rechazado/create/credito_rechazado_create_controler.dart';
import 'package:idepronet/src/pages/negocio/Formulario/F01_credito_rechazado/create/credito_rechazado_create_page.dart';
import 'package:idepronet/src/pages/negocio/Formulario/F01_credito_rechazado/list/credito_rechazado_list_page.dart';
import 'package:idepronet/src/pages/register/register_page.dart';
import 'package:idepronet/src/pages/roles/roles_page.dart';
import 'package:idepronet/src/utils/my_colors.dart';
import 'package:idepronet/src/pages/login/auth/login_page.dart';
import 'package:idepronet/src/pages/register/register_page.dart';

import 'package:idepronet/src/pages/roles/roles_page.dart';
//import 'package:idepronet/src/provider/push_notifications_provider.dart';
import 'package:idepronet/src/utils/my_colors.dart';
import 'package:idepronet/src/utils/shared_pref.dart';

import 'src/pages/home/Inicio/RoomDetails.dart';





//PushNotificationsProvider pushNotificationsProvider = new PushNotificationsProvider();


// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();
//   print('Handling a background message ${message.messageId}');
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
 // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
 // pushNotificationsProvider.initPushNotifications();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  //  pushNotificationsProvider.onMessageListener();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Idepro',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      initialRoute: 'login/auth',
      routes: {
        'login/auth' : (BuildContext context) => LoginPage(),
        'login/updateUser' : (BuildContext context) => UserUpdatePage(),
        'register' : (BuildContext context) => RegisterPage(),
        'roles' : (BuildContext context) => RolesPage(),
        'negocio/formulario/F01_credito_rechazado/create' : (BuildContext context) => CreditoRechazadoCreatePage(),
        'negocio/formulario/F01_credito_rechazado/list' : (BuildContext context) => CreditoRechazadoListPage(),
       // 'home/inicio' : (BuildContext context) => MenuPrincipalPage(),
        'home/inicio' : (BuildContext context) => RoomDetails(
          roomName: 'BIENVENIDO',
          members: ' Formularios Asignados ',
        )
      },
      theme: ThemeData(
        // fontFamily: 'NimbusSans',
          primaryColor: MyColors.primaryColor,
          appBarTheme: AppBarTheme(elevation: 0)
      ),
    );
  }
}
