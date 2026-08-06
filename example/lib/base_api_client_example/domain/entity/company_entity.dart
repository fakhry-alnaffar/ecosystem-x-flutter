import 'package:flutter/foundation.dart';

@immutable
class CompanyEntity {
  final String name;
  final String catchPhrase;
  final String bs;

  const CompanyEntity({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompanyEntity &&
          name == other.name &&
          catchPhrase == other.catchPhrase &&
          bs == other.bs;

  @override
  int get hashCode => Object.hash(name, catchPhrase, bs);
}
