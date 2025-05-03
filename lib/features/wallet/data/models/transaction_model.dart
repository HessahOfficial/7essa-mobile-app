class TransactionModel {
  final String type; // "Pay Shares" or "Fees"
  final String date;
  final String currency;
  final double amount;
  final String category;
  final String? propertyName; // For "Pay Shares"

  TransactionModel({
    required this.type,
    required this.date,
    required this.currency,
    required this.amount,
    required this.category,
    this.propertyName,
  });

  @override
  String toString() {
    return "Transaction: {\ntype: $type,\n date: $date,\n amount: $amount,\n category: $category,\n propertyName: $propertyName,\n currency: $currency\n}\n";
  }
}
