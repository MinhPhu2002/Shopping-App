import 'package:testapp/core/values/oder_by.dart';

enum SortProductBy {
  pricinginAscending,
  pricinginDescending,
  titleinAscending;

  String get fieldName {
    return switch (this) {
      SortProductBy.pricinginAscending ||
      SortProductBy.pricinginDescending =>
        'price',
      SortProductBy.titleinAscending => 'title',
    };
  }

  OderBy? get pricingOder {
    if (this == SortProductBy.pricinginAscending) return OderBy.ascending;
    if (this == SortProductBy.pricinginDescending) return OderBy.descending;
    return null;
  }

  OderBy? get titleOder {
    if (this == SortProductBy.titleinAscending) return OderBy.ascending;
    return null;
  }
}
