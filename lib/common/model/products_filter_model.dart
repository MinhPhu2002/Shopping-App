import 'package:testapp/core/values/sort_product_by.dart';

class ProductsFilterModel {
  final String? sortBy;
  final String? order;
  final String? priceName;

  ProductsFilterModel({this.sortBy, this.order, this.priceName});

  ProductsFilterModel sort({SortProductBy? sortProductBy}) {
    return ProductsFilterModel(
      sortBy: sortProductBy?.fieldName,
      order: switch (sortProductBy) {
        SortProductBy.pricinginAscending ||
        SortProductBy.pricinginDescending =>
          sortProductBy?.pricingOder?.value,
        SortProductBy.titleinAscending => sortProductBy?.titleOder?.value,
        _ => null,
      },
      priceName: priceName,
    );
  }

  ProductsFilterModel filter({String? priceFrom, String? priceTo}) {
    return ProductsFilterModel(
      sortBy: sortBy,
      order: order,
      priceName: priceFrom == null && priceTo == null
          ? priceName
          : '${priceFrom ?? ''}-${priceTo ?? ''}',
    );
  }
}
