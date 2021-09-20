class CardValue {
  final String name;
  final String value;

  CardValue.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        value = json['value'];
}
