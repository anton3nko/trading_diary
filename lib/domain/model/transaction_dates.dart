class TransactionDates {
  DateTime? openDate;
  DateTime? closeDate;

  TransactionDates({this.openDate, this.closeDate});

  void resetDates() {
    openDate = null;
    closeDate = null;
  }
}
