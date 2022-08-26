import 'dart:convert';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:bitsdojo_window_example/pages/invoice_page.dart';
import 'package:bitsdojo_window_example/pages/stock_page.dart';
import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';

import 'main.dart';

import 'models/stock.dart';


final buttonColors = WindowButtonColors(
    iconNormal: const Color.fromARGB(255, 79, 117, 134),
    mouseOver: Colors.teal,
    mouseDown: const Color.fromARGB(255, 79, 117, 134),
    iconMouseOver: Colors.white,
    iconMouseDown: const Color(0xFFFFD500));

final closeButtonColors = WindowButtonColors(
    mouseOver: const Color(0xFFD32F2F),
    mouseDown: const Color(0xFFB71C1C),
    iconNormal: const Color.fromARGB(255, 79, 117, 134),
    iconMouseOver: Colors.white);

class WindowButtons extends StatefulWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  _WindowButtonsState createState() => _WindowButtonsState();
}

class _WindowButtonsState extends State<WindowButtons> {
  void maximizeOrRestore() {
    setState(() {
      appWindow.maximizeOrRestore();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      color: Colors.grey.shade900,
      child: Row(
        children: [
          MinimizeWindowButton(colors: buttonColors),
          appWindow.isMaximized
              ? RestoreWindowButton(
                  colors: buttonColors,
                  onPressed: maximizeOrRestore,
                )
              : MaximizeWindowButton(
                  colors: buttonColors,
                  onPressed: maximizeOrRestore,
                ),
          CloseWindowButton(colors: closeButtonColors),
        ],
      ),
    );
  }
}

class Side extends StatefulWidget {
  const Side({
    Key? key,
  }) : super(key: key);

  @override
  _SideState createState() => _SideState();
}

bool mode = false;

class _SideState extends State<Side> {
  PageController page = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final user = Stock(
              count: 15,
              desc: 'Footstep bisa untuk CS1, VARIO 2010, SUPRA GTR',
              name: 'Footstep 50mm',
              partname: 'DOLKD1-12D-2DS',
              totalPrice: 30000,
              stockHistory: json.encode([
             {
                  'date': DateTime.now().toIso8601String(),
                  'price': 15000,
                  'count': -1,
                  'supplier': 'Di Colong Tikus',
                },   {
                  'date': DateTime.now().toIso8601String(),
                  'price': -12500,
                  'count': 9,
                  'supplier': 'Lestari Jaya',
                },
          
              ]));

          for (var i = 0; i < 1000; i++) {
                            user.name = '$i';
                             user.partname = 'P$i';
                            user.id = i;
                            objectBox.insertStock(user);
                          }
                          //  objectBox.insertStock(stock);
                        //  objectBox.deleteAllStock();
                        //  Navigator.of(context).pop();
          //  objectBox.deleteAllStock();
        },
      ),
      body: WindowBorder(
        color: const Color.fromARGB(255, 79, 117, 134),
        child: Column(
          children: [
            WindowTitleBarBox(
              child: Row(
                children: [
                  Container(
                      padding: const EdgeInsets.only(left: 15),
                      color: Colors.grey.shade900,
                      child: const Text(
                        'JOYOTOMO',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                            fontStyle: FontStyle.italic),
                      )),
                  Expanded(
                      child: MoveWindow(
                    child: Container(
                      color: Colors.grey.shade900,
                    ),
                  )),
                  const WindowButtons()
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SideMenu(
                    controller: page, showToggle: true,
                    // onDisplayModeChanged: (mode) {
                    //   print(mode);
                    // },
                    style: SideMenuStyle(toggleColor: Colors.white,
                      displayMode: mode
                          ? SideMenuDisplayMode.open
                          : SideMenuDisplayMode.compact,
                      hoverColor: const Color.fromARGB(255, 128, 129, 131),
                      selectedColor: Colors.grey.shade700,
                      selectedTitleTextStyle:
                          const TextStyle(color: Colors.white),
                      selectedIconColor: Colors.white,
                      unselectedIconColor: Colors.white70,
                      unselectedTitleTextStyle:
                          const TextStyle(color: Colors.white70),

                      backgroundColor: const Color.fromARGB(255, 79, 117, 134),
                      // openSideMenuWidth: 200
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 100,
                            maxWidth: 150,
                          ),
                          child: Image.asset(
                            'images/logo2.png',
                          ),
                        ),
                        const Divider(
                          indent: 8.0,
                          endIndent: 8.0,
                        ),
                      ],
                    ),
                    footer: const Text(
                      '@JOYOTOMO',
                      style: TextStyle(fontSize: 15),
                    ),
                    items: [
                      SideMenuItem(
                        priority: 0,
                        title: 'Stock',
                        onTap: () {
                          page.jumpToPage(0);
                        },
                        icon: const Icon(Icons.menu_book_rounded),
                      ),
                      SideMenuItem(
                        priority: 1,
                        title: 'Supplier',
                        onTap: () {
                          page.jumpToPage(1);
                        },
                        icon: const Icon(Icons.engineering_rounded),
                      ),
                      SideMenuItem(
                        priority: 2,
                        title: 'Surat Tugas',
                        onTap: () {
                          page.jumpToPage(2);
                        },
                        icon: const Icon(Icons.engineering_rounded),
                      ),
                      SideMenuItem(
                        priority: 3,
                        title: 'Multi Selection',
                        onTap: () {
                          page.jumpToPage(3);
                        },
                        icon: const Icon(Icons.menu_book_rounded),
                      ),
                      SideMenuItem(
                        priority: 4,
                        title: 'Repair',
                        onTap: () {
                          page.jumpToPage(4);
                        },
                        icon: const Icon(Icons.menu_book_rounded),
                      ),
                      SideMenuItem(
                        priority: 5,
                        title: 'Invoice',
                        onTap: () {
                          page.jumpToPage(5);
                        },
                        icon: const Icon(Icons.document_scanner_rounded),

                        // tooltipContent: "Home",
                      ),
                      // SideMenuItem(
                      //   priority: 6,
                      //   title: '',
                      //   onTap: () {
                      //     setState(() {
                      //       mode = !mode;
                      //     });
                      //   },
                      //   icon: const Icon(Icons.arrow_back_ios_new),

                      //   // tooltipContent: "Home",
                      // ),
                    ],
                  ),
                  Expanded(
                    child: PageView(
                      controller: page,
                      children: [
                        Container( child: const StockPage()),
                        Container(
                          color: Colors.white,
                          child: const Center(
                            child: Text(
                              'Multi',
                              style: TextStyle(fontSize: 35),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: const Center(
                            child: Text(
                              'Hidden Page',
                              style: TextStyle(fontSize: 35),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: const Center(
                            child: Text(
                              'Hidden Page',
                              style: TextStyle(fontSize: 35),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: const Center(
                            child: Text(
                              'Hidden Page',
                              style: TextStyle(fontSize: 35),
                            ),
                          ),
                        ),
                        const InvoicePage(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
