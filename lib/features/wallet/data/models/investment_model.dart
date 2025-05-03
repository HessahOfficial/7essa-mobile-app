import 'package:flutter/material.dart';

class Investment {
  final String propertyName;
  final double amount; // In EGP
  final Color color;

  Investment({
    required this.propertyName,
    required this.amount,
    required this.color,
  });
}
