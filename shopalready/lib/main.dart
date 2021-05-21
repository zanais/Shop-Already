import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shopalready/providers/order_vendedor.dart';
import 'package:shopalready/providers/products_provider.dart';
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
import 'package:provider/provider.dart';
import './providers/auth.dart';
import 'providers/cart.dart';
import 'providers/orders.dart';
import 'screens/vendedor/vendedor_historial.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProxyProvider<Auth, ProductProvider>(
          create: (_) => ProductProvider('', []),
          update: (ctx, auth, previousProducts) => ProductProvider(
            auth.token,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (ctx) => Orders('', '', []),
          update: (ctx, auth, previousOrders) => Orders(
            auth.token,
            auth.userId,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, OrdersVendedor>(
            create: (ctx) => OrdersVendedor('', '', []),
            update: (ctx, auth, previousOrdersVendedor) => OrdersVendedor(
                  auth.token,
                  auth.userId,
                  previousOrdersVendedor == null
                      ? []
                      : previousOrdersVendedor.ordersVendedor,
                ))
      ],
      child: MaterialApp(
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
          VendedorHistorial.routeName: (ctx) => VendedorHistorial(),
        },
      )
      //home: TiposDeUsuarios(),
      ,
    );
  }
}
