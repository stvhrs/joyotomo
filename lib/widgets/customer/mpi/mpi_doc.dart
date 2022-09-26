import 'package:bitsdojo_window_example/helper/sparated_column.dart';
import 'package:bitsdojo_window_example/models/mpi/mpiItem.dart';
import 'package:bitsdojo_window_example/widgets/kop.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import '../../../models/customer.dart';

class MpiDoc extends StatelessWidget {
  final Customer customer;
  const MpiDoc({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    List<MpiItem> data = customer.mpi.target!.items;
    print(data.length);
    return Scaffold(
        body: LayoutBuilder(builder: (context, BoxConstraints constraints) {
      return Center(
        child: Container(
            decoration: BoxDecoration(border: Border.all()),
            width: constraints.maxHeight / 1.4,
            height: constraints.maxHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Kop(),
             Container(
                          width: constraints.maxHeight / 1.4 / 3,
                          decoration: const BoxDecoration(
                            border: Border(top: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                              bottom: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                              right: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ),
                          padding: const EdgeInsets.all(4),
                          child: Text('BRAKES - TIRES - ALIGNMENT',style: const TextStyle(
                                  fontSize: 9, fontWeight: FontWeight.bold)),
                        ),
                SeparatedColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    separatorBuilder: (context, index) {
                      if (data[index].category != data[index + 1].category) {
                        return Container(
                          width: constraints.maxHeight / 1.4 / 3,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                              right: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ),
                          padding: const EdgeInsets.all(4),
                          child: Text(data[index + 1].category,
                              style: const TextStyle(
                                  fontSize: 9, fontWeight: FontWeight.bold)),
                        );
                      }
                      return const SizedBox();
                    },
                    children: data
                        .mapIndexed((index, element) => Row(
                              children: [
                                Container(
                                    width: constraints.maxHeight / 1.4 / 3,
                                    padding: const EdgeInsets.all(2),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            width: 1,
                                            color:
                                                Color.fromARGB(255, 0, 0, 0)),
                                        right: BorderSide(
                                            width: 1,
                                            color:
                                                Color.fromARGB(255, 0, 0, 0)),
                                      ),
                                    ),
                                    child: Text(
                                      data[index].name,
                                      style: const TextStyle(fontSize: 8.8),
                                    )),
                              ],
                            ))
                        .toList()),
              ],
            )),
      );
    }));
  }
}
