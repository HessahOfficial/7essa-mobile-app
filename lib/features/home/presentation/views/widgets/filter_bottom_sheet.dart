import 'package:flutter/material.dart';
import 'package:hessa/features/home/data/models/filter_option_model.dart';

class FilterBottomSheet extends StatefulWidget {
  final FilterOptions initialOptions;
  final Function(FilterOptions) onApply;

  const FilterBottomSheet({
    super.key,
    required this.initialOptions,
    required this.onApply,
  });

  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late double _maxSize;
  late double _minPrice;
  late double _maxPrice;

  @override
  void initState() {
    super.initState();
    _maxSize = widget.initialOptions.maxSize;
    _minPrice = widget.initialOptions.minPrice;
    _maxPrice = widget.initialOptions.maxPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Text(
            'Filter',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            'Property Size',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Up to ${(_maxSize.round() / 1000).toStringAsFixed(1)}K sqft',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
          Slider(
            value: _maxSize,
            min: 0,
            max: 5000,
            divisions: 50,
            activeColor: const Color(0xFF4B5EFC),
            inactiveColor: Colors.grey[300],
            onChanged: (value) {
              setState(() {
                _maxSize = value;
              });
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Property Price',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'LOW',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              Text(
                'HIGH',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
          RangeSlider(
            values: RangeValues(_minPrice, _maxPrice),
            min: 0,
            max: 50000,
            divisions: 50,
            activeColor: const Color(0xFF4B5EFC),
            inactiveColor: Colors.grey[300],
            labels: RangeLabels(
              '${(_minPrice.round() / 1000).toStringAsFixed(1)}K',
              '${(_maxPrice.round() / 1000).toStringAsFixed(1)}K',
            ),
            onChanged: (RangeValues values) {
              setState(() {
                _minPrice = values.start;
                _maxPrice = values.end;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(75, 94, 252, 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '\$${_minPrice.round()}',
                  style: TextStyle(
                    color: Color(0xFF4B5EFC),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(75, 94, 252, 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '\$${_maxPrice.round()}',
                  style: TextStyle(
                    color: Color(0xFF4B5EFC),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _maxSize = 5000;
                    _minPrice = 0;
                    _maxPrice = 50000;
                  });
                },
                child: Text(
                  'Reset',
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  widget.onApply(
                    FilterOptions(
                      maxSize: _maxSize,
                      minPrice: _minPrice,
                      maxPrice: _maxPrice,
                    ),
                  );
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4B5EFC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text(
                  'Apply',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
