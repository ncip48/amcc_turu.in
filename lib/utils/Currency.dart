// ignore_for_file: file_names

import 'package:intl/intl.dart';

formatRupiah(int value) {
  final formatCurrency =
      NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0);
  return formatCurrency.format(value);
}
