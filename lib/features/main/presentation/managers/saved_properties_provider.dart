import 'package:flutter/material.dart';

class SavedPropertiesProvider with ChangeNotifier {
   final List<Map<String, dynamic>> _savedProperties = [];

  List<Map<String, dynamic>> get savedProperties => _savedProperties;

  bool isPropertySaved(Map<String, dynamic> property) {
    return _savedProperties.any((saved) =>
    saved['name'] == property['name'] &&
        saved['price'] == property['price'] &&
        saved['size'] == property['size']);
  }

  // void toggleSaveProperty(Map<String, dynamic> property) {
  //   // Ensure all required fields are present
  //   if (property['name'] == null ||
  //       property['price'] == null ||
  //       property['size'] == null
  //   //||
  //       // property['bedrooms'] == null ||
  //       // property['bathrooms'] == null
  //       ) {
  //     print('Invalid property: $property');
  //     return;
  //   }
  //
  //   final existingProperty = _savedProperties.firstWhere(
  //         (saved) =>
  //     saved['name'] == property['name'] &&
  //         saved['price'] == property['price'] &&
  //         saved['size'] == property['size'],
  //     orElse: () => <String, dynamic>{},
  //   );
  //
  //   if (existingProperty.isNotEmpty) {
  //     _savedProperties.remove(existingProperty);
  //   } else {
  //     _savedProperties.add(Map<String, dynamic>.from(property)); // Create a copy
  //   }
  //   notifyListeners();
  //   print('Saved properties: $_savedProperties');
  //   print(' properties: $savedProperties');
  // }
   void toggleSaveProperty(Map<String, dynamic> property) {
     if (property['name'] == null || property['price'] == null || property['size'] == null) {
       print('Invalid property: $property');
       return;
     }

     final existingProperty = _savedProperties.firstWhere(
           (saved) =>
       saved['name'] == property['name'] &&
           saved['price'] == property['price'] &&
           saved['size'] == property['size'],
       orElse: () => <String, dynamic>{},
     );

     if (existingProperty.isNotEmpty) {
       _savedProperties.remove(existingProperty);
     } else {
       _savedProperties.add(Map<String, dynamic>.from(property)); // Create a copy
     }
     notifyListeners();
     print('Saved properties: $_savedProperties');
   }
}