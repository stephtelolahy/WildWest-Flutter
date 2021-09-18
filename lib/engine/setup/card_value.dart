class ResCardValue {
  final String name;
  final String value;

  ResCardValue.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        value = json['value'];
}
