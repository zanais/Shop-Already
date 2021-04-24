import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//import 'package:shopalready/product.dart';
import './screens/cliente/carrito.dart';
import './screens/cliente/historial.dart';
import './screens/cliente/productos.dart';
import 'package:shopalready/login/login.dart';
import 'package:shopalready/login/recuperar.dart';
import 'package:shopalready/login/registrado.dart';
import 'package:shopalready/login/registro.dart';
import 'package:shopalready/login/renuevo.dart';
import './screens/tipos_usuarios.dart';
import './screens/vendedor/vendedor_productos.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  static void cambiarIdioma(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setState(() {
      state.myLocale = newLocale;
    });
  }

  static void setLocale(BuildContext context, Locale locale) {}
}

class _MyAppState extends State<MyApp> {
  Locale myLocale = Locale('es', '');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: myLocale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      title: 'Shop Already',
      initialRoute: '/',
      routes: {
        Login.routeName: (ctx) => Login(),
        '/': (ctx) => TiposDeUsuarios(),
        Carrito.routeName: (ctx) => Carrito(),
        Productos.routeName: (ctx) => Productos(),
        Historial.routeName: (ctx) => Historial(),
        Recuperar.routeName: (ctx) => Recuperar(),
        Registrado.routeName: (ctx) => Registrado(),
        Registro.routeName: (ctx) => Registro(),
        VendedorProductos.routeName: (ctx) => VendedorProductos(),
        Renuevo.routeName: (ctx) => Renuevo(),
      },

      //home: TiposDeUsuarios(),
    );
  }
}
