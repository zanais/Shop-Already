import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopalready/widgets/vendedor_diseno_ordenes.dart';
import 'vendedor_drawer.dart';
//import '../../providers/orders.dart' show Orders;
import '../../providers/order_vendedor.dart' show OrdersVendedor;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VendedorHistorial extends StatefulWidget {
  static const routeName = "vendedor_historial";
  @override
  _VendedorHistorialState createState() => _VendedorHistorialState();
}

class _VendedorHistorialState extends State<VendedorHistorial> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat');
  var _isLoading = false;
  //String query = '';
  @override
  void initState() {
    _isLoading = true;

    Provider.of<OrdersVendedor>(context, listen: false)
        .fetchAndSetOrdersVendedor()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<OrdersVendedor>(context);
    //final nombre = Provider.of<ProductProvider>(context, listen: false);
    return new WillPopScope(
        onWillPop: () async => false,
        child: new Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context)!.ordenes,
              //AppLocalizations.of(context)!.carrito,
              style: style.copyWith(
                color: Colors.black,
              ),
            ),
            backgroundColor: Colors.teal[100],
            iconTheme: IconThemeData(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          drawer: MyDrawer("Ordenes"),
          body: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: ordersData.ordersVendedor.length,
                  itemBuilder: (ctx, i) =>
                      VendedorOrdenesItem(ordersData.ordersVendedor[i]),
                ),
        ));
  }
}
