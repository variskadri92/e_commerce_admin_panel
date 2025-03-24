import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsModel {
  final String? id;
  double taxRate;
  double shippingCost;
  double? freeShippingLimit;
  String appName;
  String appLogo;

  SettingsModel({
    this.id,
    this.taxRate = 0.0,
    this.shippingCost = 0.0,
    this.freeShippingLimit,
    this.appName = '',
    this.appLogo = '',
  });

  Map<String, dynamic> toJson(){
    return {
      'taxRate': taxRate,
      'shippingCost': shippingCost,
      'freeShippingLimit': freeShippingLimit,
      'appName': appName,
      'appLogo': appLogo,
    };
  }

  factory SettingsModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    if(document.data() != null){
      final data = document.data()!;
      return SettingsModel(
        id: document.id,
        taxRate: (data['taxRate'] as num?)?.toDouble() ?? 0.0,
        shippingCost: (data['shippingCost'] as num?)?.toDouble() ?? 0.0,
        freeShippingLimit: (data['freeShippingLimit'] as num?)?.toDouble() ?? 0.0,
        appName: data.containsKey('appName') ? data['appName'] : '',
        appLogo: data.containsKey('appLogo') ? data['appLogo'] : '',
      );
    }else{
      return SettingsModel();
    }
  }
}
