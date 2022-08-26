// Don't forget to make the changes mentioned in
// https://github.com/bitsdojo/bitsdojo_window#getting-started

import 'package:bitsdojo_window_example/provider/triger.dart';
import 'package:bitsdojo_window_example/sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'models/obejct.dart';

late ObjectBox objectBox;
void main() async{ 
 objectBox = await ObjectBox.init();
  runApp( MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Trigger()),
     
      ],
      child: const MyApp(),
    ),);initializeDateFormatting();
  doWhenWindowReady(() {
    final win = appWindow;
    const initialSize = Size(1366 , 768);
    win.minSize = initialSize;
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = "JoyoTomo";
    win.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Side(
          
        ));
  }
}
