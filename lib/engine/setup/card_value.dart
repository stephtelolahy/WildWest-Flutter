class CardValue {
  final String name;
  final String value;

  CardValue({
    required this.name,
    required this.value,
  });

  CardValue.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        value = json['value'];
}
