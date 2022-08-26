import 'package:meta/meta.dart';
import 'dart:convert';

MapData mapDataFromJson(String str) => MapData.fromJson(json.decode(str));

String mapDataToJson(MapData data) => json.encode(data.toJson());

class MapData {
  MapData({
    required this.status,
    required this.data,
  });
  late final int status;
  late final List<Data> data;

  MapData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.uuid,
    required this.displayName,
    required this.coordinates,
    this.displayIcon,
    required this.listViewIcon,
    required this.splash,
    required this.assetPath,
    required this.mapUrl,
  });
  late final String uuid;
  late final String displayName;
  late final String coordinates;
  late final String? displayIcon;
  late final String listViewIcon;
  late final String splash;
  late final String assetPath;
  late final String mapUrl;

  Data.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    displayName = json['displayName'];
    coordinates = json['coordinates'];
    displayIcon = null;
    listViewIcon = json['listViewIcon'];
    splash = json['splash'];
    assetPath = json['assetPath'];
    mapUrl = json['mapUrl'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['uuid'] = uuid;
    _data['displayName'] = displayName;
    _data['coordinates'] = coordinates;
    _data['displayIcon'] = displayIcon;
    _data['listViewIcon'] = listViewIcon;
    _data['splash'] = splash;
    _data['assetPath'] = assetPath;
    _data['mapUrl'] = mapUrl;
    return _data;
  }
}
