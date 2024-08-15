import 'package:testapp/core/values/sort_product_by.dart';

class ProductsFilterModel {
  final String? sortBy;
  final String? order;
  final String? priceName;

  ProductsFilterModel({this.sortBy, this.order, this.priceName});

  ProductsFilterModel copyWith(
      {SortProductBy? sortProductBy, String? priceFrom, String? priceTo}) {
    return ProductsFilterModel(
      sortBy: sortProductBy?.fieldName ?? sortBy,
      order: switch (sortProductBy) {
        SortProductBy.pricinginAscending ||
        SortProductBy.pricinginDescending =>
          sortProductBy?.pricingOder?.value,
        SortProductBy.titleinAscending => sortProductBy?.titleOder?.value,
        _ => order,
      },
      priceName: priceFrom == null && priceName == null
          ? priceName
          : '${priceFrom ?? ''}-${priceTo ?? ''}',
    );
  }
}
