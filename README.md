
> ⚠️ Testing project for Flutter API

 ### 🛠 Mapping objects (Phone, Message, Character classes)
 2 types - JSON and Firestore
 <pre> 
 factory Phone.fromJson(Map<String, dynamic> json){
    return Phone(
      id: json["id"] as String?,
      name: json['name'] as String,
      data: json['data'] != null ? Map<String, dynamic>.from(json['data']) : null
    );
  }

  factory Phone.fromFirestore(DocumentSnapshot doc){
    final json = doc.data() as Map<String, dynamic>;
    return Phone(
      id: doc.id,
      name: json['name'],
      data: json["data"]
    );
  }
</pre>
Transfering object to Map
<pre> 
  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'name': name,
      'data': data
    };
  }
 </pre>

Getting from json for Message and Character classes
<pre> 
factory Message.fromJson(Map<String, dynamic> json){
    return Message(
      id: json["id"],
      title: json["title"],
      content: json["content"],
      user: json['user'] != null
          ? User.fromJson(json['user'])
          : null,
    );
  }
  factory Character.fromJson(Map<String, dynamic> json){
    print(json['id']);
    return Character(
      id: json['id'] is int ? json['id'] : int.parse(json['id']),
      name: json['name'] as String,
      appearance: json['appearance'] != null ? Map<String, String>.from(json['appearance']) : null
    );
  }
 </pre>
 

 
 ### 🛠 Service (Phone for json)
- GET
<pre>
  static Future<List<Phone>> getPhones() async{
    final url = Uri.parse("${Config.baseUrl}/phones");
    final response = await http.get(url);

    if(response.statusCode == 200){
      final List decoded = jsonDecode(response.body);
      return decoded.map((json) => Phone.fromJson(json)).toList();
    } else {
      throw Exception("Błąd API: ${response.statusCode}");
    }
  }
</pre>

- GET BY ID
<pre>
   static Future<Phone> getPhoneById(String id) async {
    final url = Uri.parse('${Config.baseUrl}/phones/${id}');
    final response = await http.get(url);
    if(response.statusCode == 200){
      final Map<String, dynamic> decode = jsonDecode(response.body);
      return Phone.fromJson(decode);
    } else {
      throw Exception("Błąd API: ${response.statusCode}");
    }
  }
</pre>
- POST
<pre>
  static Future<Phone> savePhone(Phone phone) async {
    phone.id = Uuid().v4().substring(0,8);
    print(phone.id);
    final url = Uri.parse('${Config.baseUrl}/phones');
    final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(phone.toMap()),
    );
    if(response.statusCode == 200 || response.statusCode == 201){
      final Map<String, dynamic> decoded = jsonDecode(response.body);
      return Phone.fromJson(decoded);
    } else {
      throw Exception("Błąd API: ${response.statusCode}");
    }
  }
</pre>
- PUT
<pre>
  static Future<Phone> editPhone(Phone phone) async {
    final url = Uri.parse("${Config.baseUrl}/phones/${phone.id}");
    final response = await http.put(
        url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(phone.toMap())
    );
    if(response.statusCode == 200) {
      final Map<String, dynamic> decoded = jsonDecode(response.body);
      return Phone.fromJson(decoded);
    } else {
      throw Exception("Błąd API: ${response.statusCode}");
    }
  }
</pre>
- DELETE
<pre>
  static Future<void> deletePhone(String id) async {
    final url = Uri.parse('${Config.baseUrl}/phones/$id');
    final response = await http.delete(url);

    if(response.statusCode != 200 && response.statusCode != 204) {
      throw Exception("Błąd API: ${response.statusCode}");
    }
  }
</pre>

 ### 🛠 Service (Phone for Firestore)
 - GET
<pre>
  static Future<List<Phone>> getPhones() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('phones').get();
    return snapshot.docs.map((doc){
      return Phone.fromFirestore(doc);
    }).toList();
  }
</pre>

- GET BY ID
<pre>
   static Future<Phone?> getPhoneByID(String id) async {
    final DocumentSnapshot doc = await FirebaseFirestore.instance.collection('phones').doc(id).get();
    if(!doc.exists) return null;
    return Phone.fromFirestore(doc);
  }
</pre>

- POST
<pre>
  static Future<void> savePhone(Phone phone) async{
    await FirebaseFirestore.instance
        .collection('phones')
        .add(phone.toMap());
  }
</pre>

- PUT
<pre>
  static Future<void> editPhone(Phone phone) async {
    await FirebaseFirestore.instance
      .collection('phones')
      .doc(phone.id)
      .set(phone.toMap());
  }
</pre>

- DELETE
<pre>
    static Future<void> deletePhone(String id) async{
    await FirebaseFirestore.instance
        .collection('phones')
        .doc(id)
        .delete();
  }
</pre>
