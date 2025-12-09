class Phone{
  late final String name;
  late final Map<String, dynamic>? data;

  Phone({
    required this.name,
    this.data
  });

  factory Phone.fromJson(Map<String, dynamic> json){
    return Phone(
      name: json['name'] as String,
      data: json['data'] != null ? Map<String, dynamic>.from(json['data']) : null
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'data': data
    };
  }

}