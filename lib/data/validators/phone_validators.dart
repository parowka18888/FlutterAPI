class PhoneValidators{

  static String? validatePrice(String? value){
    if(value == null || value.isEmpty) return null;

    double? price = double.tryParse(value);
    if(price == null || price < 0){
      return 'Nieprawidłowa cena';
    } else {
      return null;
    }
  }

  static String? validateName(String? value) {
    if(value == null || value.isEmpty) return 'Nazwa jest wymagana';
    return null;
  }

  static String? validateColor(String? value){
    if(value == null || value.isEmpty) return null;
    final regExp = RegExp(r'^[a-zA-ZąćęłńóśźżĄĆĘŁŃÓŚŹŻ\s]+$');
    if(!regExp.hasMatch(value)){
      return 'Nieprawidłowy kolor';
    } else {
      return null;
    }
  }

  static String? validateNumber(String? value){
    if(value == null || value.isEmpty) return null;
    int? number = int.tryParse(value);
    if(number == null || number < 0){
      return 'Niepoprawna wartość liczbowa';
    } else {
      return null;
    }
  }



}