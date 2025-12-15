class Character{
  final int id;
  String name;
  Map<String, String>? appearance;

  Character({
    required this.id,
    required this.name,
    this.appearance,
  });

  factory Character.fromJson(Map<String, dynamic> json){
    print(json['id']);
    return Character(
      id: json['id'] is int ? json['id'] : int.parse(json['id']),
      name: json['name'] as String,
      appearance: json['appearance'] != null ? Map<String, String>.from(json['appearance']) : null
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id.toString(),
      'name': name,
      'appearance': appearance
    };
  }


}