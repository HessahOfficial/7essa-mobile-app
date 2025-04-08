import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hessa/saved_properties_provider.dart';

class SavedPropertiesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //make the title centered
        centerTitle: true,
        title: Text('Saved Properties'),
        automaticallyImplyLeading: false,
      ),
      body: Consumer<SavedPropertiesProvider>(
        builder: (context, provider, child) {
          final savedProperties = provider.savedProperties;
          print('saved properties: $savedProperties');

          if (savedProperties.isEmpty) {
            return Center(child: Text('No saved properties yet'));
          }

          return ListView.builder(
            itemCount: savedProperties.length,
            itemBuilder: (context, index) {
              return PropertyCard(property: savedProperties[index]);
            },
          );
        },
      ),
    );
  }
}

class PropertyCard extends StatelessWidget {
  final Map<String, dynamic> property;

  const PropertyCard({required this.property});

  @override
  Widget build(BuildContext context) {
    final String name = property['name'] ?? 'Unknown Property';
    final String price = property['price']?.toString() ?? 'N/A';
    final String size = property['size']?.toString() ?? 'N/A';
    final String bedrooms = property['bedrooms']?.toString() ?? 'N/A';
    final String bathrooms = property['bathrooms']?.toString() ?? 'N/A';

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(name),
        subtitle: Text('$price LE / share'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.square_foot, size: 20),
            Text('$size sqft'),
            SizedBox(width: 8),
            Icon(Icons.king_bed, size: 20),
            Text(bedrooms),
            SizedBox(width: 8),
            Icon(Icons.bathtub, size: 20),
            Text(bathrooms),
          ],
        ),
      ),
    );
  }
}