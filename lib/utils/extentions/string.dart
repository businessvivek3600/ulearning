extension StringExt on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get isEmail =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this!);
}
