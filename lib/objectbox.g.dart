// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_sync_flutter_libs/objectbox_sync_flutter_libs.dart';

import 'models/stock.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 2285907381818768019),
      name: 'Stock',
      lastPropertyId: const IdUid(9, 4010721059192533731),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 7091697337229250635),
            name: 'id',
            type: 6,
            flags: 129),
        ModelProperty(
            id: const IdUid(2, 5972376349027978318),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 2993898285405302121),
            name: 'desc',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 9076521467577890943),
            name: 'totalPrice',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 122495542502483195),
            name: 'partname',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 869474652187445397),
            name: 'count',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 4010721059192533731),
            name: 'stockHistory',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(3, 6837779520086823155),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [79178292374298352, 6837779520086823155],
      retiredIndexUids: const [],
      retiredPropertyUids: const [
        5029163725945625190,
        3560275596537295878,
        8226533979625104142,
        2333710559535321770,
        3914074710970127131,
        4504594082210174508,
        6741699394503551069,
        3284328700893342354,
        8827132622826361588,
        8213100152163339616,
        7787090014640875596
      ],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Stock: EntityDefinition<Stock>(
        model: _entities[0],
        toOneRelations: (Stock object) => [],
        toManyRelations: (Stock object) => {},
        getId: (Stock object) => object.id,
        setId: (Stock object, int id) {
          object.id = id;
        },
        objectToFB: (Stock object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          final descOffset = fbb.writeString(object.desc);
          final partnameOffset = fbb.writeString(object.partname);
          final stockHistoryOffset = fbb.writeString(object.stockHistory);
          fbb.startTable(10);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addOffset(2, descOffset);
          fbb.addFloat64(5, object.totalPrice);
          fbb.addOffset(6, partnameOffset);
          fbb.addInt64(7, object.count);
          fbb.addOffset(8, stockHistoryOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Stock(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              stockHistory: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 20, ''),
              partname: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 16, ''),
              name: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              desc: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''),
              count:
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 18, 0),
              totalPrice: const fb.Float64Reader()
                  .vTableGet(buffer, rootOffset, 14, 0));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Stock] entity fields to define ObjectBox queries.
class Stock_ {
  /// see [Stock.id]
  static final id = QueryIntegerProperty<Stock>(_entities[0].properties[0]);

  /// see [Stock.name]
  static final name = QueryStringProperty<Stock>(_entities[0].properties[1]);

  /// see [Stock.desc]
  static final desc = QueryStringProperty<Stock>(_entities[0].properties[2]);

  /// see [Stock.totalPrice]
  static final totalPrice =
      QueryDoubleProperty<Stock>(_entities[0].properties[3]);

  /// see [Stock.partname]
  static final partname =
      QueryStringProperty<Stock>(_entities[0].properties[4]);

  /// see [Stock.count]
  static final count = QueryIntegerProperty<Stock>(_entities[0].properties[5]);

  /// see [Stock.stockHistory]
  static final stockHistory =
      QueryStringProperty<Stock>(_entities[0].properties[6]);
}
