extension JsonParserExtensions on Map<String, dynamic> {
  String? parseOptionalString(String field, {String? contextName}) {
    final value = this[field];
    final prefix = contextName != null ? '$contextName.' : '';
    if (value == null) return null;
    if (value is String) return value.trim();
    throw FormatException('$prefix$field must be a string or null');
  }

  String parseRequiredString(String field, {String? contextName}) {
    final value = this[field];
    final prefix = contextName != null ? '$contextName.' : '';
    if (value is! String || value.trim().isEmpty) {
      throw FormatException('$prefix$field must be a non-empty string');
    }
    return value.trim();
  }

  DateTime parseRequiredDateTime(String field, {String? contextName}) {
    final value = this[field];
    final prefix = contextName != null ? '$contextName.' : '';
    if (value is! String) {
      throw FormatException('$prefix$field must be a timestamp string');
    }
    final date = DateTime.tryParse(value);
    if (date == null) {
      throw FormatException('$prefix$field is not a valid timestamp');
    }
    return date;
  }

  double parseNonNegativeDouble(String field, {String? contextName}) {
    final value = this[field];
    final prefix = contextName != null ? '$contextName.' : '';
    if (value is! num || !value.isFinite || value < 0) {
      throw FormatException('$prefix$field must be a non-negative number');
    }
    return value.toDouble();
  }
}
