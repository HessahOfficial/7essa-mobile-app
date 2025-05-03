import 'package:bloc/bloc.dart';
import 'package:hessa/constants/transaction_data.dart';
import 'package:hessa/features/wallet/data/models/transaction_model.dart';
import 'package:meta/meta.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(TransactionInitial());

  List<TransactionModel> transactionList =
      transactions
          .where((transaction) => transaction.category == "Expense")
          .toList();

  bool expensesTapped = true;

  void loadExpensesList() {
    emit(TransactionLoading());
    try {
      transactionList =
          transactions
              .where((transaction) => transaction.category == "Expense")
              .toList();
      expensesTapped = true;
      emit(TransactionSuccess());
    } catch (e) {
      emit(TransactionFailure(message: "Failed to fetch expenses list!"));
    }
  }

  void loadIncomesList() {
    emit(TransactionLoading());
    try {
      transactionList =
          transactions
              .where((transaction) => transaction.category == "Income")
              .toList();
      expensesTapped = false;
      emit(TransactionSuccess());
    } catch (e) {
      emit(TransactionFailure(message: "Failed to fetch incomes list!"));
    }
  }
}
