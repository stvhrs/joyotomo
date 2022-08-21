import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({Key? key}) : super(key: key);
  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  String defaul = 'Masih Kosong';

  var asu = pw.Document();

  buildPdf() async {
    double base = 1000;
    var img = (await rootBundle.load('images/logo.png')).buffer.asUint8List();
    asu.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: ((pw.Context context) => pw.Center(
            child: pw.Container(
                height: base * 1.4,
                width: base,
                child: pw.Column(children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.SizedBox(
                          child: pw.Image(pw.MemoryImage(img), width: 80)),
                      pw.Column(
                        children: [
                          pw.Text(
                            textAlign: pw.TextAlign.justify,
                            'JOYOTOMO',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 23,
                                fontStyle: pw.FontStyle.italic),
                          ),
                          pw.Text(
                            textAlign: pw.TextAlign.justify,
                            'Gemolong, Gandurejo, 4567',
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.Text(defaul)
                ]))))));
    final file = File("D:/$defaul.pdf");
    await file.writeAsBytes(await asu.save());
  }

  printPdf() async {
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => asu.save());
  }

  @override
  void didChangeDependencies() {
    log('didi');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    log('sss');
    return Scaffold(
      floatingActionButton: Container(
        child: Row(children: [
          Spacer(),
          FloatingActionButton(
              child: Text('Save PDF'),
              onPressed: () {
                buildPdf();
              }),
          FloatingActionButton(
              child: Text('Print PDF'),
              onPressed: () async {
                await printPdf();
              })
        ]),
      ),
      body: Center(
        child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
          return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(border: Border.all()),
              width: constraints.maxHeight / 1.4,
              height: constraints.maxHeight,
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'images/logo.png',
                      width: 80,
                    ),
                    Container(
                      width: 300,
                      child: Column(
                        children: [
                          Text(
                            textAlign: TextAlign.justify,
                            'JOYOTOMO',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                                fontStyle: FontStyle.italic),
                          ),
                          Text(
                            textAlign: TextAlign.justify,
                            'Gemolong, Gandurejo, 4567',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            textAlign: TextAlign.justify,
                            'TELP:08578181929    FAX:10283211',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  initialValue: defaul,
                  onChanged: (value) {
                    setState(() {
                      defaul = value.toString();
                    });
                  },
                )
              ]));
        }),
      ),
    );
  }
}
