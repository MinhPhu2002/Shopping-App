enum OderBy {
  ascending(value: 'asc'),

  descending(value: 'desc');

  final String value;

  const OderBy({required this.value});
}
