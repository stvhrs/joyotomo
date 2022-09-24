import 'dart:io';
import 'package:bitsdojo_window_example/widgets/kop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class InvoiceDoc extends StatefulWidget {
  const InvoiceDoc({Key? key}) : super(key: key);
  @override
  State<InvoiceDoc> createState() => _InvoiceDocState();
}

class _InvoiceDocState extends State<InvoiceDoc> {
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
  Widget build(BuildContext context) {
   
    return Scaffold(
      floatingActionButton: Row(children: [
        const Spacer(),
        FloatingActionButton(
            child: const Text('Save PDF'),
            onPressed: () {
              buildPdf();
            }),
        FloatingActionButton(
            child: const Text('Print PDF'),
            onPressed: () async {
              await printPdf();
            })
      ]),
      body: Center(
        child: LayoutBuilder(builder: (context, BoxConstraints constraints) {
          return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(border: Border.all()),
              width: MediaQuery.of(context).size.height / 1.4,
              height: constraints.maxHeight,
              child: Column(children: [
              const Kop(),
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
